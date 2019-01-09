import { isDebug } from '../env';
import AbstractModule from './AbstractModule';
import { getParent } from '../utils/getParent';

export default class BasicForm extends AbstractModule{

    private static MODULE_NAME:string = 'BasicForm';

    private _inputs:             Array<HTMLInputElement>;
    private _passwordToggles:    Array<Element>;
    private _selects:            Array<HTMLSelectElement>;
    private _textareas:          Array<HTMLTextAreaElement>;

    constructor(el:Element, app:App){
        super(el, app);
        if(isDebug) console.log('%c[module] '+`%cBuilding: ${BasicForm.MODULE_NAME} - ${this.uuid}`,'color:#4688f2','color:#eee');

        this._inputs             = Array.from(this.el.querySelectorAll('input'));
        this._selects            = Array.from(this.el.querySelectorAll('select'));
        this._textareas          = Array.from(this.el.querySelectorAll('textarea'));
        this._passwordToggles    = Array.from(this.el.querySelectorAll('.js-password-toggle'));
    }

    /**
     * Called when the module is created
     * Used to call any initial methods or to
     * register any initial event listeners
     */
    public init(): void{
        this._inputs.forEach((el)=>{ el.addEventListener('focus', e => this.handleFocus(e) ); });
        this._inputs.forEach((el)=>{ el.addEventListener('blur', e => this.handleBlur(e) ); });
        this._inputs.forEach((el)=>{ el.addEventListener('keyup', e => this.handleKeystroke(e) ); });

        this._selects.forEach((el)=>{ el.addEventListener('change', e => this.handleSelection(e) ); });

        this._textareas.forEach((el)=>{ el.addEventListener('keyup', e => this.handleTextarea(e) ); });
        this._textareas.forEach((el)=>{ el.addEventListener('blur', e => this.handleTextarea(e) ); });

        this._passwordToggles.forEach((el)=>{ el.addEventListener('click', e => this.handleToggle(e) ); });

        // Handle input status for prefilled elements
        this._inputs.forEach((el)=>{
            if (el instanceof HTMLInputElement){
                if(el.value !== '' || el.innerText !== '') this.handleInputStatus(el);
            }
        });

        // Handle input status for prefilled elements
        this._selects.forEach((el)=>{
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
    private handleTextarea(e:Event): void{
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
    private handleSelection(e:Event): void{
        if (e.target instanceof HTMLSelectElement){
            const inputWrapper  = getParent(e.target, 'js-input');

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
    private handleToggle(e:Event): void{
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
    private validityCheck(el:HTMLInputElement): boolean{
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
    private handleKeystroke(e:Event): void{
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

    private handleInputStatus(el:HTMLInputElement): void{
        const inputWrapper = getParent(el, 'js-input');
        inputWrapper.classList.remove('has-focus');
        inputWrapper.classList.remove('has-value', 'is-valid', 'is-invalid');

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
    private handleBlur(e:Event): void{
        if (e.target instanceof HTMLInputElement) this.handleInputStatus(e.target);
    }

    /**
     * Sets the `has-focus` status class to the inputs wrapper
     * @param {Event} e
     */
    private handleFocus(e:Event): void{
        const inputWrapper = getParent(<Element>e.target, 'js-input');
        inputWrapper.classList.add('has-focus');
    }

    /**
     * Called when the module is destroyed
     * Remove all event listners before calling super.destory()
     */
    public destroy(): void{
        this._inputs.forEach((el)=>{ el.removeEventListener('focus', e => this.handleFocus(e) ); });
        this._inputs.forEach((el)=>{ el.removeEventListener('blur', e => this.handleBlur(e) ); });
        this._inputs.forEach((el)=>{ el.removeEventListener('keyup', e => this.handleKeystroke(e) ); });
        this._selects.forEach((el)=>{ el.removeEventListener('change', e => this.handleSelection(e) ); });
        this._textareas.forEach((el)=>{ el.removeEventListener('keyup', e => this.handleTextarea(e) ); });
        this._textareas.forEach((el)=>{ el.removeEventListener('blur', e => this.handleTextarea(e) ); });
        this._passwordToggles.forEach((el)=>{ el.removeEventListener('click', e => this.handleToggle(e) ); });
        super.destroy(isDebug, BasicForm.MODULE_NAME);
    }
}
