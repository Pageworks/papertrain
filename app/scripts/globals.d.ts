declare module 'uuid/v4';

interface TransitionManager{
    remove: Function;
    reinit: Function;
}

/**
 * Defines the options object that is passed into a transition
 * @see BaseTransition.ts
 */
interface TransitionOptions{
    wrapper?: Element;
    clickedLink?: Element;
    overrideClass?: string;
}

/**
 * Defines the functions for our transition class
 * @see BaseTransition.ts
 */
interface Transition{
    launch: Function;
    displayView: Function;
    destroy: Function;
    hideView: Function;
}
/**
 * Defines the options object that is passed into a transition
 */
interface Module{
    index: string;
    destroy: Function;
    init: Function;
    uuid: string;
}