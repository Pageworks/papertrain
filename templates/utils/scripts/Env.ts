export class Env {

    public static isDebug:boolean       = false;

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
}

new Env();
