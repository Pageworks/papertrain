export default class Env {
    public static HTML:HTMLElement      = document.documentElement;
    public static BODY:HTMLElement      = document.body;
    public static PJAX_CONTAINER:string = '.js-pjax-container';
    public static SCROLL_TRIGGER:number = 100;
    public static APP_NAME:string       = 'REPLACE_ME';
    public static EASING:EasingObject   = {
        ease: 'cubicBezier(0.4, 0.0, 0.2, 1)',
        in: 'cubicBezier(0.0, 0.0, 0.2, 1)',
        out: 'cubicBezier(0.4, 0.0, 1, 1)',
        sharp: 'cubicBezier(0.4, 0.0, 0.6, 1)'
    };

    private _isDebug:   boolean;

    constructor(){
        this._isDebug   = false;
    }

    public setDebug(status:boolean): void{
        this._isDebug = status;
    }

    public getDebugStatus(): boolean{
        return this._isDebug;
    }
}
