import Env from './env';
import * as modules from './modules';
import ComplexContent from './complex-content/ComplexContent';
import TransitionManager from './transitions/TransitionManager';
import polyfill from './polyfill';

import * as v4 from 'uuid/v4';
import DeviceManager from 'fuel-device-manager';

export default class App{

    public static ANIMATION_DELAY = 1000;

    private _modules:           { [index:string] : Function };
    private _currentModules:    Array<Module>;
    private _transitionManager: TransitionManager;
    private _scrollDistance:    number;
    private _prevScroll:        number;
    private _trackedTouches:    Array<Element>;

    public env:                 Env;
    public complexContent:      ComplexContent;

    constructor(){
        this._modules            = modules;
        this._currentModules     = [];
        this._transitionManager  = null;
        this._prevScroll        = 0;
        this._scrollDistance    = 0;
        this._trackedTouches    = [];

        this.env                = new Env();
        this.complexContent     = null;

        this.init();
    }

    /**
     * Used to call any methods needed when the application initially loads
     */
    private init(): void{
        // If user is using IE 11 load the polyfill
        if(DeviceManager.isIE){
            polyfill();
        }

        // Check for production debug status
        if(Env.HTML.getAttribute('data-debug') !== null){
            this.env.setDebug(true);
        }

        new DeviceManager(this.env.getDebugStatus(), true);

        if(DeviceManager.supportsTouch){
            this.getTouchElements();
        }

        window.addEventListener('load', e => { Env.HTML.classList.add('has-loaded') });
        window.addEventListener('scroll', this.handleScroll, { passive: true } );

        this.initModules(); // Get initial modules
        this.handleStatus(); // Check the users visitor status

        this._transitionManager = new TransitionManager(this);
        this.complexContent = new ComplexContent(this);

        if(!this.env.getDebugStatus()){
            this.createEasterEgg();
        }
    }

    /**
     * Called when the `touchstart` event fires on the documents body.
     */
    private userTouched: EventListener = ()=>{
        document.body.removeEventListener('touchstart', this.userTouched);
        Env.HTML.classList.add('has-touched');
        Env.HTML.classList.remove('has-not-touched');
    }

    /**
     * Called when the `touchstart` event fires on an element that has a `js-touch` class.
     */
    private userTouchedElement: EventListener = (e:Event)=>{
        const target = <HTMLElement>e.currentTarget;
        target.classList.add('has-touch');
    }

    /**
     * Called when the `touchend` or `touchcancel` or `touchleave` event(s) fire on
     * an element with the `js-touch` class.
     */
    private userReleasedTouchedElement: EventListener = (e:Event)=>{
        const target = <HTMLElement>e.currentTarget;
        target.classList.remove('has-touch');
    }

    /**
     * Grabs all the current touch elements and removes any missing elements
     * event listeners.
     */
    private purgeTouchElements(): void{

        // Do nothing on non-touch devices
        if(!DeviceManager.supportsTouch){
            return;
        }

        const currentElements = Array.from(document.body.querySelectorAll('.js-touch'));
        const deadElements = [];

        // Check if there are elements to check
        if(this._trackedTouches.length === 0){
            return;
        }

        // Loop through all tracked touch elements
        for(let i = 0; i < this._trackedTouches.length; i++){
            let survived = false;

            // Compare aginst all current touch elements
            for(let k = 0; k < currentElements.length; k++){
                if(this._trackedTouches[i] === currentElements[k]){
                    survived = true;
                }
            }

            if(!survived){
                deadElements.push(this._trackedTouches[i]);
            }
        }

        // Verify we have elements to remove
        if(deadElements.length){

            // Loop though all the elements we need to remove
            deadElements.map((deadEl)=>{

                // Loop through all the current elements
                for(let i = 0; i < this._trackedTouches.length; i++){

                    // Check if the current element matches the element marked for death
                    if(this._trackedTouches[i] === deadEl){
                        // Remove event listeners
                        deadEl.removeEventListener('touchstart', this.userTouchedElement );
                        deadEl.removeEventListener('touchend', this.userReleasedTouchedElement );
                        deadEl.removeEventListener('touchleave', this.userReleasedTouchedElement );
                        deadEl.removeEventListener('touchcancel', this.userReleasedTouchedElement );

                        // Get the elements index
                        const index = this._trackedTouches.indexOf(this._trackedTouches[i]);

                        // Splice the array at the index and shift the remaining elements
                        this._trackedTouches.splice(index, 1);
                    }
                }
            });
        }
    }

    /**
     * Gets all the un-touched touch elements and adds touch event listeners
     */
    private getTouchElements(): void{

        // Do nothing on non-touch devices
        if(!DeviceManager.supportsTouch){
            return;
        }

        const elements = Array.from(document.body.querySelectorAll('.js-touch:not(.is-touch-tracked)'));

        elements.forEach((el)=>{
            el.classList.add('is-touch-tracked');
            el.addEventListener('touchstart', this.userTouchedElement );
            el.addEventListener('touchend', this.userReleasedTouchedElement );
            el.addEventListener('touchleave', this.userReleasedTouchedElement );
            el.addEventListener('touchcancel', this.userReleasedTouchedElement );
            this._trackedTouches.push(el);
        });
    }

    /**
     * Called by the `TransitionManager` class
     */
    public updateTouchElements(): void{

        // Do nothing on non-touch devices
        if(!DeviceManager.supportsTouch){
            return;
        }

        this.purgeTouchElements();
        this.getTouchElements();
    }

    /**
     * Called on a production build of the application.
     * Displays the Pageworks logo in ASCII along with a link to the company website.
     */
    private createEasterEgg(): void{
        const lines = [
            '',
            '                                          `..-::///+++++///::-.``',
            '                                     `-:/+++++++++++++++++++++++/:-`',
            '                                 `.:/+++++++++++++++++++++++++++++++/-.',
            '                               `:/+++++++++++++++++++++++++++++++++++++/-`',
            '                             ./+++++++++++++++++++++++++++++++++++++++++++:`',
            '                           ./+++++++++++++++++++++++++++++++++++++++++++++++:`',
            '                         `:++++++++++++++++++++++++++++++++++++++++++++++++++/-',
            '                        `/++++++++++++++++++++++//:-...``..--:/++++++++++++++++:`',
            '                       ./+++++++++++++++++++/:-`              `.:+++++++++++++++/`',
            '                      ./+++++++++++++++++/:.     ``.---..        ./++++++++++++++/`',
            '                     `/++++++++++++++++:.    `-:/+++++++++:.      .+++++++++++++++:',
            '                     :++++++++++++++/-`   .-/+++++++++++++++-      /+++++++++++++++-',
            '                    `+++++++++++++/-`  `-/++++++++++++++++++/     `++++++++++++++++/',
            '                    -+++++++++++/-   .:++++++++++++++++++++/.    `:+++++++++++++++++.',
            '                    /+++++++++/-` `-/++++++++++++++++++++/.     ./++++++++++++++++++-',
            '                    /+++++++/-` `-++++/::--.........--..`     .:++++++++++++++++++++:',
            '                    /+++++/.  `:++/-.` ```                `.:/++++++++++++++++++++++:',
            '                    /+++:.  .:++/..-//++++++//:--.....-::/++++++++++++++++++++++++++- ',
            '                    :/-` `-/+++/./++++++++++++++++++++++++++++++++++++++++++++++++//-.`````',
            '                 `..` `-/++++++::++++++++++++++++++++++++/:-../+++++////++++++/:-.--',
            '             `...`   -+++++++++::++++++++++++++++++++++:.  `-/++/-.`   -+++/-..:/++.',
            '         `...`       `/+++++++++-/++++++++++++++++++:-`  .:++/-`  `  -/+/-``-/++++:',
            '  ````..``            ./+++++++++::/++++++++++++/:...   `--.` `-:-   ``` .:++++++/`',
            '``                     ./+++++++++/::::::/::::--:/++.    `.-:/+++-`  `.-/+++++++/`',
            '                        `/++++++++++++++++/++++++++++/://++++++++++/+++++++++++:',
            '                         `:++++++++++++++++++++++++++++++++++++++++++++++++++/-',
            '                           `:+++++++++++++++++++++++++++++++++++++++++++++++:`',
            '                             ./+++++++++++++++++++++++++++++++++++++++++++:`',
            '                               `:/+++++++++++++++++++++++++++++++++++++/-`',
            '                                  .:/+++++++++++++++++++++++++++++++/:.',
            '                                     `-:/+++++++++++++++++++++++/:.`',
            '                                         `..-::///++++////::-.``',
            ''
        ];
        console.log('                                                %cMade with ❤️ by Pageworks', 'font-size: 16px; color: #569eff;');
        console.log('                                       %cCheck us out at http://www.page.works/', 'color: #569eff; font-size: 16px;');
        console.log(`%c${lines.join('\n').toString()}`, 'color: #a7ab2d; font-size: 14px;');
    }

    /**
     * Called when the user scrolls.
     * Manages the `has-scrolled` status class attached to the document.
     */
    private handleScroll:EventListener =()=>{
        const currentScroll:number = window.pageYOffset;

        if(!Env.HTML.classList.contains('has-scrolled') && currentScroll >= this._prevScroll){
            this._scrollDistance += currentScroll - this._prevScroll;

            if(this._scrollDistance >= Env.SCROLL_TRIGGER){
                Env.HTML.classList.add('has-scrolled');
            }
        }
        else if(Env.HTML.classList.contains('has-scrolled') && currentScroll < this._prevScroll){
            Env.HTML.classList.remove('has-scrolled');
            this._scrollDistance = 0;
        }

        this._prevScroll = currentScroll;
    }

    /**
     * Sets relevant classes based on the users visitor status.
     * Uses local storage to store status trackers.
     * @todo Check if we need permision to set these trackers.
     */
    private handleStatus(): void{
        // Handle unique visitor status
        if(window.localStorage.getItem(`${Env.APP_NAME}_UniqueVisit`) === null){
            Env.HTML.classList.add('is-unique-visitor');
            window.localStorage.setItem(`${Env.APP_NAME}_UniqueVisit`, 'visited');
        }

        // Handle first visit of the day (in 24 hours) status
        if(window.localStorage.getItem(`${Env.APP_NAME}_DailyVisit`) === null || (Date.now() - parseInt(window.localStorage.getItem(`${Env.APP_NAME}_UniqueVisit`)) > 86400000)){
            Env.HTML.classList.add('is-first-of-day');
        } else {
            Env.HTML.classList.add('is-returning');
        }
        window.localStorage.setItem(`${Env.APP_NAME}_DailyVisit`, Date.now().toString()); // Always update daily visit status
    }

    /**
     * Parses supplied string and returns an array of module names.
     * @returns `string[]`
     * @param { string } data - a string taken from an elements `data-modules` attribute
     */
    private getModuleNames(data:string): Array<string>{
        // Trim whitespace and spit the string by whitespace
        let modules = data.trim().split(/\s+/gi);

        // Fixes array for empty `data-module` attributes
        if(modules.length === 1 && modules[0] === ''){
            modules = [];
        }

        return modules;
    }

    /**
     * Gets all module references in the document and creates a new module
     * If a module already has a UUID we won't do anything since it already
     * has a module associated with the HTML element
     */
    public initModules(): void{
        const modules = Array.from(document.querySelectorAll('[data-module]'));

        modules.forEach((module)=>{
            const requestedModules = module.getAttribute('data-module');
            const modules = this.getModuleNames(requestedModules);

            if(modules.length === 0){
                if(this.env.getDebugStatus()){
                    console.log('%cEmpty Module Attribute Detected','color:#ff6e6e');
                }
                return;
            }

            const existingUUID = module.getAttribute('data-uuid');
            const newUUID = v4();

            for(let i = 0; i < modules.length; i++){
                if(this._modules[modules[i]] !== undefined && existingUUID === null){
                    const newModule = new this._modules[modules[i]].prototype.constructor(module, newUUID, this);
                    this._currentModules.push(newModule);
                    newModule.init();
                }
                else if(this._modules[modules[i]] === undefined){
                    if(this.env.getDebugStatus()){
                        console.log('%cUndefined Module: '+`%c${modules[i]}`,'color:#ff6e6e','color:#eee');
                    }
                }
            }
        });
    }

    /**
     * Get all elements on the screen using the `data-module` attribute.
     * If an element already has a UUID it's an element that survived the page transition.
     * Remove (and trigger destory()) any elements module in the current modules list that didn't survive the transition.
     */
    public deleteModules(): void{
        const modules = Array.from(document.body.querySelectorAll('[data-module]'));
        const deadModules:Array<any> = [];

        // Loop through all currently tracked modules
        this._currentModules.map((currModule)=>{
            let survived:boolean = false;

            // Loop through all the modules on the page
            modules.forEach((module)=>{
                // If the module has a UUID the element survived the page transition
                if(module.getAttribute('data-uuid') === currModule.uuid){
                    survived = true;
                }
            });

            // If the current module doesn't match up with any UUIDs avialable on the surviving elements mark the module for destruction
            if(!survived){
                deadModules.push(currModule);
            }
        });

        // Verify we have modules to destroy
        if(deadModules.length){

            // Loop though all the modules we need to destroy
            deadModules.map((deadModule)=>{

                // Loop through all the current modules
                for(let i = 0; i < this._currentModules.length; i++){

                    // Check if the currend modules UUID matches the UUID of our module marked for destruction
                    if(this._currentModules[i].uuid === deadModule.uuid){

                        // Trigger module destruction
                        this._currentModules[i].destroy();

                        // Get the modules index in our current module array
                        const index = this._currentModules.indexOf(this._currentModules[i]);

                        // Splice the array at the index and shift the remaining modules
                        this._currentModules.splice(index, 1);
                    }
                }
            });
        }
    }

    /**
     * Delete a module based on the modules UUID.
     * @param { string } uuid - provided by the `AbstractModule` class
     */
    public deleteModule(uuid:string): void{
        if(!uuid){
            if(this.env.getDebugStatus()){
                console.log('%cDelete Module Error: '+'%cmodule UUID was not sent in the custom event','color:#ff6e6e','color:#eee');
            }
            return;
        }

        // Loop through all the current modules
        for(let i = 0; i < this._currentModules.length; i++){

            // Check if the current modules UUID matches the UUID of the module we're destroying
            if(this._currentModules[i].uuid === uuid){

                // Trigger module destruciton
                this._currentModules[i].destroy();

                // Get the modules index in our current module array
                const index = this._currentModules.indexOf(this._currentModules[i]);

                // Splice the array at the index and shift the remaining modules
                this._currentModules.splice(index, 1);
            }
        }
    }
}

/**
 * IIFE for launching the application
 */
(()=>{
    new App();
})();
