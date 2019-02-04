import { isDebug, html, easing } from '../env';
import AbstractModule from './AbstractModule';
import anime from 'animejs';

export default class Freeform extends AbstractModule{

    public static MODULE_NAME:string = 'Freeform';

    // Form Elements
    private _inputs:    Array<HTMLInputElement>;
    private _passwords: Array<HTMLInputElement>;
    private _textareas: Array<HTMLTextAreaElement>;
    private _selects:   Array<HTMLSelectElement>;
    private _switches:  Array<HTMLInputElement>;

    // General Elements
    private _tabs:          Array<Element>;
    private _pages:         Array<Element>;
    private _nextButton:    Element;
    private _backButton:    Element;
    private _submitButton:  Element;

    // Variables
    private _active:    number;

    constructor(el:Element, uuid:string, app:App){
        super(el, uuid, app);
        if(isDebug){
            console.log('%c[module] '+`%cBuilding: ${Freeform.MODULE_NAME} - ${this.uuid}`,'color:#4688f2','color:#eee');
        }

        // Form Elements
        this._inputs    = null;
        this._passwords = null;
        this._textareas = null;
        this._selects   = null;
        this._switches  = null;

        // General Elements
        this._tabs          = Array.from(this.el.querySelectorAll('.js-tab'));
        this._pages         = Array.from(this.el.querySelectorAll('.js-page'));
        this._backButton    = null;
        this._nextButton    = null;
        this._submitButton  = null;

        // Variables
        this._active    = 0;
    }

    /**
     * Called when the module is created
     * Used to call any initial methods or to
     * register any initial event listeners
     */
    public init(): void{
        this.getPageElements();
        this.addEvents();
        this.checkForRequired();
    }

    private getPageElements(): void{
        this._inputs    = Array.from(this._pages[this._active].querySelectorAll('.js-input input[required]'));
        this._passwords = Array.from(this._pages[this._active].querySelectorAll('.js-password-checker input[required]'));
        this._textareas = Array.from(this._pages[this._active].querySelectorAll('.js-textarea textarea[required]'));
        this._selects   = Array.from(this._pages[this._active].querySelectorAll('.js-select select[required]'));
        this._switches  = Array.from(this._pages[this._active].querySelectorAll('.js-switch input[required]'));

        this._nextButton    = this._pages[this._active].querySelector('.js-next-button');
        this._backButton    = this._pages[this._active].querySelector('.js-back-button');
        this._submitButton  = this._pages[this._active].querySelector('.js-submit-button');
    }

    private removeEvents(): void{
        this._inputs.forEach((el)=>{ el.removeEventListener('blur', this.validatePage ); });
        this._inputs.forEach((el)=>{ el.removeEventListener('keyup', this.validatePage ); });
        this._inputs.forEach((el)=>{ el.removeEventListener('change', this.validatePage ); });

        this._passwords.forEach((el)=>{ el.removeEventListener('blur', this.validatePage ); });
        this._passwords.forEach((el)=>{ el.removeEventListener('keyup', this.validatePage ); });
        this._passwords.forEach((el)=>{ el.removeEventListener('change', this.validatePage ); });

        this._textareas.forEach((el)=>{ el.removeEventListener('keyup', this.validatePage ); });
        this._textareas.forEach((el)=>{ el.removeEventListener('blur', this.validatePage ); });

        this._selects.forEach((el)=>{ el.removeEventListener('change', this.validatePage ) });

        this._switches.forEach((el)=>{ el.removeEventListener('change', this.validatePage ) });

        if(this._nextButton){
            this._nextButton.removeEventListener('click', this.checkButton );
        }
        if(this._backButton){
            this._backButton.removeEventListener('click', this.checkButton );
        }
        if(this._submitButton){
            this._submitButton.removeEventListener('click', this.checkButton );
        }
    }

    private addEvents(): void{
        this._inputs.forEach((el)=>{ el.addEventListener('blur', this.validatePage ); });
        this._inputs.forEach((el)=>{ el.addEventListener('keyup', this.validatePage ); });
        this._inputs.forEach((el)=>{ el.addEventListener('change', this.validatePage ); });

        this._passwords.forEach((el)=>{ el.addEventListener('blur', this.validatePage ); });
        this._passwords.forEach((el)=>{ el.addEventListener('keyup', this.validatePage ); });
        this._passwords.forEach((el)=>{ el.addEventListener('change', this.validatePage ); });

        this._textareas.forEach((el)=>{ el.addEventListener('keyup', this.validatePage ); });
        this._textareas.forEach((el)=>{ el.addEventListener('blur', this.validatePage ); });

        this._selects.forEach((el)=>{ el.addEventListener('change', this.validatePage ) });

        this._switches.forEach((el)=>{ el.addEventListener('change', this.validatePage ) });

        if(this._nextButton){
            this._nextButton.addEventListener('click', this.checkButton );
        }
        if(this._backButton){
            this._backButton.addEventListener('click', this.checkButton );
        }
        if(this._submitButton){
            this._submitButton.addEventListener('click', this.checkButton );
        }
    }

    private checkForRequired(): void{
        const requiredElements = this._pages[this._active].querySelectorAll('[required]');
        if(requiredElements.length === 0){
            if(this._nextButton){
                this._nextButton.classList.remove('is-disabled');
            }
            if(this._submitButton){
                this._submitButton.classList.remove('is-disabled');
            }
        }
    }

    private hardValidation(): boolean{
        let passedAllValidation = true;

        this._inputs.forEach((el)=>{
            const parent = el.parentElement;
            el.setAttribute('data-touched', 'true');
            if(el.validity.valid){
                parent.classList.add('is-valid');
                parent.classList.remove('is-invalid');
            }else{
                parent.classList.remove('is-valid');
                parent.classList.add('is-invalid');
                passedAllValidation = false;

                const errorEl = parent.querySelector('.js-error');
                if(errorEl){
                    errorEl.innerHTML = el.validationMessage;
                }
            }
        });

        this._selects.forEach((el)=>{
            const parent = el.parentElement;
            const isRequried = (el.getAttribute('required') === null) ? false : true;

            if(isRequried && el.value === 'any'){
                parent.classList.add('is-invalid');
                parent.classList.remove('is-valid');
                passedAllValidation = false;

                const errorEl = parent.querySelector('.js-error');
                if(errorEl){
                    errorEl.innerHTML = 'Please fill out this field.';
                }
            }else{
                parent.classList.remove('is-invalid');
                parent.classList.add('is-valid');
            }
        });

        this._textareas.forEach((el)=>{
            const parent = el.parentElement;
            el.setAttribute('data-touched', 'true');

            if(el.validity.valid){
                parent.classList.add('is-valid');
                parent.classList.remove('is-invalid');
            }else{
                parent.classList.remove('is-valid');
                parent.classList.add('is-invalid');
                passedAllValidation = false;

                const errorEl = parent.querySelector('.js-error');
                if(errorEl){
                    errorEl.innerHTML = el.validationMessage;
                }
            }
        });

        this._switches.forEach((el)=>{
            const inputWrapper = el.parentElement;
            const parent = inputWrapper.parentElement;
            parent.classList.remove('is-valid', 'is-invalid');

            if(el.validity.valid){
                parent.classList.add('is-valid');
            }else{
                parent.classList.add('is-invalid');
                passedAllValidation = false;

                const errorObject = inputWrapper.querySelector('.js-error');
                if(errorObject){
                    errorObject.innerHTML = el.validationMessage;
                }
            }
        });

        this._passwords.forEach((el)=>{
            const parent = el.parentElement;
            const forEl = <HTMLInputElement>this._pages[this._active].querySelector(`.js-password input[name="${parent.getAttribute('data-for')}"]`);
            el.setAttribute('data-touched', 'true');
            parent.classList.remove('is-valid', 'is-invalid');

            if(el.validity.valid && forEl.value === el.value){
                parent.classList.add('is-valid');
            }else{
                parent.classList.add('is-invalid');
                passedAllValidation = false;

                const errorEl = parent.querySelector('.js-error');
                if(errorEl){
                    if(!el.validity.valid){
                        errorEl.innerHTML = el.validationMessage;
                    }
                    else{
                        errorEl.innerHTML = 'Passwords don\'t match.';
                    }
                }
            }
        });

        return passedAllValidation;
    }

    private validatePage:EventListener = ()=>{
        let isValid = true;

        this._inputs.forEach((el)=>{
            if(!el.validity.valid || el.value === ''){
                isValid = false;
            }
        });

        if(isValid){
            this._textareas.forEach((el)=>{
                if(!el.validity.valid || el.value === ''){
                    isValid = false;
                }
            });
        }

        if(isValid){
            this._selects.forEach((el)=>{
                if(el.value === 'any'){
                    isValid = false;
                }
            });
        }

        if(isValid){
            this._switches.forEach((el)=>{
                if(!el.validity.valid){
                    isValid = false;
                }
            });
        }

        if(isValid){
            this._passwords.forEach((el)=>{
                const parent = el.parentElement;
                const forEl = <HTMLInputElement>this._pages[this._active].querySelector(`.js-password input[name="${parent.getAttribute('data-for')}"]`);

                if(!el.validity.valid || forEl.value !== el.value){
                    isValid = false;
                }
            });
        }

        if(isValid){
            if(this._nextButton){
                this._nextButton.classList.remove('is-disabled');
            }
            if(this._submitButton){
                this._submitButton.classList.remove('is-disabled');
            }
        }else{
            if(this._nextButton){
                this._nextButton.classList.add('is-disabled');
            }
            if(this._submitButton){
                this._submitButton.classList.add('is-disabled');
            }
        }
    }

    private switchPage(direction:number = -1): void{
        const rows = Array.from(this._pages[this._active].querySelectorAll('.js-row'));

        anime({
            targets: rows,
            opacity: [1, 0],
            translateY: [0, '-25px'],
            duration: 450,
            easeing: easing.sharp,
            delay: anime.stagger(50),
            complete: ()=>{
                this.removeEvents();
                this._pages[this._active].classList.remove('is-active-page');
                this._tabs[this._active].classList.remove('is-active-page');

                this._active += direction;
                this._pages[this._active].classList.add('is-active-page');
                this._tabs[this._active].classList.add('is-active-page');

                const newRows = Array.from(this._pages[this._active].querySelectorAll('.js-row'));
                anime({
                    targets: newRows,
                    opacity: [0, 1],
                    translateY: ['25px', 0],
                    duration: 300,
                    easing: easing.in,
                    delay: anime.stagger(50),
                    complete: ()=>{
                        this.getPageElements();
                        this.addEvents();
                        this.checkForRequired();
                    }
                });
            }
        });
    }

    private submitForm(): void{
        const form = this.el.querySelector('form');
        const csrfToken = <HTMLInputElement>form.querySelector('input[name="CRAFT_CSRF_TOKEN"]');
        csrfToken.value = html.getAttribute('data-csrf');
        const data = new FormData(form);
        const method = form.getAttribute("method");
        const action = <HTMLInputElement>form.querySelector('input[name="action"]');

        const request = new XMLHttpRequest();

        request.open(method, `${window.location.origin}/actions/${action.value}`, true);
        request.setRequestHeader("Cache-Control", "no-cache");
        request.setRequestHeader("X-Requested-With", "XMLHttpRequest");
        request.setRequestHeader("HTTP_X_REQUESTED_WITH", "XMLHttpRequest");
        request.onload = (e:ProgressEvent)=>{
            const request = <XMLHttpRequest>e.currentTarget;
            const response = JSON.parse(request.responseText);
            console.log(response);
        }
        request.send(data);

        const rows = Array.from(this._pages[this._active].querySelectorAll('.js-row'));
        const tabs = this.el.querySelector('.js-tabs');

        if(tabs){
            anime({
                targets: tabs,
                opacity: [1, 0],
                duration: 150,
                easeing: easing.ease
            });
        }

        anime({
            targets: rows,
            opacity: [1, 0],
            translateY: [0, '-25px'],
            duration: 450,
            easeing: easing.sharp,
            delay: anime.stagger(50)
        });
    }

    private checkButton:EventListener = (e:Event)=>{
        e.preventDefault();
        e.stopImmediatePropagation();
        const target = <Element>e.currentTarget;
        const type = target.getAttribute('data-type');

        if(type === 'back'){
            this.switchPage();
            return;
        }

        if(this.hardValidation()){
            if(type === 'next'){
                this.switchPage(1);
            }
            else if(type === 'submit'){
                this.submitForm();
            }
        }
    }

    public destroy(): void{
        super.destroy(isDebug, Freeform.MODULE_NAME);
    }
}
