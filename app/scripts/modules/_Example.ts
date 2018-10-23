import { isDebug } from '../utils/env';
import AbstractModule from './AbstractModule';

const MODULE_NAME = 'Example';

export default class extends AbstractModule{

    constructor(el: Element){
        super(el);
        if(isDebug) console.log('%c[module] '+`%cBuilding: ${MODULE_NAME} - ${this.uuid}`,'color:#4688f2','color:#eee');
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
        super.destroy(isDebug, MODULE_NAME);
    }
}