import { Module } from './Module';
import { Env } from './Env';
import * as uuid from 'uuid/v4';
import DeviceManager from '@pageworks/device-manager';
import Pjax from '@pageworks/pjax';

export class Application{

    public static modules:Array<Module> = [];

    constructor(){
        new DeviceManager(Env.isDebug, true);
        new Pjax({ debug: Env.isDebug });
    }

    /**
     * Called when the application must mount any pending modules
     */
    public static mountModules():void{

        /** Get any modules that are pending that have not been mounted */
        const pendingModules:Array<HTMLElement> = Array.from(document.body.querySelectorAll('[data-module]:not([data-uuid])'));

        pendingModules.forEach((requestedModule)=>{

            /** Get what module is being requested */
            const moduleIndex = requestedModule.dataset.module;

            /** Create the module */
            Application.createModule(moduleIndex, requestedModule);
        });

        /** Manage the lazy (loaded) parents */
        Application.manageLazyParents();
    }

    /**
     * Called when lazy parents need to be checked.
     * Parents are lazy when the child (sub) module loads before them.
     */
    public static manageLazyParents():void{

        /** Loop though all modules */
        Application.modules.forEach((module)=>{

            /** Check if the module has a future parent element */
            if(module.futureParent){

                /** Get the module attached to the parent */
                module.parent = Application.getModuleByUUID(module.futureParent.getAttribute('data-uuid'));

                /** Check if the parent was set */
                if(module.parent){
                    module.futureParent = null;

                    /** Register the module as a child of the parent */
                    module.parent.register(module);
                }
            }
        });
    }

    /**
     * Attempt to create a new module.
     * @param index - the public static index string for the class
     * @param view - the `HTMLElement` that the module will be attached to
     * @returns `Module` or `null`
     */
    public static createModule(index:string, view:HTMLElement):Module{

        /** Assume the module can't be created */
        let newModule:Module = null;

        try{
            /** Create a new UUID */
            const id = uuid();

            /** Create the module */
            newModule = new modules[index].prototype.constructor(view, id);

            /** Attempt to mount the module */
            newModule.mount();
        }catch(e){
            /** If the error wasn't caused by an undefined module report it */
            if(modules[index] !== undefined){
                console.error('Failed to create module', e);
            }
        }

        /** Check if the module was successfully created */
        if(newModule){
            Application.modules.push(newModule);

            /** Trigger the modules after mount event */
            newModule.afterMount();
        }

        return newModule;
    }

    /**
     * Called when a module needs to be destroyed.
     * @param uuid - the unique ID of the module
     */
    public static destroyModule(uuid:string):void{

        /** Verify a UUID was provided */
        if(uuid){

            /** Loop through the modules */
            this.modules.forEach((module)=>{

                /** Check if the UUIDs match */
                if(module.uuid === uuid){

                    /** Get the array index of the module */
                    const index = this.modules.indexOf(module);

                    /** Fire the before destroy event */
                    module.beforeDestroy();

                    /** Fire the destroy event */
                    module.destroy();

                    /** Splice the module from the array */
                    this.modules.splice(index, 1);
                }
            });
        }else{
            console.warn('No UUID provided');
        }
    }

    /**
     * Used to get a module by its UUID.
     * @param uuid - the unique ID for the module
     * @returns `Module` or `null`
     */
    public static getModuleByUUID(uuid:string):Module{

        /** Verify a UUID was provided */
        if(!uuid){
            console.warn('No UUID provided');
            return null;
        }

        /** Assume the module doesn't exist */
        let returnModule:Module = null;

        /** Attempt to find the module */
        this.modules.forEach((module)=>{

            /** Check if the UUIDs match */
            if(module.uuid === uuid){
                returnModule = module;
            }
        });

        return returnModule;
    }
}

/** Starts the runtime application */
new Application();

/** Mount the initial modules */
Application.mountModules();
