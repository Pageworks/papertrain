declare class Module {
    /** Instance (public) variables */
    public readonly uuid : string;
    public readonly view : HTMLElement;
    public parent : any;
    public futureParent : any;
    public submodules : Array<Module>;

    /** Class constructor */
    constructor(view:HTMLElement, uuid:string);

    /** Class (public) functions */
    public mount(): void;
    public afterMount(): void;
    public seppuku(): void;
    public beforeDestroy(): void;
    public destroy(triggeredByParent:boolean): void;
    public register(submodule:Module): void;
}
