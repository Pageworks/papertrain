import { Module } from 'Module';
import { Application } from 'Application';
import { Env } from 'Env';

export class REPLACE_ME extends Module{
    public static index:string = 'REPLACE_ME';

    constructor(view:HTMLElement, uuid:string){
        super(view, uuid);
        if(Env.isDebug){
            console.log('%c[Module Manager] '+`%ccreated new %c${ REPLACE_ME.index } %cmodule with an ID of %c${ uuid }`,'color:#4882fd','color:#eee','color:#48eefd','color:#eee','color:#48eefd');
        }
    }

    afterMount(){

    }

    beforeDestroy(){

    }
}

// Adds module to the global Modules object
modules[REPLACE_ME.index] = REPLACE_ME;
if(Env.isDebug){
    console.log('%c[Module Manager] '+`%cmodule %c${ REPLACE_ME.index } %chas finished loading`,'color:#4882fd','color:#eee', 'color:#48eefd', 'color:#eee');
}
Application.mountModules();
