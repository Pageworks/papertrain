declare module 'uuid/v4';
declare module 'animejs';

interface TransitionManager{
    remove: Function;
    reinit: Function;
}

interface Transition{
    launch: Function;
    hide:   Function;
}


interface Module{
    index:      string;
    destroy:    Function;
    init:       Function;
    uuid:       string;
}

declare class App{
    ANIMATION_DELAY:        number;
    initModules:            Function;
    deleteModules:          Function;
    deleteModule:           Function;
    updateTouchElements:    Function;
}