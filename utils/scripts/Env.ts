export class Env {

    public static isDebug:boolean       = false;

    public static EASING:IEasingObject   = {
        ease: 'cubicBezier(0.4, 0.0, 0.2, 1)',
        in: 'cubicBezier(0.0, 0.0, 0.2, 1)',
        out: 'cubicBezier(0.4, 0.0, 1, 1)',
        sharp: 'cubicBezier(0.4, 0.0, 0.6, 1)'
    };

    constructor(){
        if(window.location.hostname.match(/.local/)){
            // Checks if the hostname is set to `.local`
            Env.setDebug(true);
        }
        else if(document.documentElement.getAttribute('debug') !== null){
            // Checks if the `debug` attribute is set on the `document
            Env.setDebug(true);
        }
    }

    /**
     * Sets the static `Env.isDebug` status to the provided parameter.
     * @param status - `boolean`
     */
    public static setDebug(status:boolean):void{
        Env.isDebug = status;
    }

    /** Plays the global loading animation */
    public static startLoading():void{
        document.documentElement.classList.add('dom-is-loading');
    }

    /** Stops the global loading animation */
    public static stopLoading():void{
        document.documentElement.classList.remove('dom-is-loading');
    }
}
