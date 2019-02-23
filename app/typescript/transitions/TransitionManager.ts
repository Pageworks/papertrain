import Env from '../env';
import * as transitions from './transitions';
import Pjax from 'fuel-pjax';
import App from '../App';

export default class TransitionManager {

    private _app:                   App;
    private _env:                   Env;
    private _transitions:           { [index:string] : Function };
    private _transition:            Transition;
    private _pjax:                  Pjax;
    private _isDebug:               boolean;

    constructor(app:App){
        this._app           = app;
        this._env           = this._app.env;
        this._isDebug       = this._env.getDebugStatus();
        this._transitions   = transitions;
        this._transition    = null;

        this._pjax          = new Pjax({ debug: this._isDebug, selectors: [`${Env.PJAX_CONTAINER}`] });

        this.init();
    }

    /**
     * Declare all initial event listeners
     * By default `pjax:prefetch` and `pjax:cancel` do nothing but they are available if needed
     */
    public init(): void{
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
    private load(): void{
        Env.HTML.classList.add('dom-is-loaded');
        Env.HTML.classList.remove('dom-is-loading');

        setTimeout(()=>{ Env.HTML.classList.add('dom-is-animated') }, App.ANIMATION_DELAY);
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
    private launchTransition(e:CustomEvent): void{
        let transition  = 'BaseTransition';

        if(e.detail !== undefined){
            const el    = e.detail.el;
            transition  = (el.getAttribute('data-transition') !== null) ? el.getAttribute('data-transition') : 'BaseTransition';
        }

        Env.HTML.setAttribute('data-transition', transition);

        this._transition = new this._transitions[transition].prototype.constructor();

        Env.HTML.classList.remove('dom-is-loaded', 'dom-is-animated');
        Env.HTML.classList.add('dom-is-loading');

        this._transition.launch();
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
    private endTransition(e:Event): void{
        const templateName = this.getTemplateName();

        if(this._isDebug){
            console.log('%c[view] '+`%cDisplaying: ${templateName}`,'color:#ecc653','color:#eee');
        }

        Env.HTML.classList.add('dom-is-loaded');
        Env.HTML.classList.remove('dom-is-loading');

        setTimeout(()=>{ Env.HTML.classList.add('dom-is-animated') }, App.ANIMATION_DELAY);

        if(templateName === 'home'){
            Env.HTML.classList.add('is-homepage');
        }
        else{
            Env.HTML.classList.remove('is-homepage');
        }

        if(this._transition === null){
            return;
        }

        // Tell our transition it can end the transition
        this._transition.hide();

        // Tell our main applicaiton it can init any new modules
        this._app.initModules();

        // Tell our main applicaiton it can delete any old modules
        this._app.deleteModules();

        // Tell our main application it can update touch elements
        this._app.updateTouchElements();

        // Reset for next transition
        this.reinit();
    }

    /**
     * Gets the first element with a `data-template` attribute.
     * If the element exists get the template name.
     * Return the templates name or our missing name value.
     * @returns string
     */
    private getTemplateName(): string{
        let templateName = 'MISSING_TEMPLATE_NAME';

        const templateEl = Env.HTML.querySelector('[data-template]');

        if(templateEl){
            templateName = templateEl.getAttribute('data-template');
        }

        return templateName;
    }

    /**
     * Called when we've finished our transition
     * Resets our transition object and the DOM's `data-transition` attribute
     */
    private reinit(): void{
        Env.HTML.setAttribute('data-transition', '');
        this._transition = null;
        console.log('Transition renit');
    }
}
