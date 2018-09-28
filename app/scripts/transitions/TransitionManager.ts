import { APP_NAME, $pjaxWrapper, $pjaxContainer, $html, isDebug } from '../utils/env';

import * as transitions from './transitions';

import * as PJAX from 'pjax';

class TransitionManager {
    transitions:{ [index:string] : Function };
    transition: Transition;
    wrapper: Element;
    options: PJAX.IOptions;
    pjax: PJAX;
    initialAnimationDelay: number;

    constructor(){
        this.transitions            = transitions;
        this.transition             = null;
        this.initialAnimationDelay  = 1000;

        /**
         * -- PJAX CONFIG --
         */
        this.wrapper = document.querySelector($pjaxWrapper);
        this.options = {
            debug: isDebug,
            elements: 'a:not(.no-transition)',
            selectors: ['title', $pjaxContainer],
            switches: {},
            prefetch: true,
            cacheBust: false
        }
        this.options.switches[$pjaxContainer] = (oldEl, newEl) => this.switch(oldEl, newEl);
        this.pjax = new PJAX(this.options);

        this.init();
    }

    switch(oldView: Element, newView:Element){
        this.transition.hideView(oldView, newView);
    }

    /**
     * Declare all initial event listeners
     */
    init(){
        window.addEventListener('load', e => { this.load() });

        // Listen for the pjax events
        if(!this.pjax.options.prefetch) document.addEventListener('pjax:send', e => this.send(e) );
        else{
            document.addEventListener('pjax:prefetch', e => this.prefetch(e) );
            document.addEventListener('pjax:prefetchRequested', e => this.prefetchRequested(e) );
            document.addEventListener('pjax:loadingCached', e => this.loadingCached(e) );
        }

        document.addEventListener('pjax:404', e => this.handleError(e) );

        // Listen for our events
        document.addEventListener('removeView', e => this.remove(e) );
        document.addEventListener('resetTransitions', e => this.reinit() );
    }

    handleError(e: Event){
        if(isDebug) console.log('%cPage Transition Error: '+'%cpage request returned 404','color:#ff6e6e','color:#eee');
    }

    load(){
        $html.classList.add('dom-is-loaded');
        $html.classList.remove('dom-is-loading');
        
        setTimeout(()=>{ $html.classList.add('dom-is-animated') }, this.initialAnimationDelay);
    }

    launchRequest(e: any){
        const el            = e.triggerElement;
        const transition    = (el.getAttribute('data-transition') !== null) ? el.getAttribute('data-transition') : 'BaseTransition';

        $html.setAttribute('data-transition', transition);

        this.transition = new this.transitions[transition].prototype.constructor({
            wrapper: this.wrapper,
            clickedLink: el,
            manager: this
        });
    }

    /**
     * Launch when pjax recieves a non-prefetch request
     * Launch the request and begin transition animation
     * @param e event
     */
    send(e: Event){
        this.launchRequest(e);
        this.transition.launch();
    }

    /**
     * Launche when pjax recieves a prefetch request
     * @param e event
     */
    prefetch(e: Event){
        this.launchRequest(e);
    }


    /**
     * Launch when the prefetch request is still loading but the user
     * confirmed that they want to transition to the requested page
     * Begin page transition animation
     * @param e event
     */
    prefetchRequested(e: Event){
        this.transition.launch();
    }

    /**
     * Launch when the user wants to transition to a cached request
     * Begin page transition animation
     * @param e event
     */
    loadingCached(e: Event){
        this.transition.launch();
    }
    
    /**
     * @todo Look through element and child nodes for `data-template`
     * @todo Console.log the change if in debug
     * @todo Update $html with our active template attribute data-active
     * @param newView element
     */
    getTemplateName(newView: Element){
        return 'MISSING_TEMPLATE_NAME'
    }

    /**
     * Called by the remove method
     * Switches out the inner HTML
     * Call the init modules method in our main application
     * Calls onSwitch for pjax
     * Tells the transition that we've switched the content and it can end the transition
     * @param newView element
     */
    display(newView: Element){
        const templateName = this.getTemplateName(newView);

        if(isDebug) console.log('%c[view] '+'%cdisplaying: ${templateName}','color:#4688f2','color:#eee');

        if(templateName === 'home') $html.classList.add('is-homepage');
        else $html.classList.remove('is-homepage');
        
        this.wrapper.innerHTML = newView.outerHTML;

        // Tell the app it's okay to init any new modules
        const event = new Event('initModules');
        document.dispatchEvent(event);

        /**
         * Switches old elements with new elements
         * @see pjax
         */
        this.pjax.onSwitch();

        this.transition.displayView(newView);
    }

     /**
     * Returns the detail value if the event is a CustomEvent
     * @param e event
     */
    getCustomEvent(e: Event): e is CustomEvent{
        return 'detail' in e;
    }

    /**
     * Called by a transition class
     * Removes the element
     * Calls the delete modules method in our main application
     * Passes our new view into the display method
     * @param oldView element
     * @param newView element
     */
    remove(e: Event){
        let detail = null;
        if(this.getCustomEvent(e)) detail = e.detail;
        else{
            if(isDebug) console.log('%cPage Transition Error: '+'%cevent was not a custom event','color:#ff6e6e','color:#eee');
            return;
        }

        const templateName = this.getTemplateName(detail.o);

        if(isDebug) console.log('%c[view] '+'%chiding: ${templateName}','color:#ff6e6e','color:#eee');

        detail.o.remove();

        // Tell the app to delete modules
        const event = new Event('deleteModules');
        document.dispatchEvent(event);

        this.display(detail.n);
    }

    reinit(){
        this.transition.destroy();
        $html.setAttribute('data-transition', '');
        this.transition = null;
    }
}

export { TransitionManager as default }