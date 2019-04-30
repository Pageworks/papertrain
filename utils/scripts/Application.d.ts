declare class Application {

    /** Instance (static) variables */
    public static modules : Array<Module>;

    /** Class constructor */
    constructor();

    /** Class (static) functions */
    public static mountModules(): void;
    public static manageLazyParents(): void;
    public static createModule(view:HTMLElement, uuid:string): Module;
    public static destroyModule(uuid:string): void;
    public static getModuleByUUID(uuid:string): Module;
}
