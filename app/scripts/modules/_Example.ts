import { isDebug } from '../env';
import AbstractModule from './AbstractModule';

export default class Example extends AbstractModule{

    private static MODULE_NAME:string = 'Example';

    constructor(el:Element, app:App){
        super(el, app);
        if(isDebug){
            console.log('%c[module] '+`%cBuilding: ${Example.MODULE_NAME} - ${this.uuid}`,'color:#4688f2','color:#eee');
        }
    }

    /**
     * Called when the module is created
     * Used to call any initial methods or to
     * register any initial event listeners
     */
    init(){

    }

    /**
     * Called when the module is destroyed
     * Remove all event listners before calling super.destory()
     */
    destroy(){
        super.destroy(isDebug, Example.MODULE_NAME);
    }
}
