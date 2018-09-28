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
var env_1 = __webpack_require__(/*! ./utils/env */ "./app/scripts/utils/env.ts");
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
        env_1.$html.classList.remove('has-no-js');
        env_1.$html.classList.add('has-js');
        window.addEventListener('load', function (e) { env_1.$html.classList.add('has-loaded'); });
        // Listen for our custom events
        document.addEventListener('seppuku', function (e) { return _this.deleteModule(e); });
        document.addEventListener('initModules', function (e) { return _this.initModules(); });
        document.addEventListener('deleteModules', function (e) { return _this.deleteModules(); });
        this.initModules(); // Get initial modules
        this.handleStatus(); // Check the users visitor status
        this.transitionManager = new TransitionManager_1.default();
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
        if (window.localStorage.getItem(env_1.APP_NAME + 'UniqueVisit') === null) {
            env_1.$html.classList.add('is-unique-visitor');
            window.localStorage.setItem(env_1.APP_NAME + 'UniqueVisit', 'visited');
        }
        // Handle first visit of the day (in 24 hours) status
        if (window.localStorage.getItem(env_1.APP_NAME + 'DailyVisit') === null || (Date.now() - parseInt(window.localStorage.getItem(env_1.APP_NAME + 'UniqueVisit')) > 86400000)) {
            env_1.$html.classList.add('is-first-of-day');
        }
        else
            env_1.$html.classList.add('is-returning');
        window.localStorage.setItem(env_1.APP_NAME + 'DailyVisit', Date.now().toString()); // Always update daily visit status
    };
    /**
     * Gets all module references in the document and creates a new module
     * If a module already has a UUID we won't do anything since it already
     * has a module associated with the HTML element
     */
    App.prototype.initModules = function () {
        var _this = this;
        if (env_1.isDebug)
            console.log('%c-- Initiating Modules --', 'color:#eee');
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
                    console.log('%cUndefined Module: ' + '%c' + moduleType, 'color:#ff6e6e', 'color:#eee');
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
        if (env_1.isDebug)
            console.log('%c-- Deleting Unused Modules --', 'color:#eee');
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
     * Returns the detail value if the event is a CustomEvent
     * @param e event
     */
    App.prototype.getCustomEvent = function (e) {
        return 'detail' in e;
    };
    /**
     * Delete a module based on the modules UUID
     * @param moduleID
     */
    App.prototype.deleteModule = function (e) {
        var moduleID = null;
        if (this.getCustomEvent(e))
            moduleID = e.detail;
        else {
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
// IIFE for launching the application
(function () {
    new App();
})();


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
        var event = new CustomEvent('seppuku', { detail: this.uuid });
        document.dispatchEvent(event);
    };
    /**
     * Called by a module, removes attribute and logs out destruction to the console
     * Used when the page transitions, call is initiated by applicaiton
     * You shouldn't call this method, if you need to remove a module use the `seppuku` method
     * @param isDebug
     * @param MODULE_NAME
     */
    default_1.prototype.destroy = function (isDebug, MODULE_NAME) {
        this.$el.removeAttribute('data-uuid');
        if (isDebug)
            console.log('%c[module] ' + '%c' + MODULE_NAME + ' - ' + this.uuid, 'color:#ff6e6e', 'color:#eee');
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
var env_1 = __webpack_require__(/*! ../utils/env */ "./app/scripts/utils/env.ts");
var AbstractModule_1 = __webpack_require__(/*! ./AbstractModule */ "./app/scripts/modules/AbstractModule.ts");
var MODULE_NAME = 'Example';
var default_1 = /** @class */ (function (_super) {
    __extends(default_1, _super);
    function default_1(el) {
        var _this = _super.call(this, el) || this;
        if (env_1.isDebug)
            console.log('%c[module] ' + '%c' + MODULE_NAME + ' - ' + _this.uuid, 'color:#4688f2', 'color:#eee');
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
var env_1 = __webpack_require__(/*! ../utils/env */ "./app/scripts/utils/env.ts");
var MODULE_NAME = 'Transition';
var default_1 = /** @class */ (function () {
    function default_1(options) {
        this.options = options;
    }
    /**
     * Starts the page transition when called by the transition manager
     * Updates the DOMs loading and animated status
     */
    default_1.prototype.launch = function () {
        if (env_1.isDebug)
            console.log('%c-- Page Transition Launched --', 'color:#eee');
        env_1.$html.classList.remove('dom-is-loaded', 'dom-is-animated');
        env_1.$html.classList.add('dom-is-loading', this.options.overrideClass);
    };
    default_1.prototype.readyToRemove = function (oldView, newView) {
        var event = new CustomEvent('removeView', {
            detail: {
                o: oldView,
                n: newView
            }
        });
        document.dispatchEvent(event);
    };
    default_1.prototype.readyToReset = function () {
        var event = new Event('resetTransitions');
        document.dispatchEvent(event);
    };
    /**
     * Gets incoming template name
     * If we're in debug mode console.log the template swap
     * Handles the initial transition (typically the hiding phase)
     * @param oldView element
     * @param newView element
     */
    default_1.prototype.hideView = function (oldView, newView) {
        // Handle custom transition effects
        this.readyToRemove(oldView, newView); // Call when ready to launch
    };
    /**
     * Called by the transition manager once it's switched out the page content
     * and we're ready to end the page transition
     * Updates the DOMs loading and animated status
     * Calls the transition managers reinit method
     * @param newView element
     */
    default_1.prototype.displayView = function (newView) {
        env_1.$html.classList.add('dom-is-loaded');
        env_1.$html.classList.remove('dom-is-loading', this.options.overrideClass);
        // Put within a setTimeout if you want a delay between loaded and animated status
        env_1.$html.classList.add('dom-is-animated');
        this.readyToReset(); // Call when ready to reset the transition manager
    };
    /**
     * Transition is finished and should be destroyed
     * @todo Console.log the transitions destruction if in debug mode
     */
    default_1.prototype.destroy = function () {
        if (env_1.isDebug)
            console.log('%c-- Page Transition Ended --', 'color:#eee');
    };
    return default_1;
}());
exports.default = default_1;


/***/ }),

/***/ "./app/scripts/transitions/TransitionManager.ts":
/*!******************************************************!*\
  !*** ./app/scripts/transitions/TransitionManager.ts ***!
  \******************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
var env_1 = __webpack_require__(/*! ../utils/env */ "./app/scripts/utils/env.ts");
var transitions = __webpack_require__(/*! ./transitions */ "./app/scripts/transitions/transitions.ts");
var PJAX = __webpack_require__(/*! pjax */ "./node_modules/pjax/index.js");
var TransitionManager = /** @class */ (function () {
    function TransitionManager() {
        var _this = this;
        this.transitions = transitions;
        this.transition = null;
        this.initialAnimationDelay = 1000;
        /**
         * -- PJAX CONFIG --
         */
        this.wrapper = document.querySelector(env_1.$pjaxWrapper);
        this.options = {
            debug: env_1.isDebug,
            elements: 'a:not(.no-transition)',
            selectors: ['title', env_1.$pjaxContainer],
            switches: {},
            prefetch: true,
            cacheBust: false
        };
        this.options.switches[env_1.$pjaxContainer] = function (oldEl, newEl) { return _this.switch(oldEl, newEl); };
        this.pjax = new PJAX(this.options);
        this.init();
    }
    TransitionManager.prototype.switch = function (oldView, newView) {
        this.transition.hideView(oldView, newView);
    };
    /**
     * Declare all initial event listeners
     */
    TransitionManager.prototype.init = function () {
        var _this = this;
        window.addEventListener('load', function (e) { _this.load(); });
        // Listen for the pjax events
        if (!this.pjax.options.prefetch)
            document.addEventListener('pjax:send', function (e) { return _this.send(e); });
        else {
            document.addEventListener('pjax:prefetch', function (e) { return _this.prefetch(e); });
            document.addEventListener('pjax:prefetchRequested', function (e) { return _this.prefetchRequested(e); });
            document.addEventListener('pjax:loadingCached', function (e) { return _this.loadingCached(e); });
        }
        document.addEventListener('pjax:404', function (e) { return _this.handleError(e); });
        // Listen for our events
        document.addEventListener('removeView', function (e) { return _this.remove(e); });
        document.addEventListener('resetTransitions', function (e) { return _this.reinit(); });
    };
    TransitionManager.prototype.handleError = function (e) {
        if (env_1.isDebug)
            console.log('%cPage Transition Error: ' + '%cpage request returned 404', 'color:#ff6e6e', 'color:#eee');
    };
    TransitionManager.prototype.load = function () {
        env_1.$html.classList.add('dom-is-loaded');
        env_1.$html.classList.remove('dom-is-loading');
        setTimeout(function () { env_1.$html.classList.add('dom-is-animated'); }, this.initialAnimationDelay);
    };
    TransitionManager.prototype.launchRequest = function (e) {
        var el = e.triggerElement;
        var transition = (el.getAttribute('data-transition') !== null) ? el.getAttribute('data-transition') : 'BaseTransition';
        env_1.$html.setAttribute('data-transition', transition);
        this.transition = new this.transitions[transition].prototype.constructor({
            wrapper: this.wrapper,
            clickedLink: el,
            manager: this
        });
    };
    /**
     * Launch when pjax recieves a non-prefetch request
     * Launch the request and begin transition animation
     * @param e event
     */
    TransitionManager.prototype.send = function (e) {
        this.launchRequest(e);
        this.transition.launch();
    };
    /**
     * Launche when pjax recieves a prefetch request
     * @param e event
     */
    TransitionManager.prototype.prefetch = function (e) {
        this.launchRequest(e);
    };
    /**
     * Launch when the prefetch request is still loading but the user
     * confirmed that they want to transition to the requested page
     * Begin page transition animation
     * @param e event
     */
    TransitionManager.prototype.prefetchRequested = function (e) {
        this.transition.launch();
    };
    /**
     * Launch when the user wants to transition to a cached request
     * Begin page transition animation
     * @param e event
     */
    TransitionManager.prototype.loadingCached = function (e) {
        this.transition.launch();
    };
    /**
     * @todo Look through element and child nodes for `data-template`
     * @todo Console.log the change if in debug
     * @todo Update $html with our active template attribute data-active
     * @param newView element
     */
    TransitionManager.prototype.getTemplateName = function (newView) {
        return 'MISSING_TEMPLATE_NAME';
    };
    /**
     * Called by the remove method
     * Switches out the inner HTML
     * Call the init modules method in our main application
     * Calls onSwitch for pjax
     * Tells the transition that we've switched the content and it can end the transition
     * @param newView element
     */
    TransitionManager.prototype.display = function (newView) {
        var templateName = this.getTemplateName(newView);
        if (env_1.isDebug)
            console.log('%c[view] ' + '%cdisplaying: ' + templateName, 'color:#4688f2', 'color:#eee');
        if (templateName === 'home')
            env_1.$html.classList.add('is-homepage');
        else
            env_1.$html.classList.remove('is-homepage');
        this.wrapper.innerHTML = newView.outerHTML;
        // Tell the app it's okay to init any new modules
        var event = new Event('initModules');
        document.dispatchEvent(event);
        /**
         * Switches old elements with new elements
         * @see pjax
         */
        this.pjax.onSwitch();
        this.transition.displayView(newView);
    };
    /**
    * Returns the detail value if the event is a CustomEvent
    * @param e event
    */
    TransitionManager.prototype.getCustomEvent = function (e) {
        return 'detail' in e;
    };
    /**
     * Called by a transition class
     * Removes the element
     * Calls the delete modules method in our main application
     * Passes our new view into the display method
     * @param oldView element
     * @param newView element
     */
    TransitionManager.prototype.remove = function (e) {
        var detail = null;
        if (this.getCustomEvent(e))
            detail = e.detail;
        else {
            if (env_1.isDebug)
                console.log('%cPage Transition Error: ' + '%cevent was not a custom event', 'color:#ff6e6e', 'color:#eee');
            return;
        }
        var templateName = this.getTemplateName(detail.o);
        if (env_1.isDebug)
            console.log('%c[view] ' + '%chiding: ' + templateName, 'color:#ff6e6e', 'color:#eee');
        detail.o.remove();
        // Tell the app to delete modules
        var event = new Event('deleteModules');
        document.dispatchEvent(event);
        this.display(detail.n);
    };
    TransitionManager.prototype.reinit = function () {
        this.transition.destroy();
        env_1.$html.setAttribute('data-transition', '');
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

/***/ "./app/scripts/utils/env.ts":
/*!**********************************!*\
  !*** ./app/scripts/utils/env.ts ***!
  \**********************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
var APP_NAME = 'papertrain';
exports.APP_NAME = APP_NAME;
var $html = document.documentElement;
exports.$html = $html;
var $body = document.body;
exports.$body = $body;
var $pjaxContainer = '.js-pjax-container';
exports.$pjaxContainer = $pjaxContainer;
var $pjaxWrapper = '.js-pjax-wrapper';
exports.$pjaxWrapper = $pjaxWrapper;
var isDebug = ($html.getAttribute('data-debug') !== null) ? !!$html.getAttribute('data-debug') : false;
exports.isDebug = isDebug;


/***/ }),

/***/ "./node_modules/pjax/index.js":
/*!************************************!*\
  !*** ./node_modules/pjax/index.js ***!
  \************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

var executeScripts = __webpack_require__(/*! ./lib/execute-scripts.js */ "./node_modules/pjax/lib/execute-scripts.js")
var forEachEls = __webpack_require__(/*! ./lib/foreach-els.js */ "./node_modules/pjax/lib/foreach-els.js")
var parseOptions = __webpack_require__(/*! ./lib/parse-options.js */ "./node_modules/pjax/lib/parse-options.js")
var switches = __webpack_require__(/*! ./lib/switches */ "./node_modules/pjax/lib/switches.js")
var newUid = __webpack_require__(/*! ./lib/uniqueid.js */ "./node_modules/pjax/lib/uniqueid.js")

var on = __webpack_require__(/*! ./lib/events/on.js */ "./node_modules/pjax/lib/events/on.js")
var trigger = __webpack_require__(/*! ./lib/events/trigger.js */ "./node_modules/pjax/lib/events/trigger.js")

var clone = __webpack_require__(/*! ./lib/util/clone.js */ "./node_modules/pjax/lib/util/clone.js")
var contains = __webpack_require__(/*! ./lib/util/contains.js */ "./node_modules/pjax/lib/util/contains.js")
var extend = __webpack_require__(/*! ./lib/util/extend.js */ "./node_modules/pjax/lib/util/extend.js")
var noop = __webpack_require__(/*! ./lib/util/noop */ "./node_modules/pjax/lib/util/noop.js")

var Pjax = function(options) {
    this.state = {
      numPendingSwitches: 0,
      href: null,
      options: null,
      isPrefetching: false,
      requestingPrefetch: false
    }

    this.cachedPrefetch = null;

    this.options = parseOptions(options)
    this.log("Pjax options", this.options)

    if (this.options.scrollRestoration && "scrollRestoration" in history) {
      history.scrollRestoration = "manual"
    }

    this.maxUid = this.lastUid = newUid()

    this.parseDOM(document)

    on(window, "popstate", function(st) {
      if (st.state) {
        var opt = clone(this.options)
        opt.url = st.state.url
        opt.title = st.state.title
        opt.history = false
        opt.scrollPos = st.state.scrollPos
        if (st.state.uid < this.lastUid) {
          opt.backward = true
        }
        else {
          opt.forward = true
        }
        this.lastUid = st.state.uid

        // @todo implement history cache here, based on uid
        this.loadUrl(st.state.url, opt)
      }
    }.bind(this))
  }

Pjax.switches = switches

Pjax.prototype = {
  log: __webpack_require__(/*! ./lib/proto/log.js */ "./node_modules/pjax/lib/proto/log.js"),

  getElements: function(el) {
    return el.querySelectorAll(this.options.elements)
  },

  parseDOM: function(el) {
    var parseElement = __webpack_require__(/*! ./lib/proto/parse-element */ "./node_modules/pjax/lib/proto/parse-element.js")
    forEachEls(this.getElements(el), parseElement, this)
  },

  refresh: function(el) {
    this.parseDOM(el || document)
  },

  reload: function() {
    window.location.reload()
  },

  attachLink: __webpack_require__(/*! ./lib/proto/attach-link.js */ "./node_modules/pjax/lib/proto/attach-link.js"),

  attachForm: __webpack_require__(/*! ./lib/proto/attach-form.js */ "./node_modules/pjax/lib/proto/attach-form.js"),

  forEachSelectors: function(cb, context, DOMcontext) {
    return __webpack_require__(/*! ./lib/foreach-selectors.js */ "./node_modules/pjax/lib/foreach-selectors.js").bind(this)(this.options.selectors, cb, context, DOMcontext)
  },

  switchSelectors: function(selectors, fromEl, toEl, options) {
    return __webpack_require__(/*! ./lib/switches-selectors.js */ "./node_modules/pjax/lib/switches-selectors.js").bind(this)(this.options.switches, this.options.switchesOptions, selectors, fromEl, toEl, options)
  },

  latestChance: function(href) {
    window.location = href
  },

  onSwitch: function() {
    trigger(window, "resize scroll")

    this.state.numPendingSwitches--

    // debounce calls, so we only run this once after all switches are finished.
    if (this.state.numPendingSwitches === 0) {
      this.afterAllSwitches()
    }
  },

  parseContent: function(html) {
    var tmpEl = document.implementation.createHTMLDocument("pjax")
    // parse HTML attributes to copy them
    // since we are forced to use documentElement.innerHTML (outerHTML can't be used for <html>)
    var htmlRegex = /<html[^>]+>/gi
    var htmlAttribsRegex = /\s?[a-z:]+(?:\=(?:\'|\")[^\'\">]+(?:\'|\"))*/gi
    var matches = html.match(htmlRegex)
    if (matches && matches.length) {
      matches = matches[0].match(htmlAttribsRegex)
      if (matches.length) {
        matches.shift()
        matches.forEach(function(htmlAttrib) {
          var attr = htmlAttrib.trim().split("=")
          if (attr.length === 1) {
            tmpEl.documentElement.setAttribute(attr[0], true)
          }
          else {
            tmpEl.documentElement.setAttribute(attr[0], attr[1].slice(1, -1))
          }
        })
      }
    }

    return tmpEl
  },

  loadPrefetchedContent: function() {
    trigger(document, "pjax:loadingCached", this.options)
    // Clear out any focused controls before inserting new page contents.
    if (document.activeElement && contains(document, this.options.selectors, document.activeElement)) {
      try {
        document.activeElement.blur()
      } catch (e) { }
    }

    this.switchSelectors(this.options.selectors, this.cachedPrefetch, document, this.options)
  },

  loadContent: function(html, options) {
    var tmpEl = this.parseContent(html)

    tmpEl.documentElement.innerHTML = html
    this.log("load content", tmpEl.documentElement.attributes, tmpEl.documentElement.innerHTML.length)

    // Clear out any focused controls before inserting new page contents.
    if (document.activeElement && contains(document, this.options.selectors, document.activeElement)) {
      try {
        document.activeElement.blur()
      } catch (e) { }
    }

    this.switchSelectors(this.options.selectors, tmpEl, document, options)
  },

  setCachedPrefetch: function(tmpEl) {
    this.cachedPrefetch = tmpEl
  },

  cachePrefetch: function(html, options) {
    if (!this.state.requestingPrefetch) {
      var tmpEl = this.parseContent(html)
      tmpEl.documentElement.innerHTML = html
      this.setCachedPrefetch(tmpEl)
    }
  },

  abortRequest: __webpack_require__(/*! ./lib/abort-request.js */ "./node_modules/pjax/lib/abort-request.js"),

  doRequest: __webpack_require__(/*! ./lib/send-request.js */ "./node_modules/pjax/lib/send-request.js"),

  handleResponse: __webpack_require__(/*! ./lib/proto/handle-response.js */ "./node_modules/pjax/lib/proto/handle-response.js"),

  loadUrl: function(href, options) {
    options = typeof options === "object" ?
      extend({}, this.options, options) :
      clone(this.options)

    this.log("load href", href, options)

    // Abort any previous request if we're not prefetching
    if (!this.state.isPrefetching) {
      this.abortRequest(this.request)
    }

    if (this.cachedPrefetch === null && !this.state.isPrefetching) {
      trigger(document, "pjax:send", options)

      // Do the request
      this.request = this.doRequest(href, options, this.handleResponse.bind(this))
    }
    else if (this.cachedPrefetch === null && this.state.isPrefetching) {
      trigger(document, "pjax:prefetchRequested", options)
      this.state.requestingPrefetch = true;
    }
    else {
      this.loadPrefetchedContent()
    }
  },

  prefetchUrl: function(href, options) {
    if (this.state.requestingPrefetch) {
      return;
    }

    options = typeof options === "object" ?
      extend({}, this.options, options) :
      clone(this.options)

    this.log("load href", href, options)

    this.state.isPrefetching = true;

    // Abort any previous request
    this.abortRequest(this.request)

    trigger(document, "pjax:prefetch", options)

    // Do the request
    this.request = this.doRequest(href, options, this.handleResponse.bind(this))
  },

  clearCachedPrefetch: function() {
    if (!this.state.requestingPrefetch) {
      this.state.isPrefetching = false;
      this.abortRequest(this.request);
      this.setCachedPrefetch(null);
    }
  },

  afterAllSwitches: function() {
    // FF bug: Won’t autofocus fields that are inserted via JS.
    // This behavior is incorrect. So if theres no current focus, autofocus
    // the last field.
    //
    // http://www.w3.org/html/wg/drafts/html/master/forms.html
    var autofocusEl = Array.prototype.slice.call(document.querySelectorAll("[autofocus]")).pop()
    if (autofocusEl && document.activeElement !== autofocusEl) {
      autofocusEl.focus()
    }

    // execute scripts when DOM have been completely updated
    this.options.selectors.forEach(function(selector) {
      forEachEls(document.querySelectorAll(selector), function(el) {
        executeScripts(el)
      })
    })

    var state = this.state
    console.log(state)

    if (state.options !== null) {
      if (state.options.history) {
        if (!window.history.state) {
          this.lastUid = this.maxUid = newUid()
          window.history.replaceState({
              url: window.location.href,
              title: document.title,
              uid: this.maxUid,
              scrollPos: [0, 0]
            },
            document.title)
        }

        // Update browser history
        this.lastUid = this.maxUid = newUid()

        window.history.pushState({
            url: state.href,
            title: state.options.title,
            uid: this.maxUid,
            scrollPos: [0, 0]
          },
          state.options.title,
          state.href)
      }
    }

    this.forEachSelectors(function(el) {
      this.parseDOM(el)
    }, this)

    // Fire Events
    trigger(document,"pjax:complete pjax:success", state.options)

    if (typeof state.options.analytics === "function") {
      state.options.analytics()
    }

    if (state.options.history) {
      // First parse url and check for hash to override scroll
      var a = document.createElement("a")
      a.href = this.state.href
      if (a.hash) {
        var name = a.hash.slice(1)
        name = decodeURIComponent(name)

        var curtop = 0
        var target = document.getElementById(name) || document.getElementsByName(name)[0]
        if (target) {
          // http://stackoverflow.com/questions/8111094/cross-browser-javascript-function-to-find-actual-position-of-an-element-in-page
          if (target.offsetParent) {
            do {
              curtop += target.offsetTop

              target = target.offsetParent
            } while (target)
          }
        }
        window.scrollTo(0, curtop)
      }
      else if (state.options.scrollTo !== false) {
        // Scroll page to top on new page load
        if (state.options.scrollTo.length > 1) {
          window.scrollTo(state.options.scrollTo[0], state.options.scrollTo[1])
        }
        else {
          window.scrollTo(0, state.options.scrollTo)
        }
      }
    }
    else if (state.options.scrollRestoration && state.options.scrollPos) {
      window.scrollTo(state.options.scrollPos[0], state.options.scrollPos[1])
    }

    this.state = {
      numPendingSwitches: 0,
      href: null,
      options: null,
      isPrefetching: false,
      requestingPrefetch: false
    }
  }
}

Pjax.isSupported = __webpack_require__(/*! ./lib/is-supported.js */ "./node_modules/pjax/lib/is-supported.js")

// arguably could do `if ( require("./lib/is-supported.js")()) {` but that might be a little to simple
if (Pjax.isSupported()) {
  module.exports = Pjax
}
// if there isn’t required browser functions, returning stupid api
else {
  var stupidPjax = noop
  for (var key in Pjax.prototype) {
    if (Pjax.prototype.hasOwnProperty(key) && typeof Pjax.prototype[key] === "function") {
      stupidPjax[key] = noop
    }
  }

  module.exports = stupidPjax
}


/***/ }),

/***/ "./node_modules/pjax/lib/abort-request.js":
/*!************************************************!*\
  !*** ./node_modules/pjax/lib/abort-request.js ***!
  \************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

var noop = __webpack_require__(/*! ./util/noop */ "./node_modules/pjax/lib/util/noop.js")

module.exports = function(request) {
  if (request && request.readyState < 4) {
    request.onreadystatechange = noop
    request.abort()
  }
}


/***/ }),

/***/ "./node_modules/pjax/lib/eval-script.js":
/*!**********************************************!*\
  !*** ./node_modules/pjax/lib/eval-script.js ***!
  \**********************************************/
/*! no static exports found */
/***/ (function(module, exports) {

module.exports = function(el) {
  var code = (el.text || el.textContent || el.innerHTML || "")
  var src = (el.src || "")
  var parent = el.parentNode || document.querySelector("head") || document.documentElement
  var script = document.createElement("script")

  if (code.match("document.write")) {
    if (console && console.log) {
      console.log("Script contains document.write. Can’t be executed correctly. Code skipped ", el)
    }
    return false
  }

  script.type = "text/javascript"

  /* istanbul ignore if */
  if (src !== "") {
    script.src = src
    script.async = false // force synchronous loading of peripheral JS
  }

  if (code !== "") {
    try {
      script.appendChild(document.createTextNode(code))
    }
    catch (e) {
      /* istanbul ignore next */
      // old IEs have funky script nodes
      script.text = code
    }
  }

  // execute
  parent.appendChild(script)
  // avoid pollution only in head or body tags
  if (parent instanceof HTMLHeadElement || parent instanceof HTMLBodyElement) {
    parent.removeChild(script)
  }

  return true
}


/***/ }),

/***/ "./node_modules/pjax/lib/events/on.js":
/*!********************************************!*\
  !*** ./node_modules/pjax/lib/events/on.js ***!
  \********************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

var forEachEls = __webpack_require__(/*! ../foreach-els */ "./node_modules/pjax/lib/foreach-els.js")

module.exports = function(els, events, listener, useCapture) {
  events = (typeof events === "string" ? events.split(" ") : events)

  events.forEach(function(e) {
    forEachEls(els, function(el) {
      el.addEventListener(e, listener, useCapture)
    })
  })
}


/***/ }),

/***/ "./node_modules/pjax/lib/events/trigger.js":
/*!*************************************************!*\
  !*** ./node_modules/pjax/lib/events/trigger.js ***!
  \*************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

var forEachEls = __webpack_require__(/*! ../foreach-els */ "./node_modules/pjax/lib/foreach-els.js")

module.exports = function(els, events, opts) {
  events = (typeof events === "string" ? events.split(" ") : events)

  events.forEach(function(e) {
    var event
    event = document.createEvent("HTMLEvents")
    event.initEvent(e, true, true)
    event.eventName = e
    if (opts) {
      Object.keys(opts).forEach(function(key) {
        event[key] = opts[key]
      })
    }

    forEachEls(els, function(el) {
      var domFix = false
      if (!el.parentNode && el !== document && el !== window) {
        // THANK YOU IE (9/10/11)
        // dispatchEvent doesn't work if the element is not in the DOM
        domFix = true
        document.body.appendChild(el)
      }
      el.dispatchEvent(event)
      if (domFix) {
        el.parentNode.removeChild(el)
      }
    })
  })
}


/***/ }),

/***/ "./node_modules/pjax/lib/execute-scripts.js":
/*!**************************************************!*\
  !*** ./node_modules/pjax/lib/execute-scripts.js ***!
  \**************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

var forEachEls = __webpack_require__(/*! ./foreach-els */ "./node_modules/pjax/lib/foreach-els.js")
var evalScript = __webpack_require__(/*! ./eval-script */ "./node_modules/pjax/lib/eval-script.js")
// Finds and executes scripts (used for newly added elements)
// Needed since innerHTML does not run scripts
module.exports = function(el) {
  if (el.tagName.toLowerCase() === "script") {
    evalScript(el)
  }

  forEachEls(el.querySelectorAll("script"), function(script) {
    if (!script.type || script.type.toLowerCase() === "text/javascript") {
      if (script.parentNode) {
        script.parentNode.removeChild(script)
      }
      evalScript(script)
    }
  })
}


/***/ }),

/***/ "./node_modules/pjax/lib/foreach-els.js":
/*!**********************************************!*\
  !*** ./node_modules/pjax/lib/foreach-els.js ***!
  \**********************************************/
/*! no static exports found */
/***/ (function(module, exports) {

/* global HTMLCollection: true */

module.exports = function(els, fn, context) {
  if (els instanceof HTMLCollection || els instanceof NodeList || els instanceof Array) {
    return Array.prototype.forEach.call(els, fn, context)
  }
  // assume simple DOM element
  return fn.call(context, els)
}


/***/ }),

/***/ "./node_modules/pjax/lib/foreach-selectors.js":
/*!****************************************************!*\
  !*** ./node_modules/pjax/lib/foreach-selectors.js ***!
  \****************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

var forEachEls = __webpack_require__(/*! ./foreach-els */ "./node_modules/pjax/lib/foreach-els.js")

module.exports = function(selectors, cb, context, DOMcontext) {
  DOMcontext = DOMcontext || document
  selectors.forEach(function(selector) {
    forEachEls(DOMcontext.querySelectorAll(selector), cb, context)
  })
}


/***/ }),

/***/ "./node_modules/pjax/lib/is-supported.js":
/*!***********************************************!*\
  !*** ./node_modules/pjax/lib/is-supported.js ***!
  \***********************************************/
/*! no static exports found */
/***/ (function(module, exports) {

module.exports = function() {
  // Borrowed wholesale from https://github.com/defunkt/jquery-pjax
  return window.history &&
    window.history.pushState &&
    window.history.replaceState &&
    // pushState isn’t reliable on iOS until 5.
    !navigator.userAgent.match(/((iPod|iPhone|iPad).+\bOS\s+[1-4]\D|WebApps\/.+CFNetwork)/)
}


/***/ }),

/***/ "./node_modules/pjax/lib/parse-options.js":
/*!************************************************!*\
  !*** ./node_modules/pjax/lib/parse-options.js ***!
  \************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

/* global _gaq: true, ga: true */

var defaultSwitches = __webpack_require__(/*! ./switches */ "./node_modules/pjax/lib/switches.js")

module.exports = function(options) {
  options = options || {}
  options.elements = options.elements || "a[href], form[action]"
  options.selectors = options.selectors || ["title", ".js-Pjax"]
  options.switches = options.switches || {}
  options.switchesOptions = options.switchesOptions || {}
  options.history = (typeof options.history === "undefined") ? true : options.history
  options.analytics = (typeof options.analytics === "function" || options.analytics === false) ? options.analytics : defaultAnalytics
  options.scrollTo = (typeof options.scrollTo === "undefined") ? 0 : options.scrollTo
  options.scrollRestoration = (typeof options.scrollRestoration !== "undefined") ? options.scrollRestoration : true
  options.cacheBust = (typeof options.cacheBust === "undefined") ? true : options.cacheBust
  options.debug = options.debug || false
  options.timeout = options.timeout || 0
  options.currentUrlFullReload = (typeof options.currentUrlFullReload === "undefined") ? false : options.currentUrlFullReload
  options.prefetch = (typeof options.prefetch === "undefined") ? true : options.prefetch

  // We can’t replace body.outerHTML or head.outerHTML.
  // It creates a bug where a new body or head are created in the DOM.
  // If you set head.outerHTML, a new body tag is appended, so the DOM has 2 body nodes, and vice versa
  if (!options.switches.head) {
    options.switches.head = defaultSwitches.switchElementsAlt
  }
  if (!options.switches.body) {
    options.switches.body = defaultSwitches.switchElementsAlt
  }

  return options
}

/* istanbul ignore next */
function defaultAnalytics() {
  if (window._gaq) {
    _gaq.push(["_trackPageview"])
  }
  if (window.ga) {
    ga("send", "pageview", {page: location.pathname, title: document.title})
  }
}


/***/ }),

/***/ "./node_modules/pjax/lib/proto/attach-form.js":
/*!****************************************************!*\
  !*** ./node_modules/pjax/lib/proto/attach-form.js ***!
  \****************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

var on = __webpack_require__(/*! ../events/on */ "./node_modules/pjax/lib/events/on.js")
var clone = __webpack_require__(/*! ../util/clone */ "./node_modules/pjax/lib/util/clone.js")

var attrState = "data-pjax-state"

var formAction = function(el, event) {
  if (isDefaultPrevented(event)) {
    return
  }

  // Since loadUrl modifies options and we may add our own modifications below,
  // clone it so the changes don't persist
  var options = clone(this.options)

  // Initialize requestOptions
  options.requestOptions = {
    requestUrl: el.getAttribute("action") || window.location.href,
    requestMethod: el.getAttribute("method") || "GET"
  }

  // create a testable virtual link of the form action
  var virtLinkElement = document.createElement("a")
  virtLinkElement.setAttribute("href", options.requestOptions.requestUrl)

  var attrValue = checkIfShouldAbort(virtLinkElement, options)
  if (attrValue) {
    el.setAttribute(attrState, attrValue)
    return
  }

  event.preventDefault()

  if (el.enctype === "multipart/form-data") {
    options.requestOptions.formData = new FormData(el)
  }
  else {
    options.requestOptions.requestParams = parseFormElements(el)
  }

  el.setAttribute(attrState, "submit")

  options.triggerElement = el
  this.loadUrl(virtLinkElement.href, options)
}

function parseFormElements(el) {
  var requestParams = []

  for (var elementKey in el.elements) {
    if (Number.isNaN(Number(elementKey))) {
      continue;
    }

    var element = el.elements[elementKey]
    var tagName = element.tagName.toLowerCase()
    // jscs:disable disallowImplicitTypeConversion
    if (!!element.name && element.attributes !== undefined && tagName !== "button") {
      // jscs:enable disallowImplicitTypeConversion
      var type = element.attributes.type

      if ((!type || type.value !== "checkbox" && type.value !== "radio") || element.checked) {
        // Build array of values to submit
        var values = []

        if (tagName === "select") {
          var opt

          for (var i = 0; i < element.options.length; i++) {
            opt = element.options[i]
            if (opt.selected && !opt.disabled) {
              values.push(opt.hasAttribute("value") ? opt.value : opt.text)
            }
          }
        }
        else {
          values.push(element.value)
        }

        for (var j = 0; j < values.length; j++) {
          requestParams.push({
            name: encodeURIComponent(element.name),
            value: encodeURIComponent(values[j])
          })
        }
      }
    }
  }

  return requestParams
}

function checkIfShouldAbort(virtLinkElement, options) {
  // Ignore external links.
  if (virtLinkElement.protocol !== window.location.protocol || virtLinkElement.host !== window.location.host) {
    return "external"
  }

  // Ignore click if we are on an anchor on the same page
  if (virtLinkElement.hash && virtLinkElement.href.replace(virtLinkElement.hash, "") === window.location.href.replace(location.hash, "")) {
    return "anchor"
  }

  // Ignore empty anchor "foo.html#"
  if (virtLinkElement.href === window.location.href.split("#")[0] + "#") {
    return "anchor-empty"
  }

  // if declared as a full reload, just normally submit the form
  if (options.currentUrlFullReload && virtLinkElement.href === window.location.href.split("#")[0]) {
    return "reload"
  }
}

var isDefaultPrevented = function(event) {
  return event.defaultPrevented || event.returnValue === false
}

module.exports = function(el) {
  var that = this

  el.setAttribute(attrState, "")

  on(el, "submit", function(event) {
    formAction.call(that, el, event)
  })

  on(el, "keyup", function(event) {
    var disableKeyup = (el.hasAttribute("disable-keyup")) ? true : false;
    if (event.keyCode === 13 && !disableKeyup) {
      formAction.call(that, el, event)
    }
  }.bind(this))
}


/***/ }),

/***/ "./node_modules/pjax/lib/proto/attach-link.js":
/*!****************************************************!*\
  !*** ./node_modules/pjax/lib/proto/attach-link.js ***!
  \****************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

var on = __webpack_require__(/*! ../events/on */ "./node_modules/pjax/lib/events/on.js")
var clone = __webpack_require__(/*! ../util/clone */ "./node_modules/pjax/lib/util/clone.js")

var attrState = "data-pjax-state"

var linkAction = function(el, event) {
  if (isDefaultPrevented(event)) {
    return
  }

  // Since loadUrl modifies options and we may add our own modifications below,
  // clone it so the changes don't persist
  var options = clone(this.options)

  var attrValue = checkIfShouldAbort(el, event)
  if (attrValue) {
    el.setAttribute(attrState, attrValue)
    return
  }

  event.preventDefault()

  // don’t do "nothing" if user try to reload the page by clicking the same link twice
  if (
    this.options.currentUrlFullReload &&
    el.href === window.location.href.split("#")[0]
  ) {
    el.setAttribute(attrState, "reload")
    this.reload()
    return
  }

  el.setAttribute(attrState, "load")

  options.triggerElement = el
  this.loadUrl(el.href, options)
}

function checkIfShouldAbort(el, event) {
  // Don’t break browser special behavior on links (like page in new window)
  if (event.which > 1 || event.metaKey || event.ctrlKey || event.shiftKey || event.altKey) {
    return "modifier"
  }

  // we do test on href now to prevent unexpected behavior if for some reason
  // user have href that can be dynamically updated

  // Ignore external links.
  if (el.protocol !== window.location.protocol || el.host !== window.location.host) {
    return "external"
  }

  // Ignore anchors on the same page (keep native behavior)
  if (el.hash && el.href.replace(el.hash, "") === window.location.href.replace(location.hash, "")) {
    return "anchor"
  }

  // Ignore empty anchor "foo.html#"
  if (el.href === window.location.href.split("#")[0] + "#") {
    return "anchor-empty"
  }
}

var isDefaultPrevented = function(event) {
  return event.defaultPrevented || event.returnValue === false
}

var hoverAction = function(el, event) {
  if (isDefaultPrevented(event)) {
    return
  }

  // Since loadUrl modifies options and we may add our own modifications below,
  // clone it so the changes don't persist
  var options = clone(this.options)

  if (!options.prefetch) {
    return
  }

  if (event.type === "mouseout") {
    this.clearCachedPrefetch()
  }
  else {
    var attrValue = checkIfShouldAbort(el, event)
    if (attrValue) {
      el.setAttribute(attrState, attrValue)
      return
    }

    // don’t do "nothing" if user try to reload the page by clicking the same link twice
    if (
      this.options.currentUrlFullReload &&
      el.href === window.location.href.split("#")[0]
    ) {
      el.setAttribute(attrState, "reload")
      this.reload()
      return
    }

    el.setAttribute(attrState, "load")

    options.triggerElement = el
    this.prefetchUrl(el.href, options)
  }
}

module.exports = function(el) {
  var that = this

  el.setAttribute(attrState, "")

  on(el, "click", function(event) {
    linkAction.call(that, el, event)
  })

  on(el, "mouseover", function(event) {
    hoverAction.call(that, el, event)
  })

  on(el, "mouseout", function(event) {
    hoverAction.call(that, el, event)
  })

  on(el, "keyup", function(event) {
    if (event.keyCode === 13) {
      linkAction.call(that, el, event)
    }
  }.bind(this))
}


/***/ }),

/***/ "./node_modules/pjax/lib/proto/handle-response.js":
/*!********************************************************!*\
  !*** ./node_modules/pjax/lib/proto/handle-response.js ***!
  \********************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

var clone = __webpack_require__(/*! ../util/clone.js */ "./node_modules/pjax/lib/util/clone.js")
var newUid = __webpack_require__(/*! ../uniqueid.js */ "./node_modules/pjax/lib/uniqueid.js")
var trigger = __webpack_require__(/*! ../events/trigger.js */ "./node_modules/pjax/lib/events/trigger.js")

module.exports = function(responseText, request, href, options) {
  options = clone(options  || this.options)
  options.request = request

  if(request.status === 404){
    trigger(document, 'pjax:complete pjax:error pjax:404', options);
    if(options.prefetch) this.prefetchError(href)
    else this.latestChance(href)
  }

  // Fail if unable to load HTML via AJAX
  if (responseText === false || responseText === null) {
    trigger(document, "pjax:complete pjax:error", options)

    return
  }

  this.state.href = href
  this.state.options = options

  if (!options.prefetch || options.prefetch && this.state.isPrefetching && this.state.requestingPrefetch) {
    // push scroll position to history
    var currentState = window.history.state || {}
    window.history.replaceState({
        url: currentState.url || window.location.href,
        title: currentState.title || document.title,
        uid: currentState.uid || newUid(),
        scrollPos: [document.documentElement.scrollLeft || document.body.scrollLeft,
          document.documentElement.scrollTop || document.body.scrollTop]
      },
      document.title, window.location)

    // Check for redirects
    var oldHref = href
    if (request.responseURL) {
      if (href !== request.responseURL) {
        href = request.responseURL
      }
    }
    else if (request.getResponseHeader("X-PJAX-URL")) {
      href = request.getResponseHeader("X-PJAX-URL")
    }
    else if (request.getResponseHeader("X-XHR-Redirected-To")) {
      href = request.getResponseHeader("X-XHR-Redirected-To")
    }

    // Add back the hash if it was removed
    var a = document.createElement("a")
    a.href = oldHref
    var oldHash = a.hash
    a.href = href
    if (oldHash && !a.hash) {
      a.hash = oldHash
      href = a.href
    }

    try {
      this.loadContent(responseText, this.options)
    }
    catch (e) {
      trigger(document, "pjax:error", options)

      if (!this.options.debug) {
        if (console && console.error) {
          console.error("Pjax switch fail: ", e)
        }
        return this.latestChance(href)
      }
      else {
        throw e
      }
    }
  }
  else {
    this.cachePrefetch(responseText, this.options)
  }
}


/***/ }),

/***/ "./node_modules/pjax/lib/proto/log.js":
/*!********************************************!*\
  !*** ./node_modules/pjax/lib/proto/log.js ***!
  \********************************************/
/*! no static exports found */
/***/ (function(module, exports) {

module.exports = function() {
  if (this.options.debug && console) {
    if (typeof console.log === "function") {
      console.log.apply(console, arguments)
    }
    // IE is weird
    else if (console.log) {
      console.log(arguments)
    }
  }
}


/***/ }),

/***/ "./node_modules/pjax/lib/proto/parse-element.js":
/*!******************************************************!*\
  !*** ./node_modules/pjax/lib/proto/parse-element.js ***!
  \******************************************************/
/*! no static exports found */
/***/ (function(module, exports) {

var attrState = "data-pjax-state"

module.exports = function(el) {
  switch (el.tagName.toLowerCase()) {
    case "a":
      // only attach link if el does not already have link attached
      if (!el.hasAttribute(attrState)) {
        this.attachLink(el)
      }
      break

    case "form":
      // only attach link if el does not already have link attached
      if (!el.hasAttribute(attrState)) {
        this.attachForm(el)
      }
      break

    default:
      throw "Pjax can only be applied on <a> or <form> submit"
  }
}


/***/ }),

/***/ "./node_modules/pjax/lib/send-request.js":
/*!***********************************************!*\
  !*** ./node_modules/pjax/lib/send-request.js ***!
  \***********************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

var updateQueryString = __webpack_require__(/*! ./util/update-query-string */ "./node_modules/pjax/lib/util/update-query-string.js");

module.exports = function(location, options, callback) {
  options = options || {}
  var queryString
  var requestOptions = options.requestOptions || {}
  var requestMethod = (requestOptions.requestMethod || "GET").toUpperCase()
  var requestParams = requestOptions.requestParams || null
  var formData = requestOptions.formData || null;
  var requestPayload = null
  var request = new XMLHttpRequest()
  var timeout = options.timeout || 0

  request.onreadystatechange = function() {
    if (request.readyState === 4) {
      if (request.status === 200) {
        callback(request.responseText, request, location, options)
      }
      else if (request.status !== 0) {
        callback(null, request, location, options)
      }
    }
  }

  request.onerror = function(e) {
    console.log(e)
    callback(null, request, location, options)
  }

  request.ontimeout = function() {
    callback(null, request, location, options)
  }

  // Prepare the request payload for forms, if available
  if (requestParams && requestParams.length) {
    // Build query string
    queryString = (requestParams.map(function(param) {return param.name + "=" + param.value})).join("&")

    switch (requestMethod) {
      case "GET":
        // Reset query string to avoid an issue with repeat submissions where checkboxes that were
        // previously checked are incorrectly preserved
        location = location.split("?")[0]

        // Append new query string
        location += "?" + queryString
        break

      case "POST":
        // Send query string as request payload
        requestPayload = queryString
        break
    }
  }
  else if (formData) {
    requestPayload = formData
  }

  // Add a timestamp as part of the query string if cache busting is enabled
  if (options.cacheBust) {
    location = updateQueryString(location, "t", Date.now())
  }

  request.open(requestMethod, location, true)
  request.timeout = timeout
  request.setRequestHeader("X-Requested-With", "XMLHttpRequest")
  request.setRequestHeader("X-PJAX", "true")
  request.setRequestHeader("X-PJAX-Selectors", JSON.stringify(options.selectors))

  // Send the proper header information for POST forms
  if (requestPayload && requestMethod === "POST") {
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
  }

  request.send(requestPayload)

  return request
}


/***/ }),

/***/ "./node_modules/pjax/lib/switches-selectors.js":
/*!*****************************************************!*\
  !*** ./node_modules/pjax/lib/switches-selectors.js ***!
  \*****************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

var forEachEls = __webpack_require__(/*! ./foreach-els */ "./node_modules/pjax/lib/foreach-els.js")

var defaultSwitches = __webpack_require__(/*! ./switches */ "./node_modules/pjax/lib/switches.js")

module.exports = function(switches, switchesOptions, selectors, fromEl, toEl, options) {
  var switchesQueue = []

  selectors.forEach(function(selector) {
    var newEls = fromEl.querySelectorAll(selector)
    var oldEls = toEl.querySelectorAll(selector)
    if (this.log) {
      this.log("Pjax switch", selector, newEls, oldEls)
    }
    if (newEls.length !== oldEls.length) {
      throw "DOM doesn’t look the same on new loaded page: ’" + selector + "’ - new " + newEls.length + ", old " + oldEls.length
    }

    forEachEls(newEls, function(newEl, i) {
      var oldEl = oldEls[i]
      if (this.log) {
        this.log("newEl", newEl, "oldEl", oldEl)
      }

      var callback = (switches[selector]) ?
        switches[selector].bind(this, oldEl, newEl, options, switchesOptions[selector]) :
        defaultSwitches.outerHTML.bind(this, oldEl, newEl, options)

      switchesQueue.push(callback)
    }, this)
  }, this)

  this.state.numPendingSwitches = switchesQueue.length

  switchesQueue.forEach(function(queuedSwitch) {
    queuedSwitch()
  })
}


/***/ }),

/***/ "./node_modules/pjax/lib/switches.js":
/*!*******************************************!*\
  !*** ./node_modules/pjax/lib/switches.js ***!
  \*******************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

var on = __webpack_require__(/*! ./events/on.js */ "./node_modules/pjax/lib/events/on.js")

module.exports = {
  outerHTML: function(oldEl, newEl) {
    oldEl.outerHTML = newEl.outerHTML
    this.onSwitch()
  },

  innerHTML: function(oldEl, newEl) {
    oldEl.innerHTML = newEl.innerHTML

    if (newEl.className === "") {
      oldEl.removeAttribute("class")
    }
    else {
      oldEl.className = newEl.className
    }

    this.onSwitch()
  },

  switchElementsAlt: function(oldEl, newEl) {
    oldEl.innerHTML = newEl.innerHTML

    // Copy attributes from the new element to the old one
    if (newEl.hasAttributes()) {
      var attrs = newEl.attributes
      for (var i = 0; i < attrs.length; i++) {
        oldEl.attributes.setNamedItem(attrs[i].cloneNode())
      }
    }

    this.onSwitch()
  },

  // Equivalent to outerHTML(), but doesn't require switchElementsAlt() for <head> and <body>
  replaceNode: function(oldEl, newEl) {
    oldEl.parentNode.replaceChild(newEl, oldEl)
    this.onSwitch()
  },

  sideBySide: function(oldEl, newEl, options, switchOptions) {
    var forEach = Array.prototype.forEach
    var elsToRemove = []
    var elsToAdd = []
    var fragToAppend = document.createDocumentFragment()
    var animationEventNames = "animationend webkitAnimationEnd MSAnimationEnd oanimationend"
    var animatedElsNumber = 0
    var sexyAnimationEnd = function(e) {
          if (e.target !== e.currentTarget) {
            // end triggered by an animation on a child
            return
          }

          animatedElsNumber--
          if (animatedElsNumber <= 0 && elsToRemove) {
            elsToRemove.forEach(function(el) {
              // browsing quickly can make the el
              // already removed by last page update ?
              if (el.parentNode) {
                el.parentNode.removeChild(el)
              }
            })

            elsToAdd.forEach(function(el) {
              el.className = el.className.replace(el.getAttribute("data-pjax-classes"), "")
              el.removeAttribute("data-pjax-classes")
            })

            elsToAdd = null // free memory
            elsToRemove = null // free memory

            // this is to trigger some repaint (example: picturefill)
            this.onSwitch()
          }
        }.bind(this)

    switchOptions = switchOptions || {}

    forEach.call(oldEl.childNodes, function(el) {
      elsToRemove.push(el)
      if (el.classList && !el.classList.contains("js-Pjax-remove")) {
        // for fast switch, clean element that just have been added, & not cleaned yet.
        if (el.hasAttribute("data-pjax-classes")) {
          el.className = el.className.replace(el.getAttribute("data-pjax-classes"), "")
          el.removeAttribute("data-pjax-classes")
        }
        el.classList.add("js-Pjax-remove")
        if (switchOptions.callbacks && switchOptions.callbacks.removeElement) {
          switchOptions.callbacks.removeElement(el)
        }
        if (switchOptions.classNames) {
          el.className += " " + switchOptions.classNames.remove + " " + (options.backward ? switchOptions.classNames.backward : switchOptions.classNames.forward)
        }
        animatedElsNumber++
        on(el, animationEventNames, sexyAnimationEnd, true)
      }
    })

    forEach.call(newEl.childNodes, function(el) {
      if (el.classList) {
        var addClasses = ""
        if (switchOptions.classNames) {
          addClasses = " js-Pjax-add " + switchOptions.classNames.add + " " + (options.backward ? switchOptions.classNames.forward : switchOptions.classNames.backward)
        }
        if (switchOptions.callbacks && switchOptions.callbacks.addElement) {
          switchOptions.callbacks.addElement(el)
        }
        el.className += addClasses
        el.setAttribute("data-pjax-classes", addClasses)
        elsToAdd.push(el)
        fragToAppend.appendChild(el)
        animatedElsNumber++
        on(el, animationEventNames, sexyAnimationEnd, true)
      }
    })

    // pass all className of the parent
    oldEl.className = newEl.className
    oldEl.appendChild(fragToAppend)
  }
}


/***/ }),

/***/ "./node_modules/pjax/lib/uniqueid.js":
/*!*******************************************!*\
  !*** ./node_modules/pjax/lib/uniqueid.js ***!
  \*******************************************/
/*! no static exports found */
/***/ (function(module, exports) {

module.exports = (function() {
  var counter = 0
  return function() {
    var id = ("pjax" + (new Date().getTime())) + "_" + counter
    counter++
    return id
  }
})()


/***/ }),

/***/ "./node_modules/pjax/lib/util/clone.js":
/*!*********************************************!*\
  !*** ./node_modules/pjax/lib/util/clone.js ***!
  \*********************************************/
/*! no static exports found */
/***/ (function(module, exports) {

module.exports = function(obj) {
  /* istanbul ignore if */
  if (null === obj || "object" !== typeof obj) {
    return obj
  }
  var copy = obj.constructor()
  for (var attr in obj) {
    if (obj.hasOwnProperty(attr)) {
      copy[attr] = obj[attr]
    }
  }
  return copy
}


/***/ }),

/***/ "./node_modules/pjax/lib/util/contains.js":
/*!************************************************!*\
  !*** ./node_modules/pjax/lib/util/contains.js ***!
  \************************************************/
/*! no static exports found */
/***/ (function(module, exports) {

module.exports = function contains(doc, selectors, el) {
  for (var i = 0; i < selectors.length; i++) {
    var selectedEls = doc.querySelectorAll(selectors[i])
    for (var j = 0; j < selectedEls.length; j++) {
      if (selectedEls[j].contains(el)) {
        return true
      }
    }
  }

  return false
}


/***/ }),

/***/ "./node_modules/pjax/lib/util/extend.js":
/*!**********************************************!*\
  !*** ./node_modules/pjax/lib/util/extend.js ***!
  \**********************************************/
/*! no static exports found */
/***/ (function(module, exports) {

module.exports = function(target) {
  if (target == null) {
    return null
  }

  var to = Object(target)

  for (var i = 1; i < arguments.length; i++) {
    var source = arguments[i]

    if (source != null) {
      for (var key in source) {
        // Avoid bugs when hasOwnProperty is shadowed
        if (Object.prototype.hasOwnProperty.call(source, key)) {
          to[key] = source[key]
        }
      }
    }
  }
  return to
}


/***/ }),

/***/ "./node_modules/pjax/lib/util/noop.js":
/*!********************************************!*\
  !*** ./node_modules/pjax/lib/util/noop.js ***!
  \********************************************/
/*! no static exports found */
/***/ (function(module, exports) {

module.exports = function() {}


/***/ }),

/***/ "./node_modules/pjax/lib/util/update-query-string.js":
/*!***********************************************************!*\
  !*** ./node_modules/pjax/lib/util/update-query-string.js ***!
  \***********************************************************/
/*! no static exports found */
/***/ (function(module, exports) {

module.exports = function(uri, key, value) {
  var re = new RegExp("([?&])" + key + "=.*?(&|$)", "i")
  var separator = uri.indexOf("?") !== -1 ? "&" : "?"
  if (uri.match(re)) {
    return uri.replace(re, "$1" + key + "=" + value + "$2")
  }
  else {
    return uri + separator + key + "=" + value
  }
}


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

__webpack_require__(/*! C:\Users\andre\Desktop\projects\papertrain\app\scripts\App.ts */"./app/scripts/App.ts");
module.exports = __webpack_require__(/*! C:\Users\andre\Desktop\projects\papertrain\app\sass\main.scss */"./app/sass/main.scss");


/***/ })

/******/ });
//# sourceMappingURL=app.js.map