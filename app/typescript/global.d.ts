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

interface EasingObject{
    ease:   string;
    in:     string;
    out:    string;
    sharp:  string;
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
    env:                    Env;
}

declare class Env{
    setDebug:       Function;
    getDebugStatus: Function;
    HTML:           HTMLElement;
    BODY:           HTMLElement;
    PJAX_CONTAINER: string;
    SCROLL_TRIGGER: number;
    APP_NAME:       string;
    EASING:         EasingObject;
}

declare class ComplexContent{
    init:                       Function;
    getComplexContentElement:   Function;
}
