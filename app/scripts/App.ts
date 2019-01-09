import { APP_NAME, html, isDebug, setDebug, scrollTrigger } from './env';

import * as modules from './modules';
import TransitionManager from './transitions/TransitionManager';
import polyfill from './polyfill';

class App{
    private _modules:           { [index:string] : Function };
    private _currentModules:    Array<Module>;
    private _transitionManager: TransitionManager;
    private _touchSupport:      boolean;
    private _scrollDistance:    number;
    private _prevScroll:        number;

    constructor(){
        this._modules            = modules;
        this._currentModules     = [];
        this._transitionManager  = null;
        this._touchSupport       = ('ontouchstart' in window) || (navigator.maxTouchPoints > 0) || (navigator.msMaxTouchPoints > 0);

        this._prevScroll        = 0;
        this._scrollDistance    = 0;

        this.init();
    }

    /**
     * Used to call any methods needed when the application initially loads
     */
    private init(): void{
        html.classList.remove('has-no-js');
        html.classList.add('has-js');

        // If user is using IE 11 load the polyfill
        if('-ms-scroll-limit' in document.documentElement.style && '-ms-ime-align' in document.documentElement.style){
            polyfill();
        }

        // Check for production debug status
        if(html.getAttribute('data-debug') !== null){
            setDebug(true);
        }

        if(this._touchSupport){
            html.classList.add('has-touch');
            html.classList.remove('has-no-touch');
        }

        window.addEventListener('load', e => { html.classList.add('has-loaded') });
        window.addEventListener('scroll', e => this.handleScroll() );

        document.addEventListener('seppuku', e => this.deleteModule(<CustomEvent>e) ); // Listen for our custom events

        this.initModules(); // Get initial modules
        this.handleStatus(); // Check the users visitor status

        this._transitionManager = new TransitionManager(this);

        if(!isDebug){
            this.createEasterEgg();
        }
    }

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
     * If the user is scrolling down the page add the scroll delta to
     * the total tracked scroll distance. If the distance passes the
     * trigger distance add the `has-scrolled` status class.
     * If the user scrolled up reset the scroll distance and remove
     * the `has-scrolled` status class.
     */
    private handleScroll(): void{
        const currentScroll:number = window.scrollY;

        if(!html.classList.contains('has-scrolled') && currentScroll >= this._prevScroll){
            this._scrollDistance += currentScroll - this._prevScroll;

            if(this._scrollDistance >= scrollTrigger){
                html.classList.add('has-scrolled');
            }
        }
        else if(html.classList.contains('has-scrolled') && currentScroll < this._prevScroll){
            html.classList.remove('has-scrolled');
            this._scrollDistance = 0;
        }

        this._prevScroll = currentScroll;
    }

    /**
     * Sets relevant classes based on the users visitor status
     * Uses local storage to store status trackers
     * If the user has not visited in 24 hours add a first of day class
     * Always reset the daily visit time on every visit
     * @todo Check if we need permision to set these trackers
     */
    private handleStatus(): void{
        // Handle unique visitor status
        if(window.localStorage.getItem(`${APP_NAME}_UniqueVisit`) === null){
            html.classList.add('is-unique-visitor');
            window.localStorage.setItem(`${APP_NAME}_UniqueVisit`, 'visited');
        }

        // Handle first visit of the day (in 24 hours) status
        if(window.localStorage.getItem(`${APP_NAME}_DailyVisit`) === null || (Date.now() - parseInt(window.localStorage.getItem(`${APP_NAME}_UniqueVisit`)) > 86400000)){
            html.classList.add('is-first-of-day');
        } else {
            html.classList.add('is-returning');
        }
        window.localStorage.setItem(`${APP_NAME}_DailyVisit`, Date.now().toString()); // Always update daily visit status
    }

    /**
     * Gets all module references in the document and creates a new module
     * If a module already has a UUID we won't do anything since it already
     * has a module associated with the HTML element
     */
    public initModules(): void{
        const modules = Array.from(document.querySelectorAll('[data-module]'));

        modules.forEach((module)=>{
            const moduleType = module.getAttribute('data-module');
            const moduleUUID = module.getAttribute('data-uuid');

            if(this._modules[moduleType] !== undefined && moduleUUID === null){
                const newModule = new this._modules[moduleType].prototype.constructor(module, this);
                this._currentModules.push(newModule);
                newModule.init();
            }
            else if(this._modules[moduleType] === undefined){
                if(isDebug){
                    console.log('%cUndefined Module: '+`%c${moduleType}`,'color:#ff6e6e','color:#eee');
                }
            }
        });
    }

    /**
     * Get all elements on the screen using the `data-module` attribute
     * If an element already has a UUID it's an element that survived the page transition
     * Remove (and trigger destory()) any elements module in the current modules list that didn't survive the transition
     */
    public deleteModules(): void{
        const modules = Array.from(document.querySelectorAll('[data-module]'));
        const survivingModules:Array<Element> = [];
        const deadModules:Array<any> = [];

        modules.forEach((module)=>{ if(module.getAttribute('data-uuid') !== null) survivingModules.push(module); });

        this._currentModules.map((currModule)=>{
            let survived:boolean = false;
            survivingModules.map((survivingModule)=>{
                if(survivingModule.getAttribute('data-uuid') === currModule.uuid){
                    survived = true;
                }
            });
            if(!survived){
                deadModules.push(currModule);
            }
        });

        if(deadModules.length){
            deadModules.map((deadModule)=>{
                for(let i = 0; i < this._currentModules.length; i++){
                    if(this._currentModules[i].uuid === deadModule.uuid){
                        this._currentModules[i].destroy();
                        this._currentModules.splice(i);
                    }
                }
            });
        }
    }

    /**
     * Delete a module based on the modules UUID
     * @param {CustomEvent} e
     */
    public deleteModule(e:CustomEvent): void{
        const moduleID = e.detail.id;
        if(!moduleID){
            if(isDebug){
                console.log('%cDelete Module Error: '+'%cmodule UUID was not sent in the custom event','color:#ff6e6e','color:#eee');
            }
            return;
        }

        for(let i = 0; i < this._currentModules.length; i++){
            if(this._currentModules[i].uuid === moduleID){
                this._currentModules[i].destroy();
                const index = this._currentModules.indexOf(this._currentModules[i]);
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
