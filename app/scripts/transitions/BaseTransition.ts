import { APP_NAME, pjaxWrapper, pjaxContainer, html, isDebug } from '../utils/env';

const MODULE_NAME = 'Transition';

import TransitionManager from './TransitionTypes'

class Transition{

    constructor(){ }

    /**
     * Called by the TransitionManager when Pjax is switching pages
     */
    launch(){
        // Handle custom transition effects

        // Call when transition is finished
        this.launchFinished();
    }

    /**
     * Called when the base transition is finished hiding the page/content
     * Sends a `pjax:continue` event
     * This is used when Pjax is listening for a custom transition
     * @see https://github.com/Pageworks/fuel-pjax#pjax-options
     */
    launchFinished(){
        const e = new Event('pjax:continue');
        document.dispatchEvent(e);
    }

    /**
     * Call by the TransitionManager when Pjax has switched pages
     */
    hide(){
        // Handle custom transition effects

    }
}

export { Transition as default };