import { isDebug } from '../env';
import AbstractModule from './AbstractModule';

export default class BasicForm extends AbstractModule{

    public static MODULE_NAME:string = 'BasicForm';

    private _inputs:            Array<HTMLInputElement>;
    private _passwordToggles:   Array<Element>;
    private _selects:           Array<HTMLSelectElement>;
    private _textareas:         Array<HTMLTextAreaElement>;
    private _switches:          Array<Element>;

    constructor(el:Element, uuid:string, app:App){
        super(el, uuid, app);
        if(isDebug) console.log('%c[module] '+`%cBuilding: ${BasicForm.MODULE_NAME} - ${this.uuid}`,'color:#4688f2','color:#eee');

        // Elements
        this._inputs            = Array.from(this.el.querySelectorAll('input'));
        this._selects           = Array.from(this.el.querySelectorAll('select'));
        this._textareas         = Array.from(this.el.querySelectorAll('textarea'));
        this._passwordToggles   = Array.from(this.el.querySelectorAll('.js-password-toggle'));
        this._switches          = Array.from(this.el.querySelectorAll('.js-switch'));
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

        this._switches.forEach((el)=>{ el.addEventListener('CheckboxStateChange', e => this.handleSwitch(e) ); });

        // Handle input status for prefilled elements
        this._inputs.forEach((el)=>{
            if(el.value !== '' || el.innerText !== ''){
                this.handleInputStatus(el);
            }
        });

        // Handle input status for select elements
        this._selects.forEach((el)=>{
            if (el instanceof HTMLSelectElement){
                if(el.value !== 'any'){
                    const inputWrapper  = el.parentElement;
                    inputWrapper.classList.add('has-value');
                    inputWrapper.classList.add('is-valid');
                }
            }
        });
    }

    /**
     * Called when we need to make sure an input is valid.
     * If the input has innerText and a value and is valid return true.
     * @param {HTMLInputElement} el input element
     */
    private validityCheck(el:HTMLInputElement): boolean{
        let isValid = true;

        if(el.innerText === '' && el.value === '' && el.getAttribute('required') !== null){
            isValid = false;
        }
        else if(!el.validity.valid){
            isValid = false;
        }

        return isValid;
    }

    private handleSwitch(e:Event): void{
        const target = <Element>e.currentTarget;
    }

    /**
     * Called when a user releases a key while a textarea element has focus.
     * @param {Event} e
     */
    private handleTextarea(e:Event): void{
        const target = <HTMLTextAreaElement>e.currentTarget;
        const inputWrapper  = target.parentElement;
        inputWrapper.classList.remove('has-value', 'is-valid', 'is-invalid');

        if(target.validity.valid && target.value !== ''){
            inputWrapper.classList.add('has-value');
            inputWrapper.classList.add('is-valid');
        }else if(!target.validity.valid){
            inputWrapper.classList.add('is-invalid');
            const errorObject = inputWrapper.querySelector('.js-error');
            if(errorObject){
                errorObject.innerHTML = target.validationMessage;
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
        const target        = <Element>e.currentTarget;
        const inputWrapper  = target.parentElement;
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

    private handleKeystroke(e:Event): void{
        const target = <HTMLInputElement>e.currentTarget;
        const inputWrapper = target.parentElement;
        if(inputWrapper.classList.contains('is-invalid')){
            if(this.validityCheck(target)){
                inputWrapper.classList.add('is-valid');
                inputWrapper.classList.remove('is-invalid');
            }
        }
    }

    private handleInputStatus(el:HTMLInputElement): void{
        const inputWrapper = el.parentElement;
        inputWrapper.classList.remove('has-focus');
        inputWrapper.classList.remove('has-value', 'is-valid', 'is-invalid');

        if(this.validityCheck(el)){
            if(el.value !== '' || el.innerText !== '') inputWrapper.classList.add('has-value');
            inputWrapper.classList.add('is-valid');
        }else{
            inputWrapper.classList.add('is-invalid');
            const errorObject = inputWrapper.querySelector('.js-error');
            if(errorObject){
                errorObject.innerHTML = el.validationMessage;
            }
        }
    }

    private handleBlur(e:Event): void{
        const target = <HTMLInputElement>e.currentTarget;
        this.handleInputStatus(target);
    }

    private handleFocus(e:Event): void{
        const target = <Element>e.currentTarget;
        const parent = target.parentElement;
        parent.classList.add('has-focus');
    }

    /**
     * Called when a user selects a different option in the selection dropdown.
     * If the selected option isn't `any` set the `has-value` status class.
     * @param {Event} e
     */
    private handleSelection(e:Event): void{
        const target = <HTMLSelectElement>e.currentTarget;
        const inputWrapper  = target.parentElement;

        if(target.value === 'any'){
            inputWrapper.classList.remove('has-value', 'is-valid', 'is-invalid');
        }else{
            inputWrapper.classList.add('has-value');
            inputWrapper.classList.add('is-valid');
        }
    }

    public destroy(): void{
        super.destroy(isDebug, BasicForm.MODULE_NAME);
    }
}
