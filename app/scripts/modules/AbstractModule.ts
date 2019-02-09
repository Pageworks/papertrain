export default class AbstractModule{
    public el:      HTMLElement;
    public uuid:    string;
    private _app:   App;

    constructor(el:HTMLElement, uuid:string, app:App){
        this.el     = el;
        this.uuid   = uuid;
        this._app   = app;

        // Sets modules UUID to be used later when handling modules destruction
        this.el.setAttribute('data-uuid', this.uuid);
    }

    public init(): void{

    }

    /**
     * Acts as the modules self-destruct method, when called the module will be removed from the page
     * Used when removing a specific module, call is initiated by a module
     */
    public seppuku(): void{
        this._app.deleteModule(this.uuid);
    }

    /**
     * Called by a module, removes attribute and logs out destruction to the console
     * Used when the page transitions, call is initiated by applicaiton
     * You shouldn't call this method, if you need to remove a module use the `seppuku` method
     * @param {boolean} isDebug
     * @param {string} MODULE_NAME
     */
    public destroy(isDebug: boolean, MODULE_NAME: string): void{
        this.el.removeAttribute('data-uuid');
        if(isDebug){
            console.log('%c[module] '+`%cDestroying ${MODULE_NAME} - ${this.uuid}`,'color:#ff6e6e','color:#eee');
        }
    }
}
