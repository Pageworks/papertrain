import AbstractModule from '../AbstractModule';

export default class ViewportFix extends AbstractModule{

    public static MODULE_NAME:string = 'ViewportFix';

    private _vh:    number;

    constructor(el:HTMLElement, uuid:string, app:App){
        super(el, uuid, app);
        if(this.isDebug){
            console.log('%c[module] '+`%cBuilding: ${ViewportFix.MODULE_NAME} - ${this.uuid}`,'color:#4688f2','color:#eee');
        }

        this._vh    = window.innerHeight * 0.01;
    }

    init(){
        if(this.env.HTML.classList.contains('is-touch-device')){
            this.el.style.setProperty('--vh', `${this._vh}px`);
            window.addEventListener('resize', this.windowResize );
        }
    }

    /**
     * Called when the window resizes
     */
    private windowResize:EventListener = ()=>{
        this.handleResize();
    }

    /**
     * Fixes viewport height value for chrome
     */
    private handleResize(): void{
        if(this.env.HTML.classList.contains('is-touch-device')){
            this._vh = window.innerHeight * 0.01;
            this.el.style.setProperty('--vh', `${this._vh}px`);
        }
    }

    destroy(){
        window.removeEventListener('resize', this.windowResize );
        super.destroy(ViewportFix.MODULE_NAME);
    }
}
