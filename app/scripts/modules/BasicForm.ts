import { isDebug } from '../env';
import AbstractModule from './AbstractModule';
import { getParent } from '../utils/getParent';

const MODULE_NAME = 'BasicForm';

export default class extends AbstractModule{
    inputs:             NodeList
    passwordToggles:    NodeList
    selects:            NodeList
    textareas:          NodeList

    constructor(el: Element){
        super(el);
        if(isDebug) console.log('%c[module] '+`%cBuilding: ${MODULE_NAME} - ${this.uuid}`,'color:#4688f2','color:#eee');

        this.inputs             = this.el.querySelectorAll('input');
        this.selects            = this.el.querySelectorAll('select');
        this.textareas          = this.el.querySelectorAll('textarea');
        this.passwordToggles    = this.el.querySelectorAll('.js-password-toggle');
    }

    /**
     * Called when the module is created
     * Used to call any initial methods or to
     * register any initial event listeners
     */
    init(){
        this.inputs.forEach((el)=>{ el.addEventListener('focus', e => this.handleFocus(e) ); });
        this.inputs.forEach((el)=>{ el.addEventListener('blur', e => this.handleBlur(e) ); });
        this.inputs.forEach((el)=>{ el.addEventListener('keyup', e => this.handleKeystroke(e) ); });

        this.selects.forEach((el)=>{ el.addEventListener('change', e => this.handleSelection(e) ); });

        this.textareas.forEach((el)=>{ el.addEventListener('keyup', e => this.handleTextarea(e) ); });
        this.textareas.forEach((el)=>{ el.addEventListener('blur', e => this.handleTextarea(e) ); });

        this.passwordToggles.forEach((el)=>{ el.addEventListener('click', e => this.handleToggle(e) ); });

        // Handle input status for prefilled elements
        this.inputs.forEach((el)=>{
            if (el instanceof HTMLInputElement){
                if(el.value !== '' || el.innerText !== '') this.handleInputStatus(el);
            }
        });

        // Handle input status for prefilled elements
        this.selects.forEach((el)=>{
            if (el instanceof HTMLSelectElement){
                if(el.value !== 'any'){
                    const inputWrapper  = getParent(el, 'js-input');
                    inputWrapper.classList.add('has-value');
                    inputWrapper.classList.add('is-valid');
                }
            }
        });
    }

    /**
     * Called when a user releases a key while a textarea element has focus.
     * @param {Event} e
     */
    handleTextarea(e:Event){
        if (e.target instanceof HTMLTextAreaElement){
            const inputWrapper  = getParent(e.target, 'js-input');
            inputWrapper.classList.remove('has-value', 'is-valid', 'is-invalid');

            if(e.target.validity.valid && e.target.value !== ''){
                inputWrapper.classList.add('has-value');
                inputWrapper.classList.add('is-valid');
            }else if(!e.target.validity.valid){
                inputWrapper.classList.add('is-invalid');
                const errorObject = inputWrapper.querySelector('.js-error');
                if(errorObject) errorObject.innerHTML = e.target.validationMessage;
            }
        }
    }

    /**
     * Called when a user selects a different option in the selection dropdown.
     * If the selected option isn't `any` set the `has-value` status class.
     * @param {Event} e
     */
    handleSelection(e:Event){
        if (e.target instanceof HTMLSelectElement){
            const inputWrapper  = getParent(e.target, 'js-input');

            console.log(e.target);
            if(e.target.value === 'any'){
                inputWrapper.classList.remove('has-value', 'is-valid', 'is-invalid');
            }else{
                inputWrapper.classList.add('has-value');
                inputWrapper.classList.add('is-valid');
            }
        }
    }

    /**
     * Called when a user clicks on the eye icon for a password or pin input.
     * If the content is hidden we set the inputs type to `text`.
     * If the content isn't hidden we set the inputs type to `password`.
     * @param {Event} e
     */
    handleToggle(e:Event){
        if (e.target instanceof Element){
            const inputWrapper  = getParent(e.target, 'js-input');
            const input         = inputWrapper.querySelector('input');

            if(inputWrapper.classList.contains('has-content-hidden')){
                inputWrapper.classList.remove('has-content-hidden');
                inputWrapper.classList.add('has-content-visible');
                input.setAttribute('type', 'text');
            }else{
                inputWrapper.classList.add('has-content-hidden');
                inputWrapper.classList.remove('has-content-visible');
                input.setAttribute('type', 'password');
            }
        }
    }

    /**
     * Called when we need to make sure an input is valid.
     * If the input has innerText and a value and is valid return true.
     * @param {HTMLInputElement} el input element
     */
    validityCheck(el:HTMLInputElement){
        let isValid = true;
        if(el.innerText === '' && el.value === '' && el.getAttribute('required') !== null) isValid = false;
        else if(!el.validity.valid) isValid = false;
        return isValid;
    }

    /**
     * Called whenever a user releases a key while an input is in focus.
     * If the target is an input element and the input was marked as `is-invalid` on the previous blur event
     * we should check if the issue has been fixed. If it has add our `is-valid` class, otherwise, do nothing.
     * @param {Event} e
     */
    handleKeystroke(e:Event){
        if (e.target instanceof HTMLInputElement){
            const inputWrapper = getParent(e.target, 'js-input');

            if(inputWrapper.classList.contains('is-invalid')){
                if(this.validityCheck(e.target)){
                    inputWrapper.classList.add('is-valid');
                    inputWrapper.classList.remove('is-invalid');
                }
            }
        }
    }

    handleInputStatus(el:HTMLInputElement){
        const inputWrapper = getParent(el, 'js-input');
        inputWrapper.classList.remove('has-focus');
        inputWrapper.classList.remove('has-value', 'is-valid', 'is-invalid');

        console.log(el);

        if(this.validityCheck(el)){
            if(el.value !== '' || el.innerText !== '') inputWrapper.classList.add('has-value');
            inputWrapper.classList.add('is-valid');
        }else{
            inputWrapper.classList.add('is-invalid');
            const errorObject = inputWrapper.querySelector('.js-error');
            if(errorObject) errorObject.innerHTML = el.validationMessage;
        }
    }

    /**
     * Sets the status classes for the input wrapper based on the inputs validity
     * @todo Call on init to check prefilled inputs
     * @see https://developer.mozilla.org/en-US/docs/Web/API/ValidityState
     * @param {Event} e
     */
    handleBlur(e:Event){
        if (e.target instanceof HTMLInputElement) this.handleInputStatus(e.target);
    }

    /**
     * Sets the `has-focus` status class to the inputs wrapper
     * @param {Event} e
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
        this.inputs.forEach((el)=>{ el.removeEventListener('keyup', e => this.handleKeystroke(e) ); });
        this.selects.forEach((el)=>{ el.removeEventListener('change', e => this.handleSelection(e) ); });
        this.textareas.forEach((el)=>{ el.removeEventListener('keyup', e => this.handleTextarea(e) ); });
        this.textareas.forEach((el)=>{ el.removeEventListener('blur', e => this.handleTextarea(e) ); });
        this.passwordToggles.forEach((el)=>{ el.removeEventListener('click', e => this.handleToggle(e) ); });
        super.destroy(isDebug, MODULE_NAME);
    }
}