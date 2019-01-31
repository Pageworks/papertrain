import { isDebug } from '../env';
import AbstractModule from './AbstractModule';

export default class Freeform extends AbstractModule{

    public static MODULE_NAME:string = 'Freeform';

    // Form Elements
    private _inputs:            Array<HTMLInputElement>;
    private _passwordToggles:   Array<Element>;
    private _selects:           Array<HTMLSelectElement>;
    private _textareas:         Array<HTMLTextAreaElement>;
    private _switches:          Array<Element>;

    // General Elements
    private _tabs:              Array<Element>;
    private _pages:             Array<Element>;
    private _button:            Element;

    // Variables
    private _active:            number;

    constructor(el:Element, app:App){
        super(el, app);
        if(isDebug) console.log('%c[module] '+`%cBuilding: ${Freeform.MODULE_NAME} - ${this.uuid}`,'color:#4688f2','color:#eee');

        // Form Elements
        this._inputs            = null;
        this._selects           = null;
        this._textareas         = null;
        this._passwordToggles   = null;
        this._switches          = null;

        // General Elements
        this._tabs              = Array.from(this.el.querySelectorAll('.js-tab'));
        this._pages             = Array.from(this.el.querySelectorAll('.js-page'));
        this._button            = null;

        // Variables
        this._active            = 0;
    }

    /**
     * Called when the module is created
     * Used to call any initial methods or to
     * register any initial event listeners
     */
    public init(): void{
        this.getPageElements();
        this.addEvents();
        this.handlePrefills();
        this.checkForRequired();
    }

    private submitForm(): void{

    }

    private getPageElements(): void{
        this._inputs            = Array.from(this._pages[this._active].querySelectorAll('input'));
        this._selects           = Array.from(this._pages[this._active].querySelectorAll('select'));
        this._textareas         = Array.from(this._pages[this._active].querySelectorAll('textarea'));
        this._passwordToggles   = Array.from(this._pages[this._active].querySelectorAll('.js-password-toggle'));
        this._switches          = Array.from(this._pages[this._active].querySelectorAll('.js-switch'));

        if(this._pages.length > 1){
            this._button = this._pages[this._active].querySelector('.js-next-button');
        }
        else{
            this._button = this._pages[this._active].querySelector('.js-submit-button');
        }
    }

    private removeEvents(): void{
        this._inputs.forEach((el)=>{ el.removeEventListener('focus', e => this.handleFocus(e) ); });
        this._inputs.forEach((el)=>{ el.removeEventListener('blur', e => this.handleBlur(e) ); });
        this._inputs.forEach((el)=>{ el.removeEventListener('keyup', e => this.handleKeystroke(e) ); });

        this._selects.forEach((el)=>{ el.removeEventListener('change', e => this.handleSelection(e) ); });

        this._textareas.forEach((el)=>{ el.removeEventListener('keyup', e => this.handleTextarea(e) ); });
        this._textareas.forEach((el)=>{ el.removeEventListener('blur', e => this.handleTextarea(e) ); });

        this._passwordToggles.forEach((el)=>{ el.removeEventListener('click', e => this.handleToggle(e) ); });

        this._switches.forEach((el)=>{ el.removeEventListener('CheckboxStateChange', e => this.handleSwitch(e) ); });

        if(this._pages.length > 1){
            this._button.removeEventListener('click', e => this.nextPage() );
        }else{
            this._button.removeEventListener('click', e => this.submitForm() );
        }
    }

    private addEvents(): void{
        this._inputs.forEach((el)=>{ el.addEventListener('focus', e => this.handleFocus(e) ); });
        this._inputs.forEach((el)=>{ el.addEventListener('blur', e => this.handleBlur(e) ); });
        this._inputs.forEach((el)=>{ el.addEventListener('keyup', e => this.handleKeystroke(e) ); });

        this._selects.forEach((el)=>{ el.addEventListener('change', e => this.handleSelection(e) ); });

        this._textareas.forEach((el)=>{ el.addEventListener('keyup', e => this.handleTextarea(e) ); });
        this._textareas.forEach((el)=>{ el.addEventListener('blur', e => this.handleTextarea(e) ); });

        this._passwordToggles.forEach((el)=>{ el.addEventListener('click', e => this.handleToggle(e) ); });

        this._switches.forEach((el)=>{ el.addEventListener('change', e => this.handleSwitch(e) ); });

        if(this._pages.length > 1){
            this._button.addEventListener('click', e => this.nextPage() );
        }else{
            this._button.addEventListener('click', e => this.submitForm() );
        }
    }

    private handlePrefills(): void{
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

    private checkForRequired(): void{
        const requiredElements = this._pages[this._active].querySelectorAll('[required]');
        if(requiredElements.length === 0){
            this._button.classList.remove('is-disabled');
        }
    }

    private pageInit(): void{
        this.removeEvents();
        this.getPageElements();
        this.addEvents();
        this.handlePrefills();
        this.checkForRequired();
    }

    private nextPage(): void{
        console.log('User clicked');
    }

    private validatePage(): void{
        let isInvalid = true;

        const required = Array.from(this._pages[this._active].querySelectorAll('[required]'));

        required.forEach((el)=>{
            if(el instanceof HTMLInputElement || el instanceof HTMLTextAreaElement ){
                if(!el.validity.valid || el.value === ''){
                    isInvalid = false;
                }
            }
        });

        if(isInvalid){
            this._button.classList.remove('is-disabled');
        }else{
            this._button.classList.add('is-disabled');
        }
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
        const el = <HTMLInputElement>e.currentTarget;
        const inputWrapper = el.parentElement;
        const parent = inputWrapper.parentElement;
        parent.classList.remove('is-valid', 'is-invalid');

        if(this.validityCheck(el)){
            parent.classList.add('is-valid');
        }else{
            parent.classList.add('is-invalid');
            const errorObject = inputWrapper.querySelector('.js-error');
            if(errorObject){
                errorObject.innerHTML = el.validationMessage;
            }
        }

        this.validatePage();
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
        this.validatePage();
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

        this.validatePage();
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
        super.destroy(isDebug, Freeform.MODULE_NAME);
    }
}
