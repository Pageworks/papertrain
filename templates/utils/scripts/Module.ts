import { Application } from "./Application";

export class Module {
    public readonly uuid : string;
    public readonly view : HTMLElement;
    public parent : any;
    public submodules : Array<Module>;
    public futureParent : any;

    constructor(view:HTMLElement, uuid:string){
        this.view = view;
        this.uuid = uuid;
        this.parent = null;
        this.submodules = [];
        this.futureParent = null;
    }

    /**
     * Called by a submodule when it needs to be registered.
     * @param submodule - Module to register as a submodule
     */
    public register(submodule:Module):void{
        this.submodules.push(submodule);
    }

    /**
     * Called by the runtime application when the module needs to be mounted.
     */
    public mount():void{

        /** Sets the UUID attribute */
        this.view.dataset.uuid = this.uuid;

        /** Attempts to find a parent module */
        const parent = <Element>this.view.closest(`[data-module]:not([data-uuid="${ this.uuid }"])`);

        /** Checks if a parent element was found */
        if(parent){

            /** Attempts to get the module attached to the parent */
            this.parent = Application.getModuleByUUID(parent.getAttribute('data-uuid'));

            /** Checks if a parent module was found */
            if(this.parent){
                /** Register submodule with parent module */
                this.parent.register(this);
            }else{
                /** Set the future parent to the parent element */
                this.futureParent = parent;
            }
        }
    }

    /**
     * Called by the runtime application after the module has been successfully mounted.
     */
    public afterMount():void{}

    /**
     * Called when a module needs to destroy itself.
     */
    public seppuku():void{
        Application.destroyModule(this.uuid);
    }

    /**
     * Called by the runtime application before the module is destroyed.
     * Used to remove event listeners and end infinite callbacks.
     */
    public beforeDestroy():void{}

    /** Called by the runtime application when the module needs to be destroyed. */
    public destroy():void{
        if(this.submodules.length){
            for(let i = this.submodules.length - 1; i >= 0; i--){
                Application.destroyModule(this.submodules[i].uuid);
            }
        }
        this.view.remove();
    }
}
