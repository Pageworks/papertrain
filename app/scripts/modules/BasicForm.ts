import { isDebug } from '../env';
import AbstractModule from './AbstractModule';
import { getParent } from '../utils/getParent';

const MODULE_NAME = 'BasicForm';

export default class extends AbstractModule{
    inputs: NodeList

    constructor(el: Element){
        super(el);
        if(isDebug) console.log('%c[module] '+`%cBuilding: ${MODULE_NAME} - ${this.uuid}`,'color:#4688f2','color:#eee');

        this.inputs = this.el.querySelectorAll('input');
    }

    /**
     * Called when the module is created
     * Used to call any initial methods or to
     * register any initial event listeners
     */
    init(){
        this.inputs.forEach((el)=>{ el.addEventListener('focus', e => this.handleFocus(e) ); });
        this.inputs.forEach((el)=>{ el.addEventListener('blur', e => this.handleBlur(e) ); });
    }

    /**
     * @todo Call when a user is typing into an input, if the input is valid remove any `is-invalid` status classes
     */
    handleKeystroke(e:Event){

    }

    /**
     * Sets the status classes for the input wrapper based on the inputs validity
     * @todo Call on init to check prefilled inputs
     * @see https://developer.mozilla.org/en-US/docs/Web/API/ValidityState
     * @param {Event} e input element
     */
    handleBlur(e:Event){
        const targetEl = <HTMLInputElement>e.target;
        const inputWrapper = getParent(<Element>e.target, 'js-input');
        inputWrapper.classList.remove('has-focus');

        inputWrapper.classList.remove('has-value', 'is-valid', 'is-invalid');

        if(targetEl.value && targetEl.validity.valid){
            inputWrapper.classList.add('has-value');
            inputWrapper.classList.add('is-valid');
        }

        if(!targetEl.validity.valid){
            inputWrapper.classList.add('is-invalid');
        }
    }

    /**
     * Sets the `has-focus` status class to the inputs wrapper
     * @param {Event} e input element
     */
    handleFocus(e:Event){
        const inputWrapper = getParent(<Element>e.target, 'js-input');
        inputWrapper.classList.add('has-focus');
    }

    /**
     * Called when the module is destroyed
     * Remove all event listners before calling super.destory()
     */
    destroy(){
        this.inputs.forEach((el)=>{ el.removeEventListener('focus', e => this.handleFocus(e) ); });
        this.inputs.forEach((el)=>{ el.removeEventListener('blur', e => this.handleBlur(e) ); });
        super.destroy(isDebug, MODULE_NAME);
    }
}