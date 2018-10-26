import { APP_NAME, pjaxContainer, html, isDebug } from '../env';
import * as transitions from './transitions';
import Pjax from 'fuel-pjax';

export default class TransitionManager {
    app:                    App
    transitions:            { [index:string] : Function }
    transition:             Transition
    pjax:                   Pjax
    initialAnimationDelay:  number

    constructor(app:App){
        this.app                    = app;
        this.transitions            = transitions;
        this.transition             = null;
        this.pjax                   = new Pjax({ debug: isDebug, selectors: [`${pjaxContainer}`] });

        this.initialAnimationDelay  = 1000;

        this.init();
    }

    /**
     * Declare all initial event listeners
     * By default `pjax:prefetch` and `pjax:cancel` do nothing but they are available if needed
     */
    init(){
        document.addEventListener('DOMContentLoaded', e => { this.load() }); // Listen for when the page is loaded

        document.addEventListener('pjax:error', e => this.endTransition(e) );
        document.addEventListener('pjax:send', e => this.launchTransition(<CustomEvent>e) );
        // document.addEventListener('pjax:prefetch', ()=>{ console.log('Event: pjax:prefetch'); });
        // document.addEventListener('pjax:cancel', ()=>{ console.log('Event: pjax:cancel'); } );
        document.addEventListener('pjax:complete', e => this.endTransition(e) );
    }

    /**
     * Called when the DOM has finished it's initial content load
     * Sets the base DOM status classes
     */
    load(){
        html.classList.add('dom-is-loaded');
        html.classList.remove('dom-is-loading');
        
        setTimeout(()=>{ html.classList.add('dom-is-animated') }, this.initialAnimationDelay);
    }

    /**
     * Called when Pjax fires the `pjax:send` event
     * Get the trigger element that is passed from Pjax via the CustomEvent.detail
     * Set our transition attribute based on the `data-transition` attribute of the trigger element
     * Construct our new transition
     * Update the DOM status classes
     * Launch our transition
     * @param {CustomEvent} e
     */
    launchTransition(e:CustomEvent){
        let transition  = 'BaseTransition';

        if(e.detail !== undefined){
            const el    = e.detail.el;
            transition  = (el.getAttribute('data-transition') !== null) ? el.getAttribute('data-transition') : 'BaseTransition';
        }

        html.setAttribute('data-transition', transition);

        this.transition = new this.transitions[transition].prototype.constructor();

        html.classList.remove('dom-is-loaded', 'dom-is-animated');
        html.classList.add('dom-is-loading');

        this.transition.launch();
    }

    /**
     * Called when Pjax fires `pjax:error` or `pjax:cancel` or `pjax:complete`
     * Resets DOM status classes to the default state(s)
     * Gets the templates name from `this.getTemplateName()`
     * Displays the name if we're in debug mode
     * If the template is labeled `home` set the `is-homepage` status class
     * Tells the main applicaiton it can init any new modules
     * @param {Event} e
     */
    endTransition(e:Event){
        const templateName = this.getTemplateName();

        if(isDebug) console.log('%c[view] '+`%cDisplaying: ${templateName}`,'color:#ecc653','color:#eee');

        html.classList.add('dom-is-loaded');
        html.classList.remove('dom-is-loading');
        
        setTimeout(()=>{ html.classList.add('dom-is-animated') }, this.initialAnimationDelay);

        if(templateName === 'home') html.classList.add('is-homepage');
        else html.classList.remove('is-homepage');

        // Tell our transition it can end the transition
        this.transition.hide();

        // Tell our main applicaiton it can init any new modules
        this.app.initModules();

        // Tell our main applicaiton it can delete any old modules
        this.app.deleteModules();

        // Reset for next transition
        this.reinit();
    }
    
    /**
     * Get all sections within our Pjax wrapper (article)
     * Look through elements for the first node with a `data-template` attribute
     * Return the name given to the section
     * Otherwise return 'MISSING_TEMPLATE_NAME'
     */
    getTemplateName(){
        let templateName = 'MISSING_TEMPLATE_NAME';

        const secitons = html.querySelectorAll('section');

        if(secitons){
            secitons.forEach((el)=>{
                if(el.getAttribute('data-template') !== null) templateName = el.getAttribute('data-template'); 
            });
        }

        return templateName;
    }

    /**
     * Called when we've finished our transition
     * Resets our transition object and the DOM's `data-transition` attribute
     */
    reinit(){
        html.setAttribute('data-transition', '');
        this.transition = null;
    }
}