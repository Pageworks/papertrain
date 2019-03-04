import Env from '../env';
import AbstractModule from '../AbstractModule';

export default class Example extends AbstractModule{

    public static MODULE_NAME:string = 'Example';

    constructor(el:HTMLElement, uuid:string, app:App){
        super(el, uuid, app);
        if(this.isDebug){
            console.log('%c[module] '+`%cBuilding: ${Example.MODULE_NAME} - ${this.uuid}`,'color:#4688f2','color:#eee');
        }
    }

    /**
     * Called when the module is created.
     */
    init(){

    }

    /**
     * Called when the module is destroyed.
     */
    destroy(){
        super.destroy(Example.MODULE_NAME);
    }
}
