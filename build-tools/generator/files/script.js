/**
 * @class REPLACE_ME
 * @description A module for the REPLACE_NAME REPLACE_TYPE
 * @author AUTHOR_NAME
 */

import { Module } from 'Module';
import { Application } from 'Application';
import { Env } from 'Env';

export class REPLACE_ME extends Module{
    static index = 'REPLACE_ME';

    constructor(view, uuid){
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
