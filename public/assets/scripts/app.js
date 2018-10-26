/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 			Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 		}
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// create a fake namespace object
/******/ 	// mode & 1: value is a module id, require it
/******/ 	// mode & 2: merge all properties of value into the ns
/******/ 	// mode & 4: return value when already ns object
/******/ 	// mode & 8|1: behave like require
/******/ 	__webpack_require__.t = function(value, mode) {
/******/ 		if(mode & 1) value = __webpack_require__(value);
/******/ 		if(mode & 8) return value;
/******/ 		if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/ 		var ns = Object.create(null);
/******/ 		__webpack_require__.r(ns);
/******/ 		Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/ 		if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/ 		return ns;
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ({

/***/ "./app/sass/main.scss":
/*!****************************!*\
  !*** ./app/sass/main.scss ***!
  \****************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

// extracted by mini-css-extract-plugin

/***/ }),

/***/ "./app/scripts/App.ts":
/*!****************************!*\
  !*** ./app/scripts/App.ts ***!
  \****************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
var env_1 = __webpack_require__(/*! ./env */ "./app/scripts/env.ts");
var modules = __webpack_require__(/*! ./modules */ "./app/scripts/modules.ts");
var TransitionManager_1 = __webpack_require__(/*! ./transitions/TransitionManager */ "./app/scripts/transitions/TransitionManager.ts");
var App = /** @class */ (function () {
    function App() {
        this.modules = modules;
        this.currentModules = [];
        this.transitionManager = null;
        this.init();
    }
    /**
     * Used to call any methods needed when the application initially loads
     */
    App.prototype.init = function () {
        var _this = this;
        env_1.html.classList.remove('has-no-js');
        env_1.html.classList.add('has-js');
        window.addEventListener('load', function (e) { env_1.html.classList.add('has-loaded'); });
        document.addEventListener('seppuku', function (e) { return _this.deleteModule(e); }); // Listen for our custom events
        this.initModules(); // Get initial modules
        this.handleStatus(); // Check the users visitor status
        this.transitionManager = new TransitionManager_1.default(this);
    };
    /**
     * Sets relevant classes based on the users visitor status
     * Uses local storage to store status trackers
     * If the user has not visited in 24 hours add a first of day class
     * Always reset the daily visit time on every visit
     * @todo Check if we need permision to set these trackers
     */
    App.prototype.handleStatus = function () {
        // Handle unique visitor status
        if (window.localStorage.getItem(env_1.APP_NAME + "_UniqueVisit") === null) {
            env_1.html.classList.add('is-unique-visitor');
            window.localStorage.setItem(env_1.APP_NAME + "_UniqueVisit", 'visited');
        }
        // Handle first visit of the day (in 24 hours) status
        if (window.localStorage.getItem(env_1.APP_NAME + "_DailyVisit") === null || (Date.now() - parseInt(window.localStorage.getItem(env_1.APP_NAME + "_UniqueVisit")) > 86400000)) {
            env_1.html.classList.add('is-first-of-day');
        }
        else
            env_1.html.classList.add('is-returning');
        window.localStorage.setItem(env_1.APP_NAME + "_DailyVisit", Date.now().toString()); // Always update daily visit status
    };
    /**
     * Gets all module references in the document and creates a new module
     * If a module already has a UUID we won't do anything since it already
     * has a module associated with the HTML element
     */
    App.prototype.initModules = function () {
        var _this = this;
        var modules = document.querySelectorAll('[data-module]');
        modules.forEach(function (module) {
            var moduleType = module.getAttribute('data-module');
            var moduleUUID = module.getAttribute('data-uuid');
            if (_this.modules[moduleType] !== undefined && moduleUUID === null) {
                var newModule = new _this.modules[moduleType].prototype.constructor(module);
                _this.currentModules.push(newModule);
                newModule.init();
            }
            else {
                if (env_1.isDebug)
                    console.log('%cUndefined Module: ' + ("%c" + moduleType), 'color:#ff6e6e', 'color:#eee');
            }
        });
    };
    /**
     * Get all elements on the screen using the `data-module` attribute
     * If an element already has a UUID it's an element that survived the page transition
     * Remove (and trigger destory()) any elements module in the current modules list that didn't survive the transition
     */
    App.prototype.deleteModules = function () {
        var _this = this;
        var modules = document.querySelectorAll('[data-module]');
        var survivingModules = [];
        var deadModules = [];
        modules.forEach(function (module) { if (module.getAttribute('data-uuid') !== null)
            survivingModules.push(module); });
        this.currentModules.map(function (currModule) {
            var survived = false;
            survivingModules.map(function (survivingModule) { if (survivingModule.getAttribute('data-uuid') === currModule.uuid)
                survived = true; });
            if (!survived)
                deadModules.push(currModule);
        });
        if (deadModules.length) {
            deadModules.map(function (deadModule) {
                for (var i = 0; i < _this.currentModules.length; i++) {
                    if (_this.currentModules[i].uuid === deadModule.uuid) {
                        _this.currentModules[i].destroy();
                        _this.currentModules.splice(i);
                    }
                }
            });
        }
    };
    /**
     * Delete a module based on the modules UUID
     * @param {CustomEvent} e
     */
    App.prototype.deleteModule = function (e) {
        var moduleID = e.detail.id;
        if (!moduleID) {
            if (env_1.isDebug)
                console.log('%cDelete Module Error: ' + '%cmodule UUID was not sent in the custom event', 'color:#ff6e6e', 'color:#eee');
            return;
        }
        for (var i = 0; i < this.currentModules.length; i++) {
            if (this.currentModules[i].uuid === moduleID) {
                this.currentModules[i].destroy();
                var index = this.currentModules.indexOf(this.currentModules[i]);
                this.currentModules.splice(index, 1);
            }
        }
    };
    return App;
}());
/**
 * IIFE for launching the application
 */
(function () {
    new App();
})();


/***/ }),

/***/ "./app/scripts/env.ts":
/*!****************************!*\
  !*** ./app/scripts/env.ts ***!
  \****************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
var APP_NAME = 'REPLACE_ME';
exports.APP_NAME = APP_NAME;
var html = document.documentElement;
exports.html = html;
var body = document.body;
exports.body = body;
var pjaxContainer = '.js-pjax-container';
exports.pjaxContainer = pjaxContainer;
var pjaxWrapper = '.js-pjax-wrapper';
exports.pjaxWrapper = pjaxWrapper;
var isDebug = (html.getAttribute('data-debug') !== null) ? !!html.getAttribute('data-debug') : false;
exports.isDebug = isDebug;


/***/ }),

/***/ "./app/scripts/modules.ts":
/*!********************************!*\
  !*** ./app/scripts/modules.ts ***!
  \********************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
var _Example_1 = __webpack_require__(/*! ./modules/_Example */ "./app/scripts/modules/_Example.ts");
exports.Example = _Example_1.default;


/***/ }),

/***/ "./app/scripts/modules/AbstractModule.ts":
/*!***********************************************!*\
  !*** ./app/scripts/modules/AbstractModule.ts ***!
  \***********************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
var uuid = __webpack_require__(/*! uuid/v4 */ "./node_modules/uuid/v4.js");
var default_1 = /** @class */ (function () {
    function default_1(el) {
        this.$el = el; // Sets initial reference to the element that generated the module
        this.uuid = uuid(); // Generates a UUID using UUID v4
        this.$el.setAttribute('data-uuid', this.uuid); // Sets modules UUID to be used later when handling modules destruction
    }
    default_1.prototype.init = function () { };
    /**
     * Acts as the modules self-destruct method, when called the module will be removed from the page
     * Used when removing a specific module, call is initiated by a module
     */
    default_1.prototype.seppuku = function () {
        var event = new CustomEvent('seppuku', {
            detail: {
                id: this.uuid
            }
        });
        document.dispatchEvent(event);
    };
    /**
     * Called by a module, removes attribute and logs out destruction to the console
     * Used when the page transitions, call is initiated by applicaiton
     * You shouldn't call this method, if you need to remove a module use the `seppuku` method
     * @param {boolean} isDebug
     * @param {string} MODULE_NAME
     */
    default_1.prototype.destroy = function (isDebug, MODULE_NAME) {
        this.$el.removeAttribute('data-uuid');
        if (isDebug)
            console.log('%c[module] ' + ("%cDestroying " + MODULE_NAME + " - " + this.uuid), 'color:#ff6e6e', 'color:#eee');
    };
    return default_1;
}());
exports.default = default_1;


/***/ }),

/***/ "./app/scripts/modules/_Example.ts":
/*!*****************************************!*\
  !*** ./app/scripts/modules/_Example.ts ***!
  \*****************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

var __extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
        return extendStatics(d, b);
    }
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
Object.defineProperty(exports, "__esModule", { value: true });
var env_1 = __webpack_require__(/*! ../env */ "./app/scripts/env.ts");
var AbstractModule_1 = __webpack_require__(/*! ./AbstractModule */ "./app/scripts/modules/AbstractModule.ts");
var MODULE_NAME = 'Example';
var default_1 = /** @class */ (function (_super) {
    __extends(default_1, _super);
    function default_1(el) {
        var _this = _super.call(this, el) || this;
        if (env_1.isDebug)
            console.log('%c[module] ' + ("%cBuilding: " + MODULE_NAME + " - " + _this.uuid), 'color:#4688f2', 'color:#eee');
        return _this;
    }
    /**
     * Called when the module is created
     * Used to call any initial methods or to
     * register any initial event listeners
     */
    default_1.prototype.init = function () {
    };
    /**
     * Called when the module is destroyed
     * Remove all event listners before calling super.destory()
     */
    default_1.prototype.destroy = function () {
        _super.prototype.destroy.call(this, env_1.isDebug, MODULE_NAME);
    };
    return default_1;
}(AbstractModule_1.default));
exports.default = default_1;


/***/ }),

/***/ "./app/scripts/transitions/BaseTransition.ts":
/*!***************************************************!*\
  !*** ./app/scripts/transitions/BaseTransition.ts ***!
  \***************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
var Transition = /** @class */ (function () {
    function Transition() {
    }
    /**
     * Called by the TransitionManager when Pjax is switching pages
     * Used to start any custom page transition animaitons
     */
    Transition.prototype.launch = function () {
        // Handle custom transition effects
        // Call when transition is finished
        this.launchFinished();
    };
    /**
     * Called when the base transition is finished hiding the page/content
     * Sends a `pjax:continue` event
     * This is used when Pjax is listening for a custom transition
     * @see https://github.com/Pageworks/fuel-pjax#pjax-options
     */
    Transition.prototype.launchFinished = function () {
        var e = new Event('pjax:continue');
        document.dispatchEvent(e);
    };
    /**
     * Call by the TransitionManager when Pjax has switched pages
     * Used to stop any custom page transition animations
     */
    Transition.prototype.hide = function () {
        // Handle custom transition effects
    };
    return Transition;
}());
exports.default = Transition;


/***/ }),

/***/ "./app/scripts/transitions/TransitionManager.ts":
/*!******************************************************!*\
  !*** ./app/scripts/transitions/TransitionManager.ts ***!
  \******************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
var env_1 = __webpack_require__(/*! ../env */ "./app/scripts/env.ts");
var transitions = __webpack_require__(/*! ./transitions */ "./app/scripts/transitions/transitions.ts");
var fuel_pjax_1 = __webpack_require__(/*! fuel-pjax */ "./node_modules/fuel-pjax/pjax.js");
var TransitionManager = /** @class */ (function () {
    function TransitionManager(app) {
        this.app = app;
        this.transitions = transitions;
        this.transition = null;
        this.pjax = new fuel_pjax_1.default({ debug: env_1.isDebug, selectors: ["" + env_1.pjaxContainer] });
        this.initialAnimationDelay = 1000;
        this.init();
    }
    /**
     * Declare all initial event listeners
     * By default `pjax:prefetch` and `pjax:cancel` do nothing but they are available if needed
     */
    TransitionManager.prototype.init = function () {
        var _this = this;
        document.addEventListener('DOMContentLoaded', function (e) { _this.load(); }); // Listen for when the page is loaded
        document.addEventListener('pjax:error', function (e) { return _this.endTransition(e); });
        document.addEventListener('pjax:send', function (e) { return _this.launchTransition(e); });
        // document.addEventListener('pjax:prefetch', ()=>{ console.log('Event: pjax:prefetch'); });
        // document.addEventListener('pjax:cancel', ()=>{ console.log('Event: pjax:cancel'); } );
        document.addEventListener('pjax:complete', function (e) { return _this.endTransition(e); });
    };
    /**
     * Called when the DOM has finished it's initial content load
     * Sets the base DOM status classes
     */
    TransitionManager.prototype.load = function () {
        env_1.html.classList.add('dom-is-loaded');
        env_1.html.classList.remove('dom-is-loading');
        setTimeout(function () { env_1.html.classList.add('dom-is-animated'); }, this.initialAnimationDelay);
    };
    /**
     * Called when Pjax fires the `pjax:send` event
     * Get the trigger element that is passed from Pjax via the CustomEvent.detail
     * Set our transition attribute based on the `data-transition` attribute of the trigger element
     * Construct our new transition
     * Update the DOM status classes
     * Launch our transition
     * @param {CustomEvent} e
     */
    TransitionManager.prototype.launchTransition = function (e) {
        var transition = 'BaseTransition';
        if (e.detail !== undefined) {
            var el = e.detail.el;
            transition = (el.getAttribute('data-transition') !== null) ? el.getAttribute('data-transition') : 'BaseTransition';
        }
        env_1.html.setAttribute('data-transition', transition);
        this.transition = new this.transitions[transition].prototype.constructor();
        env_1.html.classList.remove('dom-is-loaded', 'dom-is-animated');
        env_1.html.classList.add('dom-is-loading');
        this.transition.launch();
    };
    /**
     * Called when Pjax fires `pjax:error` or `pjax:cancel` or `pjax:complete`
     * Resets DOM status classes to the default state(s)
     * Gets the templates name from `this.getTemplateName()`
     * Displays the name if we're in debug mode
     * If the template is labeled `home` set the `is-homepage` status class
     * Tells the main applicaiton it can init any new modules
     * @param {Event} e
     */
    TransitionManager.prototype.endTransition = function (e) {
        var templateName = this.getTemplateName();
        if (env_1.isDebug)
            console.log('%c[view] ' + ("%cDisplaying: " + templateName), 'color:#ecc653', 'color:#eee');
        env_1.html.classList.add('dom-is-loaded');
        env_1.html.classList.remove('dom-is-loading');
        setTimeout(function () { env_1.html.classList.add('dom-is-animated'); }, this.initialAnimationDelay);
        if (templateName === 'home')
            env_1.html.classList.add('is-homepage');
        else
            env_1.html.classList.remove('is-homepage');
        // Tell our transition it can end the transition
        this.transition.hide();
        // Tell our main applicaiton it can init any new modules
        this.app.initModules();
        // Tell our main applicaiton it can delete any old modules
        this.app.deleteModules();
        // Reset for next transition
        this.reinit();
    };
    /**
     * Get all sections within our Pjax wrapper (article)
     * Look through elements for the first node with a `data-template` attribute
     * Return the name given to the section
     * Otherwise return 'MISSING_TEMPLATE_NAME'
     */
    TransitionManager.prototype.getTemplateName = function () {
        var templateName = 'MISSING_TEMPLATE_NAME';
        var secitons = env_1.html.querySelectorAll('section');
        if (secitons) {
            secitons.forEach(function (el) {
                if (el.getAttribute('data-template') !== null)
                    templateName = el.getAttribute('data-template');
            });
        }
        return templateName;
    };
    /**
     * Called when we've finished our transition
     * Resets our transition object and the DOM's `data-transition` attribute
     */
    TransitionManager.prototype.reinit = function () {
        env_1.html.setAttribute('data-transition', '');
        this.transition = null;
    };
    return TransitionManager;
}());
exports.default = TransitionManager;


/***/ }),

/***/ "./app/scripts/transitions/transitions.ts":
/*!************************************************!*\
  !*** ./app/scripts/transitions/transitions.ts ***!
  \************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
var BaseTransition_1 = __webpack_require__(/*! ./BaseTransition */ "./app/scripts/transitions/BaseTransition.ts");
exports.BaseTransition = BaseTransition_1.default;


/***/ }),

/***/ "./node_modules/fuel-pjax/lib/events/link-events.js":
/*!**********************************************************!*\
  !*** ./node_modules/fuel-pjax/lib/events/link-events.js ***!
  \**********************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
var on_1 = __webpack_require__(/*! ./on */ "./node_modules/fuel-pjax/lib/events/on.js");
var attrState = 'data-pjax-state';
var isDefaultPrevented = function (el, e) {
    var isPrevented = false;
    if (e.defaultPrevented)
        isPrevented = true;
    else if (el.getAttribute('prevent-default') !== null)
        isPrevented = true;
    else if (el.classList.contains('no-transition'))
        isPrevented = true;
    else if (el.getAttribute('download') !== null)
        isPrevented = true;
    else if (el.getAttribute('target') !== null)
        isPrevented = true;
    return isPrevented;
};
var checkForAbort = function (el, e) {
    if (el.protocol !== window.location.protocol || el.host !== window.location.host)
        return 'external';
    if (el.hash && el.href.replace(el.hash, '') === window.location.href.replace(location.hash, ''))
        return 'anchor';
    if (el.href === window.location.href.split('#')[0] + ", '#'")
        return 'anchor-empty';
    return null;
};
var handleClick = function (el, e, pjax) {
    if (isDefaultPrevented(el, e))
        return;
    var eventOptions = {
        triggerElement: el
    };
    var attrValue = checkForAbort(el, e);
    if (attrValue !== null) {
        el.setAttribute(attrState, attrValue);
        return;
    }
    e.preventDefault();
    if (el.href === window.location.href.split('#')[0])
        el.setAttribute(attrState, 'reload');
    else
        el.setAttribute(attrState, 'load');
    pjax.handleLoad(el.href, el.getAttribute(attrState), el);
};
var handleHover = function (el, e, pjax) {
    if (isDefaultPrevented(el, e))
        return;
    if (e.type === 'mouseout') {
        pjax.clearPrefetch();
        return;
    }
    var eventOptions = {
        triggerElement: el
    };
    var attrValue = checkForAbort(el, e);
    if (attrValue !== null) {
        el.setAttribute(attrState, attrValue);
        return;
    }
    if (el.href !== window.location.href.split('#')[0])
        el.setAttribute(attrState, 'prefetch');
    else
        return;
    pjax.handlePrefetch(el.href, eventOptions);
};
exports.default = (function (el, pjax) {
    el.setAttribute(attrState, '');
    on_1.default(el, 'click', function (e) { handleClick(el, e, pjax); });
    on_1.default(el, 'mouseover', function (e) { handleHover(el, e, pjax); });
    on_1.default(el, 'mouseout', function (e) { handleHover(el, e, pjax); });
    on_1.default(el, 'keyup', function (e) {
        if (e.key === 'enter' || e.keyCode === 13)
            handleClick(el, e, pjax);
    });
});


/***/ }),

/***/ "./node_modules/fuel-pjax/lib/events/on.js":
/*!*************************************************!*\
  !*** ./node_modules/fuel-pjax/lib/events/on.js ***!
  \*************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
exports.default = (function (el, event, listener) {
    el.addEventListener(event, listener);
});


/***/ }),

/***/ "./node_modules/fuel-pjax/lib/events/trigger.js":
/*!******************************************************!*\
  !*** ./node_modules/fuel-pjax/lib/events/trigger.js ***!
  \******************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
exports.default = (function (el, events, target) {
    if (target === void 0) { target = null; }
    events.forEach(function (e) {
        if (target !== null) {
            var customEvent = new CustomEvent(e, {
                detail: {
                    el: target
                }
            });
            el.dispatchEvent(customEvent);
        }
        else {
            var event_1 = new Event(e);
            el.dispatchEvent(event_1);
        }
    });
});


/***/ }),

/***/ "./node_modules/fuel-pjax/lib/parse-options.js":
/*!*****************************************************!*\
  !*** ./node_modules/fuel-pjax/lib/parse-options.js ***!
  \*****************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
exports.default = (function (options) {
    if (options === void 0) { options = null; }
    var parsedOptions = (options !== null) ? options : {};
    parsedOptions.elements = (options !== null && options.elements !== undefined) ? options.elements : 'a[href]';
    parsedOptions.selectors = (options !== null && options.selectors !== undefined) ? options.selectors : ['.js-pjax'];
    parsedOptions.history = (options !== null && options.history !== undefined) ? options.history : true;
    parsedOptions.scrollTo = (options !== null && options.scrollTo !== undefined) ? options.scrollTo : 0;
    parsedOptions.cacheBust = (options !== null && options.cacheBust !== undefined) ? options.cacheBust : false;
    parsedOptions.debug = (options !== null && options.debug !== undefined) ? options.debug : false;
    parsedOptions.timeout = (options !== null && options.timeout !== undefined) ? options.timeout : 0;
    parsedOptions.titleSwitch = (options !== null && options.titleSwitch !== undefined) ? options.titleSwitch : true;
    parsedOptions.customTransitions = (options !== null && options.customTransitions !== undefined) ? options.customTransitions : false;
    return parsedOptions;
});


/***/ }),

/***/ "./node_modules/fuel-pjax/lib/util/check-element.js":
/*!**********************************************************!*\
  !*** ./node_modules/fuel-pjax/lib/util/check-element.js ***!
  \**********************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
exports.default = (function (el, pjax) {
    switch (el.tagName.toLocaleLowerCase()) {
        case 'a':
            if (!el.hasAttribute(pjax.options.attrState))
                pjax.setLinkListeners(el);
            break;
        default:
            throw 'Pjax can only be applied on <a> elements';
    }
});


/***/ }),

/***/ "./node_modules/fuel-pjax/lib/util/contains.js":
/*!*****************************************************!*\
  !*** ./node_modules/fuel-pjax/lib/util/contains.js ***!
  \*****************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
exports.default = (function (doc, selectors, element) {
    selectors.map(function (selector) {
        var selectorEls = doc.querySelectorAll(selector);
        selectorEls.forEach(function (el) {
            if (el.contains(element)) {
                return true;
            }
        });
    });
    return false;
});


/***/ }),

/***/ "./node_modules/fuel-pjax/lib/uuid.js":
/*!********************************************!*\
  !*** ./node_modules/fuel-pjax/lib/uuid.js ***!
  \********************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
exports.default = (function () {
    return Date.now().toString();
});


/***/ }),

/***/ "./node_modules/fuel-pjax/pjax.js":
/*!****************************************!*\
  !*** ./node_modules/fuel-pjax/pjax.js ***!
  \****************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
var parse_options_1 = __webpack_require__(/*! ./lib/parse-options */ "./node_modules/fuel-pjax/lib/parse-options.js");
var uuid_1 = __webpack_require__(/*! ./lib/uuid */ "./node_modules/fuel-pjax/lib/uuid.js");
var trigger_1 = __webpack_require__(/*! ./lib/events/trigger */ "./node_modules/fuel-pjax/lib/events/trigger.js");
var contains_1 = __webpack_require__(/*! ./lib/util/contains */ "./node_modules/fuel-pjax/lib/util/contains.js");
var link_events_1 = __webpack_require__(/*! ./lib/events/link-events */ "./node_modules/fuel-pjax/lib/events/link-events.js");
var check_element_1 = __webpack_require__(/*! ./lib/util/check-element */ "./node_modules/fuel-pjax/lib/util/check-element.js");
var Pjax = (function () {
    function Pjax(options) {
        this.state = {
            url: window.location.href,
            title: document.title,
            history: true,
            scrollPos: [0, 0]
        };
        this.cache = null;
        this.options = parse_options_1.default(options);
        this.lastUUID = uuid_1.default();
        this.request = null;
        this.confirmed = false;
        this.cachedSwitch = null;
        if (this.options.debug)
            console.log('Pjax Options:', this.options);
        this.init();
    }
    Pjax.prototype.init = function () {
        var _this = this;
        window.addEventListener('popstate', function (e) { return _this.handlePopstate(e); });
        if (this.options.customTransitions)
            document.addEventListener('pjax:continue', function (e) { return _this.handleContinue(e); });
        this.parseDOM(document.body);
    };
    Pjax.prototype.handleReload = function () {
        window.location.reload();
    };
    Pjax.prototype.setLinkListeners = function (el) {
        link_events_1.default(el, this);
    };
    Pjax.prototype.getElements = function (el) {
        return el.querySelectorAll(this.options.elements);
    };
    Pjax.prototype.parseDOM = function (el) {
        var _this = this;
        var elements = this.getElements(el);
        elements.forEach(function (el) {
            check_element_1.default(el, _this);
        });
    };
    Pjax.prototype.handlePopstate = function (e) {
        if (e.state) {
            if (this.options.debug)
                console.log('Hijacking Popstate Event');
            this.loadUrl(e.state.url, 'popstate');
        }
    };
    Pjax.prototype.abortRequest = function () {
        if (this.request === null)
            return;
        if (this.request.readyState !== 4) {
            this.request.abort();
            this.request = null;
        }
    };
    Pjax.prototype.loadUrl = function (href, loadType) {
        this.abortRequest();
        if (this.cache === null) {
            this.handleLoad(href, loadType);
        }
        else {
            this.loadCachedContent();
        }
    };
    Pjax.prototype.handlePushState = function () {
        if (this.state !== {}) {
            if (this.state.history) {
                if (this.options.debug)
                    console.log('Pushing History State: ', this.state);
                this.lastUUID = uuid_1.default();
                window.history.pushState({
                    url: this.state.url,
                    title: this.state.title,
                    uuid: this.lastUUID,
                    scrollPos: [0, 0]
                }, this.state.title, this.state.url);
            }
            else {
                if (this.options.debug)
                    console.log('Replacing History State: ', this.state);
                this.lastUUID = uuid_1.default();
                window.history.replaceState({
                    url: this.state.url,
                    title: this.state.title,
                    uuid: this.lastUUID,
                    scrollPos: [0, 0]
                }, document.title);
            }
        }
    };
    Pjax.prototype.handleScrollPosition = function () {
        if (this.state.history) {
            var temp = document.createElement('a');
            temp.href = this.state.url;
            if (temp.hash) {
                var name_1 = temp.hash.slice(1);
                name_1 = decodeURIComponent(name_1);
                var currTop = 0;
                var target = document.getElementById(name_1) || document.getElementsByName(name_1)[0];
                if (target) {
                    if (target.offsetParent) {
                        do {
                            currTop += target.offsetTop;
                            target = target.offsetParent;
                        } while (target);
                    }
                }
                window.scrollTo(0, currTop);
            }
            else
                window.scrollTo(0, this.options.scrollTo);
        }
        else if (this.state.scrollPos) {
            window.scrollTo(this.state.scrollPos[0], this.state.scrollPos[1]);
        }
    };
    Pjax.prototype.finalize = function () {
        if (this.options.debug)
            console.log('Finishing Pjax');
        this.state.url = this.request.responseURL;
        this.state.title = document.title;
        this.state.scrollPos = [0, window.scrollY];
        this.handlePushState();
        this.handleScrollPosition();
        this.cache = null;
        this.state = {};
        this.request = null;
        this.confirmed = false;
        this.cachedSwitch = null;
        trigger_1.default(document, ['pjax:complete']);
    };
    Pjax.prototype.handleSwitches = function (switchQueue) {
        var _this = this;
        switchQueue.map(function (switchObj) {
            switchObj.oldEl.innerHTML = switchObj.newEl.innerHTML;
            _this.parseDOM(switchObj.oldEl);
        });
        this.finalize();
    };
    Pjax.prototype.handleContinue = function (e) {
        if (this.cachedSwitch !== null) {
            if (this.options.titleSwitch)
                document.title = this.cachedSwitch.title;
            this.handleSwitches(this.cachedSwitch.queue);
        }
        else {
            if (this.options.debug)
                console.log('Switch queue was empty. You might be sending `pjax:continue` too fast.');
            trigger_1.default(document, ['pjax:error']);
        }
    };
    Pjax.prototype.switchSelectors = function (selectors, toEl, fromEl) {
        var _this = this;
        var switchQueue = [];
        selectors.forEach(function (selector) {
            var newEls = toEl.querySelectorAll(selector);
            var oldEls = fromEl.querySelectorAll(selector);
            if (_this.options.debug)
                console.log('Pjax Switch Selector: ', selector, newEls, oldEls);
            if (newEls.length !== oldEls.length) {
                if (_this.options.debug)
                    console.log('DOM doesn\'t look the same on the new page');
                _this.lastChance(_this.request.responseURL);
                return;
            }
            newEls.forEach(function (newElement, i) {
                var oldElement = oldEls[i];
                var elSwitch = {
                    newEl: newElement,
                    oldEl: oldElement
                };
                switchQueue.push(elSwitch);
            });
        });
        if (switchQueue.length === 0) {
            if (this.options.debug)
                console.log('Couldn\'t find anything to switch');
            this.lastChance(this.request.responseURL);
            return;
        }
        if (!this.options.customTransitions) {
            if (this.options.titleSwitch)
                document.title = toEl.title;
            this.handleSwitches(switchQueue);
        }
        else {
            this.cachedSwitch = {
                queue: switchQueue,
                title: toEl.title
            };
        }
    };
    Pjax.prototype.lastChance = function (uri) {
        if (this.options.debug)
            console.log('Cached content has a response of ', this.cache.status, ' but we require a success response, fallback loading uri ', uri);
        window.location.href = uri;
    };
    Pjax.prototype.statusCheck = function () {
        for (var status_1 = 200; status_1 <= 206; status_1++) {
            if (this.cache.status === status_1)
                return true;
        }
        return false;
    };
    Pjax.prototype.loadCachedContent = function () {
        if (!this.statusCheck()) {
            this.lastChance(this.cache.url);
            return;
        }
        if (document.activeElement && contains_1.default(document, this.options.selectors, document.activeElement)) {
            try {
                document.activeElement.blur();
            }
            catch (e) {
                console.log(e);
            }
        }
        this.switchSelectors(this.options.selectors, this.cache.html, document);
    };
    Pjax.prototype.parseContent = function (responseText) {
        var tempEl = document.implementation.createHTMLDocument('globals');
        var htmlRegex = /\s?[a-z:]+(?=(?:\'|\")[^\'\">]+(?:\'|\"))*/gi;
        var matches = responseText.match(htmlRegex);
        if (matches && matches.length)
            return tempEl;
        return null;
    };
    Pjax.prototype.cacheContent = function (responseText, responseStatus, uri) {
        var tempEl = this.parseContent(responseText);
        if (tempEl === null) {
            trigger_1.default(document, ['pjax:error']);
            return;
        }
        tempEl.documentElement.innerHTML = responseText;
        this.cache = {
            status: responseStatus,
            html: tempEl,
            url: uri
        };
        if (this.options.debug)
            console.log('Cached Content: ', this.cache);
    };
    Pjax.prototype.loadContent = function (responseText) {
        var tempEl = this.parseContent(responseText);
        if (tempEl === null) {
            trigger_1.default(document, ['pjax:error']);
            this.lastChance(this.request.responseURL);
            return;
        }
        tempEl.documentElement.innerHTML = responseText;
        if (document.activeElement && contains_1.default(document, this.options.selectors, document.activeElement)) {
            try {
                document.activeElement.blur();
            }
            catch (e) {
                console.log(e);
            }
        }
        this.switchSelectors(this.options.selectors, tempEl, document);
    };
    Pjax.prototype.handleResponse = function (e, loadType) {
        if (this.options.debug)
            console.log('XML Http Request Status: ', this.request.status);
        var request = this.request;
        if (request.responseText === null) {
            trigger_1.default(document, ['pjax:error']);
            return;
        }
        switch (loadType) {
            case 'prefetch':
                this.state.history = true;
                if (this.confirmed)
                    this.loadContent(request.responseText);
                else
                    this.cacheContent(request.responseText, request.status, request.responseURL);
                break;
            case 'popstate':
                this.state.history = false;
                this.loadContent(request.responseText);
                break;
            case 'reload':
                this.state.history = false;
                this.loadContent(request.responseText);
                break;
            default:
                this.state.history = true;
                this.loadContent(request.responseText);
                break;
        }
    };
    Pjax.prototype.doRequest = function (href) {
        var _this = this;
        var reqeustMethod = 'GET';
        var timeout = this.options.timeout || 0;
        var request = new XMLHttpRequest();
        var uri = href;
        var queryString = href.split('?')[1];
        if (this.options.cacheBust)
            uri += (queryString === undefined) ? ("?cb=" + Date.now()) : ("&cb=" + Date.now());
        return new Promise(function (resolve, reject) {
            request.open(reqeustMethod, uri, true);
            request.timeout = timeout;
            request.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
            request.setRequestHeader('X-PJAX', 'true');
            request.setRequestHeader('X-PJAX-Selectors', JSON.stringify(_this.options.selectors));
            request.onload = resolve;
            request.onerror = reject;
            request.send();
            _this.request = request;
        });
    };
    Pjax.prototype.handlePrefetch = function (href) {
        var _this = this;
        if (this.options.debug)
            console.log('Prefetching: ', href);
        this.abortRequest();
        trigger_1.default(document, ['pjax:prefetch']);
        this.doRequest(href)
            .then(function (e) { _this.handleResponse(e, 'prefetch'); })
            .catch(function (e) {
            if (_this.options.debug)
                console.log('XHR Request Error: ', e);
        });
    };
    Pjax.prototype.handleLoad = function (href, loadType, el) {
        var _this = this;
        if (el === void 0) { el = null; }
        trigger_1.default(document, ['pjax:send'], el);
        if (this.cache !== null) {
            if (this.options.debug)
                console.log('Loading Cached: ', href);
            this.loadCachedContent();
        }
        else if (this.request !== null) {
            if (this.options.debug)
                console.log('Loading Prefetch: ', href);
            this.confirmed = true;
        }
        else {
            if (this.options.debug)
                console.log('Loading: ', href);
            this.doRequest(href)
                .then(function (e) { _this.handleResponse(e, loadType); })
                .catch(function (e) {
                if (_this.options.debug)
                    console.log('XHR Request Error: ', e);
            });
        }
    };
    Pjax.prototype.clearPrefetch = function () {
        this.cache = null;
        this.confirmed = false;
        this.abortRequest();
        trigger_1.default(document, ['pjax:cancel']);
    };
    return Pjax;
}());
exports.default = Pjax;


/***/ }),

/***/ "./node_modules/uuid/lib/bytesToUuid.js":
/*!**********************************************!*\
  !*** ./node_modules/uuid/lib/bytesToUuid.js ***!
  \**********************************************/
/*! no static exports found */
/***/ (function(module, exports) {

/**
 * Convert array of 16 byte values to UUID string format of the form:
 * XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
 */
var byteToHex = [];
for (var i = 0; i < 256; ++i) {
  byteToHex[i] = (i + 0x100).toString(16).substr(1);
}

function bytesToUuid(buf, offset) {
  var i = offset || 0;
  var bth = byteToHex;
  // join used to fix memory issue caused by concatenation: https://bugs.chromium.org/p/v8/issues/detail?id=3175#c4
  return ([bth[buf[i++]], bth[buf[i++]], 
	bth[buf[i++]], bth[buf[i++]], '-',
	bth[buf[i++]], bth[buf[i++]], '-',
	bth[buf[i++]], bth[buf[i++]], '-',
	bth[buf[i++]], bth[buf[i++]], '-',
	bth[buf[i++]], bth[buf[i++]],
	bth[buf[i++]], bth[buf[i++]],
	bth[buf[i++]], bth[buf[i++]]]).join('');
}

module.exports = bytesToUuid;


/***/ }),

/***/ "./node_modules/uuid/lib/rng-browser.js":
/*!**********************************************!*\
  !*** ./node_modules/uuid/lib/rng-browser.js ***!
  \**********************************************/
/*! no static exports found */
/***/ (function(module, exports) {

// Unique ID creation requires a high quality random # generator.  In the
// browser this is a little complicated due to unknown quality of Math.random()
// and inconsistent support for the `crypto` API.  We do the best we can via
// feature-detection

// getRandomValues needs to be invoked in a context where "this" is a Crypto
// implementation. Also, find the complete implementation of crypto on IE11.
var getRandomValues = (typeof(crypto) != 'undefined' && crypto.getRandomValues && crypto.getRandomValues.bind(crypto)) ||
                      (typeof(msCrypto) != 'undefined' && typeof window.msCrypto.getRandomValues == 'function' && msCrypto.getRandomValues.bind(msCrypto));

if (getRandomValues) {
  // WHATWG crypto RNG - http://wiki.whatwg.org/wiki/Crypto
  var rnds8 = new Uint8Array(16); // eslint-disable-line no-undef

  module.exports = function whatwgRNG() {
    getRandomValues(rnds8);
    return rnds8;
  };
} else {
  // Math.random()-based (RNG)
  //
  // If all else fails, use Math.random().  It's fast, but is of unspecified
  // quality.
  var rnds = new Array(16);

  module.exports = function mathRNG() {
    for (var i = 0, r; i < 16; i++) {
      if ((i & 0x03) === 0) r = Math.random() * 0x100000000;
      rnds[i] = r >>> ((i & 0x03) << 3) & 0xff;
    }

    return rnds;
  };
}


/***/ }),

/***/ "./node_modules/uuid/v4.js":
/*!*********************************!*\
  !*** ./node_modules/uuid/v4.js ***!
  \*********************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

var rng = __webpack_require__(/*! ./lib/rng */ "./node_modules/uuid/lib/rng-browser.js");
var bytesToUuid = __webpack_require__(/*! ./lib/bytesToUuid */ "./node_modules/uuid/lib/bytesToUuid.js");

function v4(options, buf, offset) {
  var i = buf && offset || 0;

  if (typeof(options) == 'string') {
    buf = options === 'binary' ? new Array(16) : null;
    options = null;
  }
  options = options || {};

  var rnds = options.random || (options.rng || rng)();

  // Per 4.4, set bits for version and `clock_seq_hi_and_reserved`
  rnds[6] = (rnds[6] & 0x0f) | 0x40;
  rnds[8] = (rnds[8] & 0x3f) | 0x80;

  // Copy bytes to buffer, if provided
  if (buf) {
    for (var ii = 0; ii < 16; ++ii) {
      buf[i + ii] = rnds[ii];
    }
  }

  return buf || bytesToUuid(rnds);
}

module.exports = v4;


/***/ }),

/***/ 0:
/*!*******************************************************!*\
  !*** multi ./app/scripts/App.ts ./app/sass/main.scss ***!
  \*******************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

__webpack_require__(/*! /Users/andrews/Documents/projects/papertrain/app/scripts/App.ts */"./app/scripts/App.ts");
module.exports = __webpack_require__(/*! /Users/andrews/Documents/projects/papertrain/app/sass/main.scss */"./app/sass/main.scss");


/***/ })

/******/ });
//# sourceMappingURL=app.js.map