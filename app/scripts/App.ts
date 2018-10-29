import { APP_NAME, html, isDebug } from './env';

import * as modules from './modules';
import TransitionManager from './transitions/TransitionManager';

/**
 * FontAwesome Pro requires an access token to be set in the .npmrc file
 * @see https://fontawesome.com/
 */
import '@fortawesome/fontawesome-pro/js/all.js';

class App{
    modules:{ [index:string] : Function };
    currentModules: Array<Module>;
    transitionManager: TransitionManager;
    touchSupport: boolean

    constructor(){
        this.modules            = modules;
        this.currentModules     = [];
        this.transitionManager  = null;
        this.touchSupport       = ('ontouchstart' in window) || (navigator.maxTouchPoints > 0) || (navigator.msMaxTouchPoints > 0);

        this.init();
    }

    /**
     * Used to call any methods needed when the application initially loads
     */
    init(){
        html.classList.remove('has-no-js');
        html.classList.add('has-js');

        if(this.touchSupport){
            html.classList.add('has-touch');
            html.classList.remove('has-no-touch');
        }

        window.addEventListener('load', e => { html.classList.add('has-loaded') });

        document.addEventListener('seppuku', e => this.deleteModule(<CustomEvent>e) ); // Listen for our custom events

        this.initModules(); // Get initial modules
        this.handleStatus(); // Check the users visitor status

        this.transitionManager = new TransitionManager(this);
    }

    /**
     * Sets relevant classes based on the users visitor status
     * Uses local storage to store status trackers
     * If the user has not visited in 24 hours add a first of day class
     * Always reset the daily visit time on every visit
     * @todo Check if we need permision to set these trackers
     */
    handleStatus(){
        // Handle unique visitor status
        if(window.localStorage.getItem(`${APP_NAME}_UniqueVisit`) === null){
            html.classList.add('is-unique-visitor');
            window.localStorage.setItem(`${APP_NAME}_UniqueVisit`, 'visited');
        }

        // Handle first visit of the day (in 24 hours) status
        if(window.localStorage.getItem(`${APP_NAME}_DailyVisit`) === null || (Date.now() - parseInt(window.localStorage.getItem(`${APP_NAME}_UniqueVisit`)) > 86400000)){
            html.classList.add('is-first-of-day');
        } else html.classList.add('is-returning');
        window.localStorage.setItem(`${APP_NAME}_DailyVisit`, Date.now().toString()); // Always update daily visit status
    }

    /**
     * Gets all module references in the document and creates a new module
     * If a module already has a UUID we won't do anything since it already
     * has a module associated with the HTML element
     */
    initModules(){
        const modules = document.querySelectorAll('[data-module]');

        modules.forEach((module)=>{
            const moduleType = module.getAttribute('data-module');
            const moduleUUID = module.getAttribute('data-uuid');

            if(this.modules[moduleType] !== undefined && moduleUUID === null){
                const newModule = new this.modules[moduleType].prototype.constructor(module);
                this.currentModules.push(newModule);
                newModule.init();
            }else{
                if(isDebug) console.log('%cUndefined Module: '+`%c${moduleType}`,'color:#ff6e6e','color:#eee');
            }
        });
    }

    /**
     * Get all elements on the screen using the `data-module` attribute
     * If an element already has a UUID it's an element that survived the page transition
     * Remove (and trigger destory()) any elements module in the current modules list that didn't survive the transition
     */
    deleteModules(){
        const modules = document.querySelectorAll('[data-module]');
        const survivingModules:Array<Element> = [];
        const deadModules:Array<any> = [];

        modules.forEach((module)=>{ if(module.getAttribute('data-uuid') !== null) survivingModules.push(module); });

        this.currentModules.map((currModule)=>{
            let survived:boolean = false;
            survivingModules.map((survivingModule)=>{ if(survivingModule.getAttribute('data-uuid') === currModule.uuid) survived = true; });
            if(!survived) deadModules.push(currModule);
        });

        if(deadModules.length){
            deadModules.map((deadModule)=>{
                for(let i = 0; i < this.currentModules.length; i++){
                    if(this.currentModules[i].uuid === deadModule.uuid){
                        this.currentModules[i].destroy();
                        this.currentModules.splice(i);
                    }
                }
            });
        }
    }

    /**
     * Delete a module based on the modules UUID
     * @param {CustomEvent} e
     */
    public deleteModule(e:CustomEvent){
        const moduleID = e.detail.id;
        if(!moduleID){
            if(isDebug) console.log('%cDelete Module Error: '+'%cmodule UUID was not sent in the custom event','color:#ff6e6e','color:#eee');
            return;
        }

        for(let i = 0; i < this.currentModules.length; i++){
            if(this.currentModules[i].uuid === moduleID){
                this.currentModules[i].destroy();
                const index = this.currentModules.indexOf(this.currentModules[i]);
                this.currentModules.splice(index, 1);
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