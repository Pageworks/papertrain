import { APP_NAME, $pjaxWrapper, $pjaxContainer, $html, isDebug } from '../utils/env';

const MODULE_NAME = 'Transition';

export default class {
    options: TransitionOptions;

    constructor(options: object){
        this.options = options;
    }

    /**
     * Starts the page transition when called by the transition manager
     * Updates the DOMs loading and animated status
     */
    launch(){
        if(isDebug) console.log('%c-- Page Transition Launched --','color:#eee');

        $html.classList.remove('dom-is-loaded', 'dom-is-animated');
        $html.classList.add('dom-is-loading', this.options.overrideClass);
    }

    readyToRemove(oldView: Element, newView: Element){
        const event = new CustomEvent('removeView', {
            detail:{
                o: oldView,
                n: newView
            }
        });
        document.dispatchEvent(event);
    }

    readyToReset(){
        const event = new Event('resetTransitions');
        document.dispatchEvent(event);
    }

    /**
     * Gets incoming template name
     * If we're in debug mode console.log the template swap
     * Handles the initial transition (typically the hiding phase)
     * @param oldView element
     * @param newView element
     */
    hideView(oldView: Element, newView: Element){
        // Handle custom transition effects

        this.readyToRemove(oldView, newView);// Call when ready to launch
    }

    /**
     * Called by the transition manager once it's switched out the page content
     * and we're ready to end the page transition
     * Updates the DOMs loading and animated status
     * Calls the transition managers reinit method
     * @param newView element
     */
    displayView(newView: Element){
        $html.classList.add('dom-is-loaded');
        $html.classList.remove('dom-is-loading', this.options.overrideClass);
        
        // Put within a setTimeout if you want a delay between loaded and animated status
        $html.classList.add('dom-is-animated');

        this.readyToReset(); // Call when ready to reset the transition manager
    }

    /**
     * Transition is finished and should be destroyed
     * @todo Console.log the transitions destruction if in debug mode
     */
    destroy(){
        if(isDebug) console.log('%c-- Page Transition Ended --','color:#eee');
    }
}