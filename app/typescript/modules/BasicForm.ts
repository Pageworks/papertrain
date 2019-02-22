import AbstractModule from '../AbstractModule';

export default class BasicForm extends AbstractModule{

    public static MODULE_NAME:string = 'BasicForm';

    private _inputs:            Array<HTMLInputElement>;
    private _passwordInputs:    Array<HTMLInputElement>;
    private _passwordToggles:   Array<Element>;
    private _selects:           Array<HTMLSelectElement>;
    private _textareas:         Array<HTMLTextAreaElement>;
    private _switches:          Array<HTMLInputElement>;

    constructor(el:HTMLElement, uuid:string, app:App){
        super(el, uuid, app);
        if(this.isDebug){
            console.log('%c[module] '+`%cBuilding: ${BasicForm.MODULE_NAME} - ${this.uuid}`,'color:#4688f2','color:#eee');
        }

        // Elements
        this._inputs            = Array.from(this.el.querySelectorAll('.js-input input'));
        this._passwordInputs    = Array.from(this.el.querySelectorAll('.js-password-checker input'));
        this._selects           = Array.from(this.el.querySelectorAll('.js-select select'));
        this._textareas         = Array.from(this.el.querySelectorAll('.js-textarea textarea'));
        this._passwordToggles   = Array.from(this.el.querySelectorAll('.js-password-toggle'));
        this._switches          = Array.from(this.el.querySelectorAll('.js-switch input'));
    }

    /**
     * Called when the module is created.
     */
    public init(): void{
        this._inputs.forEach((el)=>{ el.addEventListener('focus', e => this.handleInput(e) ); });
        this._inputs.forEach((el)=>{ el.addEventListener('blur', e => this.handleInput(e) ); });
        this._inputs.forEach((el)=>{ el.addEventListener('keyup', e => this.handleInput(e) ); });

        this._passwordInputs.forEach((el)=>{ el.addEventListener('focus', e => this.handlePasswordInput(e) ); });
        this._passwordInputs.forEach((el)=>{ el.addEventListener('blur', e => this.handlePasswordInput(e) ); });
        this._passwordInputs.forEach((el)=>{ el.addEventListener('keyup', e => this.handlePasswordInput(e) ); });

        this._selects.forEach((el)=>{ el.addEventListener('focus', e => this.handleSelect(e) ); });
        this._selects.forEach((el)=>{ el.addEventListener('blur', e => this.handleSelect(e) ); });
        this._selects.forEach((el)=>{ el.addEventListener('change', e => this.handleSelect(e) ); });

        this._textareas.forEach((el)=>{ el.addEventListener('keyup', e => this.handleTextarea(e) ); });
        this._textareas.forEach((el)=>{ el.addEventListener('blur', e => this.handleTextarea(e) ); });

        this._passwordToggles.forEach((el)=>{ el.addEventListener('click', e => this.handleToggle(e) ); });

        this._switches.forEach((el)=>{ el.addEventListener('change', e => this.handleSwitch(e) ); });

        // Handle input status for prefilled elements
        this._inputs.forEach((el)=>{
            if(el.value !== ''){
                const parent = el.parentElement;
                parent.classList.add('has-value');
            }
        });

        // Handle input status for select elements
        this._selects.forEach((el)=>{
            if(el.value !== 'any'){
                const inputWrapper  = el.parentElement;
                inputWrapper.classList.add('has-value');
            }
        });
    }

    /**
     * Called when the user interacts with a `textarea` element
     * @param { Event } e
     */
    private handleTextarea(e:Event): void{
        const target = <HTMLTextAreaElement>e.currentTarget;
        const parent = target.parentElement;

        if(e.type === 'blur'){
            // Check if the textarea is valid
            if(target.validity.valid){
                parent.classList.add('is-valid');
                parent.classList.remove('is-invalid');
            }else{
                parent.classList.remove('is-valid');
                parent.classList.add('is-invalid');

                const errorEl = parent.querySelector('.js-error');
                if(errorEl){
                    errorEl.innerHTML = target.validationMessage;
                }
            }

            if(target.value !== ''){
                parent.classList.add('has-value');
            }else{
                parent.classList.remove('has-value');
            }
        }
        else if(e.type === 'keyup'){
            // Only run valditiy check on `keyup` if the input has already been marked as invalid
            if(parent.classList.contains('is-invalid')){
                // Check if the input is valid
                if(target.validity.valid){
                    parent.classList.add('is-valid');
                    parent.classList.remove('is-invalid');
                }else{
                    parent.classList.remove('is-valid');
                    parent.classList.add('is-invalid');
                }
            }
        }
    }

    /**
     * Called when the user interacts with a `select` element.
     * @param { Event } e
     */
    private handleSelect(e:Event): void{
        const target = <HTMLSelectElement>e.currentTarget;
        const parent = target.parentElement;
        const isRequried = (target.getAttribute('required') === null) ? false : true;

        // Handle custom focus and blur status
        if(e.type === 'focus'){
            parent.classList.add('has-focus');
        }
        else if(e.type === 'blur'){
            parent.classList.remove('has-focus');

            if(isRequried && target.value === 'any'){
                parent.classList.add('is-invalid');
                parent.classList.remove('is-valid');

                const errorEl = parent.querySelector('.js-error');
                if(errorEl){
                    errorEl.innerHTML = 'Please fill out this field.';
                }
            }else{
                parent.classList.remove('is-invalid');
                parent.classList.add('is-valid');
            }
        }
        else if(e.type === 'change'){
            if(isRequried && target.value === 'any'){
                parent.classList.add('is-invalid');
                parent.classList.remove('is-valid');

                const errorEl = parent.querySelector('.js-error');
                if(errorEl){
                    errorEl.innerHTML = 'Please fill out this field.';
                }
            }else{
                parent.classList.remove('is-invalid');
                parent.classList.add('is-valid');
            }
        }

        // Set the `has-value` status class
        if(target.value !== 'any'){
            parent.classList.add('has-value');
        }else{
            parent.classList.remove('has-value');
        }
    }

    /**
     * Called by the `validateInput` method.
     * Handles the status classes for `input` elements.
     * @param { HTMLInputElement } target - the `input` element
     * @param { Element } parent - the `input` elements wrapper
     * @param { HTMLInputElement } relatedEl - optional companion element
     */
    private checkForValidInput(target:HTMLInputElement, parent:Element, relatedEl:HTMLInputElement = null): void{
        let isValid = true;

        if(relatedEl){
            if(relatedEl.value !== target.value && parent.classList.contains('js-password-checker')){
                isValid = false;
            }
            else if(relatedEl.value === target.value){
                relatedEl.parentElement.classList.add('is-valid');
                relatedEl.parentElement.classList.remove('is-invalid');
            }
        }

        if(!target.validity.valid){
            isValid = false;
        }

        if(isValid){
            parent.classList.add('is-valid');
            parent.classList.remove('is-invalid');
        }
        else{
            parent.classList.remove('is-valid');
            parent.classList.add('is-invalid');

            const errorEl = parent.querySelector('.js-error');
            if(errorEl){
                if(!target.validity.valid){
                    errorEl.innerHTML = target.validationMessage;
                }
                else{
                    errorEl.innerHTML = 'Passwords don\'t match.';
                }
            }
        }

        // Check if the input has a value
        if(target.value !== ''){
            parent.classList.add('has-value');
        }else{
            parent.classList.remove('has-value');
        }
    }

    /**
     * Called when we need to validate a `input` element after the user interacted with it.
     * @param { string } eventType - `Event.type` string
     * @param { HTMLInputElement } target - the `input` element the user interacted with
     * @param { Element } parent - the `input` elements wrapper
     * @param { HTMLInputElement } relatedEl - optional companion element
     */
    private validateInput(eventType:string, target:HTMLInputElement, parent:Element, relatedEl:HTMLInputElement = null): void{
        if(eventType === 'focus'){
            parent.classList.add('has-focus');
        }
        else if(eventType === 'blur'){
            parent.classList.remove('has-focus');
            target.setAttribute('data-touched', 'true');
            this.checkForValidInput(target, parent, relatedEl);
        }
        else if(eventType === 'keyup' && target.getAttribute('data-touched') !== null){
            this.checkForValidInput(target, parent, relatedEl);
        }
    }

    /**
     * Called when the user interacts with a `input` that is labeled as a password checker.
     * @param { Event } e
     */
    private handlePasswordInput(e:Event): void{
        const target = <HTMLInputElement>e.currentTarget;
        const parent = target.parentElement;
        const forEl = <HTMLInputElement>this.el.querySelector(`.js-password input[name="${parent.getAttribute('data-for')}"]`);

        // Make sure the input has it's password field companion
        if(!forEl){
            if(this.isDebug){
                console.log('%cUndefined Password Element: '+`%c${parent.getAttribute('data-for')}`,'color:#ff6e6e','color:#eee');
            }
        }else{
            this.validateInput(e.type, target, parent, forEl);
        }
    }

    /**
     * Called when the user interacts with a `input` element.
     * Not called on `checkbox` or `radio` input types.
     * @param { Event } e
     */
    private handleInput(e:Event): void{
        const target = <HTMLInputElement>e.currentTarget;
        const parent = target.parentElement;

        // If the input is a password get the password checker companion element
        if(parent.classList.contains('js-password')){
            const checkerInput = <HTMLInputElement>this.el.querySelector(`.js-password-checker input[name="${target.getAttribute('name')}-check"]`);
            this.validateInput(e.type, target, parent, checkerInput);
        }else{
            this.validateInput(e.type, target, parent);
        }
    }

    /**
     * Called when a switch input is toggled.
     * @param { Event } e
     */
    private handleSwitch(e:Event): void{
        const el = <HTMLInputElement>e.currentTarget;
        const inputWrapper = el.parentElement;
        const parent = inputWrapper.parentElement;
        parent.classList.remove('is-valid', 'is-invalid');

        if(el.validity.valid){
            parent.classList.add('is-valid');
        }else{
            parent.classList.add('is-invalid');
            const errorObject = inputWrapper.querySelector('.js-error');
            if(errorObject){
                errorObject.innerHTML = el.validationMessage;
            }
        }
    }

    /**
     * Called when the user clicks on the show/hide password icon.
     * @param  { Event } e
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

    /**
     * Called when the module is destroyed.
     */
    public destroy(): void{
        super.destroy(BasicForm.MODULE_NAME);
    }
}
