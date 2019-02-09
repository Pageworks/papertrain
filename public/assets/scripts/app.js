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

var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (Object.hasOwnProperty.call(mod, k)) result[k] = mod[k];
    result["default"] = mod;
    return result;
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
var env_1 = __webpack_require__(/*! ./env */ "./app/scripts/env.ts");
var modules = __importStar(__webpack_require__(/*! ./modules */ "./app/scripts/modules.ts"));
var TransitionManager_1 = __importDefault(__webpack_require__(/*! ./transitions/TransitionManager */ "./app/scripts/transitions/TransitionManager.ts"));
var polyfill_1 = __importDefault(__webpack_require__(/*! ./polyfill */ "./app/scripts/polyfill.ts"));
var v4_1 = __importDefault(__webpack_require__(/*! uuid/v4 */ "./node_modules/uuid/v4.js"));
var App = /** @class */ (function () {
    function App() {
        var _this = this;
        this.userTouched = function () {
            document.body.removeEventListener('touchstart', _this.userTouched);
            env_1.html.classList.add('has-touched');
            env_1.html.classList.remove('has-not-touched');
        };
        this._modules = modules;
        this._currentModules = [];
        this._transitionManager = null;
        this._touchSupport = ('ontouchstart' in window) || (navigator.maxTouchPoints > 0) || (navigator.msMaxTouchPoints > 0);
        this._prevScroll = 0;
        this._scrollDistance = 0;
        this.init();
    }
    /**
     * Used to call any methods needed when the application initially loads
     */
    App.prototype.init = function () {
        var _this = this;
        env_1.html.classList.remove('has-no-js');
        env_1.html.classList.add('has-js');
        // If user is using IE 11 load the polyfill
        if ('-ms-scroll-limit' in document.documentElement.style && '-ms-ime-align' in document.documentElement.style) {
            polyfill_1.default();
        }
        // Check for production debug status
        if (env_1.html.getAttribute('data-debug') !== null) {
            env_1.setDebug(true);
        }
        if (this._touchSupport) {
            env_1.html.classList.add('is-touch-device');
            env_1.html.classList.remove('is-not-touch-device');
            document.body.addEventListener('touchstart', this.userTouched);
        }
        window.addEventListener('load', function (e) { env_1.html.classList.add('has-loaded'); });
        window.addEventListener('scroll', function (e) { return _this.handleScroll(); });
        this.initModules(); // Get initial modules
        this.handleStatus(); // Check the users visitor status
        this._transitionManager = new TransitionManager_1.default(this);
        if (!env_1.isDebug) {
            this.createEasterEgg();
        }
    };
    /**
     * Called on a production build of the application.
     * Displays the Pageworks logo in ASCII along with a link to the company website.
     */
    App.prototype.createEasterEgg = function () {
        var lines = [
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
        console.log("%c" + lines.join('\n').toString(), 'color: #a7ab2d; font-size: 14px;');
    };
    /**
     * Called when the user scrolls.
     * Manages the `has-scrolled` status class attached to the document.
     */
    App.prototype.handleScroll = function () {
        var currentScroll = window.scrollY;
        if (!env_1.html.classList.contains('has-scrolled') && currentScroll >= this._prevScroll) {
            this._scrollDistance += currentScroll - this._prevScroll;
            if (this._scrollDistance >= env_1.scrollTrigger) {
                env_1.html.classList.add('has-scrolled');
            }
        }
        else if (env_1.html.classList.contains('has-scrolled') && currentScroll < this._prevScroll) {
            env_1.html.classList.remove('has-scrolled');
            this._scrollDistance = 0;
        }
        this._prevScroll = currentScroll;
    };
    /**
     * Sets relevant classes based on the users visitor status.
     * Uses local storage to store status trackers.
     * @todo Check if we need permision to set these trackers.
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
        else {
            env_1.html.classList.add('is-returning');
        }
        window.localStorage.setItem(env_1.APP_NAME + "_DailyVisit", Date.now().toString()); // Always update daily visit status
    };
    /**
     * Parses supplied string and returns an array of module names.
     * @returns `string[]`
     * @param { string } data - a string taken from an elements `data-modules` attribute
     */
    App.prototype.getModuleNames = function (data) {
        // Trim whitespace and spit the string by whitespace
        var modules = data.trim().split(/\s+/gi);
        // Fixes array for empty `data-module` attributes
        if (modules.length === 1 && modules[0] === '') {
            modules = [];
        }
        return modules;
    };
    /**
     * Gets all module references in the document and creates a new module
     * If a module already has a UUID we won't do anything since it already
     * has a module associated with the HTML element
     */
    App.prototype.initModules = function () {
        var _this = this;
        var modules = Array.from(document.querySelectorAll('[data-module]'));
        modules.forEach(function (module) {
            var requestedModules = module.getAttribute('data-module');
            var modules = _this.getModuleNames(requestedModules);
            if (modules.length === 0) {
                if (env_1.isDebug) {
                    console.log('%cEmpty Module Attribute Detected', 'color:#ff6e6e');
                }
                return;
            }
            var existingUUID = module.getAttribute('data-uuid');
            var newUUID = v4_1.default();
            for (var i = 0; i < modules.length; i++) {
                if (_this._modules[modules[i]] !== undefined && existingUUID === null) {
                    var newModule = new _this._modules[modules[i]].prototype.constructor(module, newUUID, _this);
                    _this._currentModules.push(newModule);
                    newModule.init();
                }
                else if (_this._modules[modules[i]] === undefined) {
                    if (env_1.isDebug) {
                        console.log('%cUndefined Module: ' + ("%c" + modules[i]), 'color:#ff6e6e', 'color:#eee');
                    }
                }
            }
        });
    };
    /**
     * Get all elements on the screen using the `data-module` attribute.
     * If an element already has a UUID it's an element that survived the page transition.
     * Remove (and trigger destory()) any elements module in the current modules list that didn't survive the transition.
     */
    App.prototype.deleteModules = function () {
        var _this = this;
        var modules = Array.from(document.querySelectorAll('[data-module]'));
        var survivingModules = [];
        var deadModules = [];
        // Grab all modules that have a UUID attribute
        modules.forEach(function (module) {
            // If the module has a UUID the element survived the page transition
            if (module.getAttribute('data-uuid') !== null) {
                survivingModules.push(module);
            }
        });
        // Loop through all current modules
        this._currentModules.map(function (currModule) {
            var survived = false;
            // Loop through all surviving modules
            survivingModules.map(function (survivingModule) {
                // If the element with a UUID attribute matches the UUID of the current module don't remove the module
                if (survivingModule.getAttribute('data-uuid') === currModule.uuid) {
                    survived = true;
                }
            });
            // If the current module doesn't match up with any UUIDs avialable on the surviving elements mark the module for destruction
            if (!survived) {
                deadModules.push(currModule);
            }
        });
        // Verify we have modules to destroy
        if (deadModules.length) {
            // Loop though all the modules we need to destroy
            deadModules.map(function (deadModule) {
                // Loop through all the current modules
                for (var i = 0; i < _this._currentModules.length; i++) {
                    // Check if the currend modules UUID matches the UUID of our module marked for destruction
                    if (_this._currentModules[i].uuid === deadModule.uuid) {
                        // Trigger module destruction
                        _this._currentModules[i].destroy();
                        // Get the modules index in our current module array
                        var index = _this._currentModules.indexOf(_this._currentModules[i]);
                        // Splice the array at the index and shift the remaining modules
                        _this._currentModules.splice(index, 1);
                    }
                }
            });
        }
    };
    /**
     * Delete a module based on the modules UUID.
     * @param { string } uuid - provided by the `AbstractModule` class
     */
    App.prototype.deleteModule = function (uuid) {
        if (!uuid) {
            if (env_1.isDebug) {
                console.log('%cDelete Module Error: ' + '%cmodule UUID was not sent in the custom event', 'color:#ff6e6e', 'color:#eee');
            }
            return;
        }
        // Loop through all the current modules
        for (var i = 0; i < this._currentModules.length; i++) {
            // Check if the current modules UUID matches the UUID of the module we're destroying
            if (this._currentModules[i].uuid === uuid) {
                // Trigger module destruciton
                this._currentModules[i].destroy();
                // Get the modules index in our current module array
                var index = this._currentModules.indexOf(this._currentModules[i]);
                // Splice the array at the index and shift the remaining modules
                this._currentModules.splice(index, 1);
            }
        }
    };
    App.ANIMATION_DELAY = 1000;
    return App;
}());
exports.default = App;
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
var isDebug = true;
exports.isDebug = isDebug;
var html = document.documentElement;
exports.html = html;
var body = document.body;
exports.body = body;
var pjaxContainer = '.js-pjax-container';
exports.pjaxContainer = pjaxContainer;
var pjaxWrapper = '.js-pjax-wrapper';
exports.pjaxWrapper = pjaxWrapper;
var scrollTrigger = 100; // in pixels
exports.scrollTrigger = scrollTrigger;
var easing = {
    ease: 'cubicBezier(0.4, 0.0, 0.2, 1)',
    in: 'cubicBezier(0.0, 0.0, 0.2, 1)',
    out: 'cubicBezier(0.4, 0.0, 1, 1)',
    sharp: 'cubicBezier(0.4, 0.0, 0.6, 1)'
};
exports.easing = easing;
function setDebug(status) {
    exports.isDebug = isDebug = status;
}
exports.setDebug = setDebug;


/***/ }),

/***/ "./app/scripts/modules.ts":
/*!********************************!*\
  !*** ./app/scripts/modules.ts ***!
  \********************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
var BasicForm_1 = __webpack_require__(/*! ./modules/BasicForm */ "./app/scripts/modules/BasicForm.ts");
exports.BasicForm = BasicForm_1.default;
var BasicGallery_1 = __webpack_require__(/*! ./modules/BasicGallery */ "./app/scripts/modules/BasicGallery.ts");
exports.BasicGallery = BasicGallery_1.default;
var BasicAccordion_1 = __webpack_require__(/*! ./modules/BasicAccordion */ "./app/scripts/modules/BasicAccordion.ts");
exports.BasicAccordion = BasicAccordion_1.default;
var Freeform_1 = __webpack_require__(/*! ./modules/Freeform */ "./app/scripts/modules/Freeform.ts");
exports.Freeform = Freeform_1.default;


/***/ }),

/***/ "./app/scripts/modules/AbstractModule.ts":
/*!***********************************************!*\
  !*** ./app/scripts/modules/AbstractModule.ts ***!
  \***********************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
var AbstractModule = /** @class */ (function () {
    function AbstractModule(el, uuid, app) {
        this.el = el;
        this.uuid = uuid;
        this._app = app;
        // Sets modules UUID to be used later when handling modules destruction
        this.el.setAttribute('data-uuid', this.uuid);
    }
    AbstractModule.prototype.init = function () {
    };
    /**
     * Acts as the modules self-destruct method, when called the module will be removed from the page
     * Used when removing a specific module, call is initiated by a module
     */
    AbstractModule.prototype.seppuku = function () {
        this._app.deleteModule(this.uuid);
    };
    /**
     * Called by a module, removes attribute and logs out destruction to the console
     * Used when the page transitions, call is initiated by applicaiton
     * You shouldn't call this method, if you need to remove a module use the `seppuku` method
     * @param {boolean} isDebug
     * @param {string} MODULE_NAME
     */
    AbstractModule.prototype.destroy = function (isDebug, MODULE_NAME) {
        this.el.removeAttribute('data-uuid');
        if (isDebug) {
            console.log('%c[module] ' + ("%cDestroying " + MODULE_NAME + " - " + this.uuid), 'color:#ff6e6e', 'color:#eee');
        }
    };
    return AbstractModule;
}());
exports.default = AbstractModule;


/***/ }),

/***/ "./app/scripts/modules/BasicAccordion.ts":
/*!***********************************************!*\
  !*** ./app/scripts/modules/BasicAccordion.ts ***!
  \***********************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

var __extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
var env_1 = __webpack_require__(/*! ../env */ "./app/scripts/env.ts");
var AbstractModule_1 = __importDefault(__webpack_require__(/*! ./AbstractModule */ "./app/scripts/modules/AbstractModule.ts"));
var animejs_1 = __importDefault(__webpack_require__(/*! animejs */ "./node_modules/animejs/lib/anime.es.js"));
var BasicAccordion = /** @class */ (function (_super) {
    __extends(BasicAccordion, _super);
    function BasicAccordion(el, uuid, app) {
        var _this = _super.call(this, el, uuid, app) || this;
        if (env_1.isDebug) {
            console.log('%c[module] ' + ("%cBuilding: " + BasicAccordion.MODULE_NAME + " - " + _this.uuid), 'color:#4688f2', 'color:#eee');
        }
        _this._rows = Array.from(_this.el.querySelectorAll('.js-row'));
        _this._headlines = [];
        _this._multiRow = (_this.el.getAttribute('data-single-open') === 'true') ? true : false;
        return _this;
    }
    /**
     * Called when the module is created
     * Used to call any initial methods or to
     * register any initial event listeners
     */
    BasicAccordion.prototype.init = function () {
        var _this = this;
        this._rows.map(function (el) {
            var headline = el.querySelector('.js-headline');
            headline.addEventListener('click', function (e) { return _this.handleToggle(e); });
            _this._headlines.push(headline);
        });
    };
    BasicAccordion.prototype.closeRows = function (rowToClose) {
        if (rowToClose === null)
            return;
        rowToClose.classList.remove('is-open');
        var body = rowToClose.querySelector('.js-body');
        var bodyEls = Array.from(body.querySelectorAll('*'));
        animejs_1.default({
            targets: body,
            duration: 300,
            easing: env_1.easing.out,
            height: [body.scrollHeight + "px", 0]
        });
        // Hide children
        animejs_1.default({
            targets: bodyEls,
            duration: 75,
            easing: env_1.easing.out,
            opacity: [1, 0]
        });
    };
    BasicAccordion.prototype.handleToggle = function (e) {
        e.preventDefault();
        var target = e.currentTarget;
        var row = target.parentElement;
        var body = row.querySelector('.js-body');
        var bodyEls = Array.from(body.querySelectorAll('*'));
        if (row.classList.contains('is-open')) {
            row.classList.remove('is-open');
            // Close row
            animejs_1.default({
                targets: body,
                duration: 300,
                easing: env_1.easing.out,
                height: [body.scrollHeight + "px", 0]
            });
            // Hide children
            animejs_1.default({
                targets: bodyEls,
                duration: 75,
                easing: env_1.easing.out,
                opacity: [1, 0]
            });
        }
        else {
            if (!this._multiRow) {
                var oldRow = this.el.querySelector('.js-row.is-open');
                this.closeRows(oldRow);
            }
            row.classList.add('is-open');
            // Open row
            animejs_1.default({
                targets: body,
                duration: 300,
                easing: env_1.easing.in,
                height: [0, body.scrollHeight + "px"],
            });
            // Show children
            animejs_1.default({
                targets: bodyEls,
                duration: 150,
                easing: env_1.easing.out,
                delay: function (el, i) {
                    return i * 75 + 150;
                },
                opacity: [0, 1]
            });
        }
    };
    /**
     * Called when the module is destroyed
     * Remove all event listners before calling super.destory()
     */
    BasicAccordion.prototype.destroy = function () {
        _super.prototype.destroy.call(this, env_1.isDebug, BasicAccordion.MODULE_NAME);
    };
    BasicAccordion.MODULE_NAME = 'BasicAccordion';
    return BasicAccordion;
}(AbstractModule_1.default));
exports.default = BasicAccordion;


/***/ }),

/***/ "./app/scripts/modules/BasicForm.ts":
/*!******************************************!*\
  !*** ./app/scripts/modules/BasicForm.ts ***!
  \******************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

var __extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
var env_1 = __webpack_require__(/*! ../env */ "./app/scripts/env.ts");
var AbstractModule_1 = __importDefault(__webpack_require__(/*! ./AbstractModule */ "./app/scripts/modules/AbstractModule.ts"));
var BasicForm = /** @class */ (function (_super) {
    __extends(BasicForm, _super);
    function BasicForm(el, uuid, app) {
        var _this = _super.call(this, el, uuid, app) || this;
        if (env_1.isDebug)
            console.log('%c[module] ' + ("%cBuilding: " + BasicForm.MODULE_NAME + " - " + _this.uuid), 'color:#4688f2', 'color:#eee');
        // Elements
        _this._inputs = Array.from(_this.el.querySelectorAll('.js-input input'));
        _this._passwordInputs = Array.from(_this.el.querySelectorAll('.js-password-checker input'));
        _this._selects = Array.from(_this.el.querySelectorAll('.js-select select'));
        _this._textareas = Array.from(_this.el.querySelectorAll('.js-textarea textarea'));
        _this._passwordToggles = Array.from(_this.el.querySelectorAll('.js-password-toggle'));
        _this._switches = Array.from(_this.el.querySelectorAll('.js-switch input'));
        return _this;
    }
    /**
     * Called when the module is created.
     */
    BasicForm.prototype.init = function () {
        var _this = this;
        this._inputs.forEach(function (el) { el.addEventListener('focus', function (e) { return _this.handleInput(e); }); });
        this._inputs.forEach(function (el) { el.addEventListener('blur', function (e) { return _this.handleInput(e); }); });
        this._inputs.forEach(function (el) { el.addEventListener('keyup', function (e) { return _this.handleInput(e); }); });
        this._passwordInputs.forEach(function (el) { el.addEventListener('focus', function (e) { return _this.handlePasswordInput(e); }); });
        this._passwordInputs.forEach(function (el) { el.addEventListener('blur', function (e) { return _this.handlePasswordInput(e); }); });
        this._passwordInputs.forEach(function (el) { el.addEventListener('keyup', function (e) { return _this.handlePasswordInput(e); }); });
        this._selects.forEach(function (el) { el.addEventListener('focus', function (e) { return _this.handleSelect(e); }); });
        this._selects.forEach(function (el) { el.addEventListener('blur', function (e) { return _this.handleSelect(e); }); });
        this._selects.forEach(function (el) { el.addEventListener('change', function (e) { return _this.handleSelect(e); }); });
        this._textareas.forEach(function (el) { el.addEventListener('keyup', function (e) { return _this.handleTextarea(e); }); });
        this._textareas.forEach(function (el) { el.addEventListener('blur', function (e) { return _this.handleTextarea(e); }); });
        this._passwordToggles.forEach(function (el) { el.addEventListener('click', function (e) { return _this.handleToggle(e); }); });
        this._switches.forEach(function (el) { el.addEventListener('change', function (e) { return _this.handleSwitch(e); }); });
        // Handle input status for prefilled elements
        this._inputs.forEach(function (el) {
            if (el.value !== '') {
                var parent_1 = el.parentElement;
                parent_1.classList.add('has-value');
            }
        });
        // Handle input status for select elements
        this._selects.forEach(function (el) {
            if (el.value !== 'any') {
                var inputWrapper = el.parentElement;
                inputWrapper.classList.add('has-value');
            }
        });
    };
    /**
     * Called when the user interacts with a `textarea` element
     * @param { Event } e
     */
    BasicForm.prototype.handleTextarea = function (e) {
        var target = e.currentTarget;
        var parent = target.parentElement;
        if (e.type === 'blur') {
            // Check if the textarea is valid
            if (target.validity.valid) {
                parent.classList.add('is-valid');
                parent.classList.remove('is-invalid');
            }
            else {
                parent.classList.remove('is-valid');
                parent.classList.add('is-invalid');
                var errorEl = parent.querySelector('.js-error');
                if (errorEl) {
                    errorEl.innerHTML = target.validationMessage;
                }
            }
            if (target.value !== '') {
                parent.classList.add('has-value');
            }
            else {
                parent.classList.remove('has-value');
            }
        }
        else if (e.type === 'keyup') {
            // Only run valditiy check on `keyup` if the input has already been marked as invalid
            if (parent.classList.contains('is-invalid')) {
                // Check if the input is valid
                if (target.validity.valid) {
                    parent.classList.add('is-valid');
                    parent.classList.remove('is-invalid');
                }
                else {
                    parent.classList.remove('is-valid');
                    parent.classList.add('is-invalid');
                }
            }
        }
    };
    /**
     * Called when the user interacts with a `select` element.
     * @param { Event } e
     */
    BasicForm.prototype.handleSelect = function (e) {
        var target = e.currentTarget;
        var parent = target.parentElement;
        var isRequried = (target.getAttribute('required') === null) ? false : true;
        // Handle custom focus and blur status
        if (e.type === 'focus') {
            parent.classList.add('has-focus');
        }
        else if (e.type === 'blur') {
            parent.classList.remove('has-focus');
            if (isRequried && target.value === 'any') {
                parent.classList.add('is-invalid');
                parent.classList.remove('is-valid');
                var errorEl = parent.querySelector('.js-error');
                if (errorEl) {
                    errorEl.innerHTML = 'Please fill out this field.';
                }
            }
            else {
                parent.classList.remove('is-invalid');
                parent.classList.add('is-valid');
            }
        }
        else if (e.type === 'change') {
            if (isRequried && target.value === 'any') {
                parent.classList.add('is-invalid');
                parent.classList.remove('is-valid');
                var errorEl = parent.querySelector('.js-error');
                if (errorEl) {
                    errorEl.innerHTML = 'Please fill out this field.';
                }
            }
            else {
                parent.classList.remove('is-invalid');
                parent.classList.add('is-valid');
            }
        }
        // Set the `has-value` status class
        if (target.value !== 'any') {
            parent.classList.add('has-value');
        }
        else {
            parent.classList.remove('has-value');
        }
    };
    /**
     * Called by the `validateInput` method.
     * Handles the status classes for `input` elements.
     * @param { HTMLInputElement } target - the `input` element
     * @param { Element } parent - the `input` elements wrapper
     * @param { HTMLInputElement } relatedEl - optional companion element
     */
    BasicForm.prototype.checkForValidInput = function (target, parent, relatedEl) {
        if (relatedEl === void 0) { relatedEl = null; }
        var isValid = true;
        if (relatedEl) {
            if (relatedEl.value !== target.value && parent.classList.contains('js-password-checker')) {
                isValid = false;
            }
            else if (relatedEl.value === target.value) {
                relatedEl.parentElement.classList.add('is-valid');
                relatedEl.parentElement.classList.remove('is-invalid');
            }
        }
        if (!target.validity.valid) {
            isValid = false;
        }
        if (isValid) {
            parent.classList.add('is-valid');
            parent.classList.remove('is-invalid');
        }
        else {
            parent.classList.remove('is-valid');
            parent.classList.add('is-invalid');
            var errorEl = parent.querySelector('.js-error');
            if (errorEl) {
                if (!target.validity.valid) {
                    errorEl.innerHTML = target.validationMessage;
                }
                else {
                    errorEl.innerHTML = 'Passwords don\'t match.';
                }
            }
        }
        // Check if the input has a value
        if (target.value !== '') {
            parent.classList.add('has-value');
        }
        else {
            parent.classList.remove('has-value');
        }
    };
    /**
     * Called when we need to validate a `input` element after the user interacted with it.
     * @param { string } eventType - `Event.type` string
     * @param { HTMLInputElement } target - the `input` element the user interacted with
     * @param { Element } parent - the `input` elements wrapper
     * @param { HTMLInputElement } relatedEl - optional companion element
     */
    BasicForm.prototype.validateInput = function (eventType, target, parent, relatedEl) {
        if (relatedEl === void 0) { relatedEl = null; }
        if (eventType === 'focus') {
            parent.classList.add('has-focus');
        }
        else if (eventType === 'blur') {
            parent.classList.remove('has-focus');
            target.setAttribute('data-touched', 'true');
            this.checkForValidInput(target, parent, relatedEl);
        }
        else if (eventType === 'keyup' && target.getAttribute('data-touched') !== null) {
            this.checkForValidInput(target, parent, relatedEl);
        }
    };
    /**
     * Called when the user interacts with a `input` that is labeled as a password checker.
     * @param { Event } e
     */
    BasicForm.prototype.handlePasswordInput = function (e) {
        var target = e.currentTarget;
        var parent = target.parentElement;
        var forEl = this.el.querySelector(".js-password input[name=\"" + parent.getAttribute('data-for') + "\"]");
        // Make sure the input has it's password field companion
        if (!forEl) {
            if (env_1.isDebug) {
                console.log('%cUndefined Password Element: ' + ("%c" + parent.getAttribute('data-for')), 'color:#ff6e6e', 'color:#eee');
            }
        }
        else {
            this.validateInput(e.type, target, parent, forEl);
        }
    };
    /**
     * Called when the user interacts with a `input` element.
     * Not called on `checkbox` or `radio` input types.
     * @param { Event } e
     */
    BasicForm.prototype.handleInput = function (e) {
        var target = e.currentTarget;
        var parent = target.parentElement;
        // If the input is a password get the password checker companion element
        if (parent.classList.contains('js-password')) {
            var checkerInput = this.el.querySelector(".js-password-checker input[name=\"" + target.getAttribute('name') + "-check\"]");
            this.validateInput(e.type, target, parent, checkerInput);
        }
        else {
            this.validateInput(e.type, target, parent);
        }
    };
    /**
     * Called when a switch input is toggled.
     * @param { Event } e
     */
    BasicForm.prototype.handleSwitch = function (e) {
        var el = e.currentTarget;
        var inputWrapper = el.parentElement;
        var parent = inputWrapper.parentElement;
        parent.classList.remove('is-valid', 'is-invalid');
        if (el.validity.valid) {
            parent.classList.add('is-valid');
        }
        else {
            parent.classList.add('is-invalid');
            var errorObject = inputWrapper.querySelector('.js-error');
            if (errorObject) {
                errorObject.innerHTML = el.validationMessage;
            }
        }
    };
    /**
     * Called when the user clicks on the show/hide password icon.
     * @param  { Event } e
     */
    BasicForm.prototype.handleToggle = function (e) {
        var target = e.currentTarget;
        var inputWrapper = target.parentElement;
        var input = inputWrapper.querySelector('input');
        if (inputWrapper.classList.contains('has-content-hidden')) {
            inputWrapper.classList.remove('has-content-hidden');
            inputWrapper.classList.add('has-content-visible');
            input.setAttribute('type', 'text');
        }
        else {
            inputWrapper.classList.add('has-content-hidden');
            inputWrapper.classList.remove('has-content-visible');
            input.setAttribute('type', 'password');
        }
    };
    BasicForm.prototype.destroy = function () {
        _super.prototype.destroy.call(this, env_1.isDebug, BasicForm.MODULE_NAME);
    };
    BasicForm.MODULE_NAME = 'BasicForm';
    return BasicForm;
}(AbstractModule_1.default));
exports.default = BasicForm;


/***/ }),

/***/ "./app/scripts/modules/BasicGallery.ts":
/*!*********************************************!*\
  !*** ./app/scripts/modules/BasicGallery.ts ***!
  \*********************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

var __extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
var env_1 = __webpack_require__(/*! ../env */ "./app/scripts/env.ts");
var AbstractModule_1 = __importDefault(__webpack_require__(/*! ./AbstractModule */ "./app/scripts/modules/AbstractModule.ts"));
var animejs_1 = __importDefault(__webpack_require__(/*! animejs */ "./node_modules/animejs/lib/anime.es.js"));
var getParent_1 = __webpack_require__(/*! ../utils/getParent */ "./app/scripts/utils/getParent.ts");
var BasicGallery = /** @class */ (function (_super) {
    __extends(BasicGallery, _super);
    function BasicGallery(el, uuid, app) {
        var _this = _super.call(this, el, uuid, app) || this;
        if (env_1.isDebug)
            console.log('%c[module] ' + ("%cBuilding: " + BasicGallery.MODULE_NAME + " - " + _this.uuid), 'color:#4688f2', 'color:#eee');
        // CMS Input Data
        _this.style = _this.el.getAttribute('data-style');
        _this.timing = parseInt(_this.el.getAttribute('data-timing'));
        // NodeLists
        _this.slides = _this.el.querySelectorAll('.js-slide');
        _this.actionsEls = _this.el.querySelectorAll('.js-button');
        // Gallery Data
        _this.transition = 0.3;
        _this.counter = _this.timing;
        _this.time = null;
        _this.isDirty = false;
        _this.slideID = 0;
        return _this;
    }
    /**
     * Called when the module is created
     * Used to call any initial methods or to
     * register any initial event listeners
     */
    BasicGallery.prototype.init = function () {
        var _this = this;
        this.actionsEls.forEach(function (el) { el.addEventListener('click', function (e) { return _this.handleActionButton(e); }); });
        // Only start our loop if the gallery IS NOT set to manual transition
        if (this.timing !== -1) {
            this.time = Date.now();
            window.requestAnimationFrame(function () { return _this.callbackLoop(); });
        }
    };
    /**
     * Resets the counter and the galleries `isDirty` status.
     */
    BasicGallery.prototype.cleanGallery = function () {
        this.counter = this.timing;
        this.isDirty = false;
    };
    /**
     * This is the basic slide transition for the gallery.
     * Transitions are handled using animejs.
     * @see http://animejs.com/documentation/
     * @param { number } newSlideID What is the new slide ID
     * @param { number } currSlideID What is the current active slide ID
     * @param { number } direction What direction is the gallery going
     */
    BasicGallery.prototype.handleSlideTransition = function (newSlideID, currSlideID, direction) {
        var _this = this;
        var currSlide = this.slides[currSlideID];
        var newSlide = this.slides[newSlideID];
        // Hide slide
        animejs_1.default({
            targets: currSlide,
            duration: (this.transition * 1000),
            easing: env_1.easing.ease,
            translateX: [0, 100 * -direction + "%"]
        });
        // Show slide
        animejs_1.default({
            targets: newSlide,
            duration: (this.transition * 1000),
            easing: env_1.easing.ease,
            translateX: [100 * direction + "%", 0],
            complete: function () {
                _this.cleanGallery();
            }
        });
    };
    /**
     * This is the basic fade transition for the gallery.
     * Transitions are handled using animejs.
     * @see http://animejs.com/documentation/
     * @param { number } newSlideID What is the new slide ID
     * @param { number } currSlideID What is the current active slide ID
     */
    BasicGallery.prototype.handleFadeTransition = function (newSlideID, currSlideID) {
        var _this = this;
        var currSlide = this.slides[currSlideID];
        var newSlide = this.slides[newSlideID];
        // Hide slide
        animejs_1.default({
            targets: currSlide,
            duration: (this.transition * 1000),
            easing: env_1.easing.ease,
            opacity: [1, 0],
            zIndex: 1
        });
        // Show slide
        animejs_1.default({
            targets: newSlide,
            duration: (this.transition * 1000),
            easing: env_1.easing.ease,
            opacity: [0, 1],
            zIndex: 2,
            complete: function () {
                _this.cleanGallery();
            }
        });
    };
    /**
     * This is the basic stack transition for the gallery.
     * Transitions are handled using animejs.
     * @see http://animejs.com/documentation/
     * @param { number } newSlideID The array index value of our new slide
     * @param { number } currSlideID The array index value of the current slide
     * @param { number } direction What direciton we should transition
     */
    BasicGallery.prototype.handleStackTransition = function (newSlideID, currSlideID, direction) {
        var _this = this;
        var currSlide = this.slides[currSlideID];
        var newSlide = this.slides[newSlideID];
        var slideEl = currSlide;
        slideEl.style.zIndex = '1';
        var newEl = newSlide;
        newEl.style.zIndex = '5';
        // Show slide
        animejs_1.default({
            targets: newSlide,
            duration: (this.transition * 1000),
            easing: env_1.easing.ease,
            translateX: [100 * direction + "%", 0],
            complete: function () {
                // Hide slide
                animejs_1.default({
                    targets: currSlide,
                    duration: 100,
                    translateX: "100%",
                    complete: function () {
                        _this.cleanGallery();
                    }
                });
            }
        });
    };
    /**
     * This is the basic parallax transition for the gallery.
     * Transitions are handled using animejs.
     * @see http://animejs.com/documentation/
     * @param { number } newSlideID The array index value of our new slide
     * @param { number } currSlideID The array index value of the current slide
     * @param { number } direction What direciton we should transition
     */
    BasicGallery.prototype.handleParallaxTransition = function (newSlideID, currSlideID, direction) {
        var _this = this;
        var currSlide = this.slides[currSlideID];
        var newSlide = this.slides[newSlideID];
        var currSlideImg = currSlide.querySelector('.js-img');
        var newSlideImg = newSlide.querySelector('.js-img');
        // Show slide
        animejs_1.default({
            targets: newSlide,
            duration: (this.transition * 2000),
            easing: env_1.easing.ease,
            translateX: [100 * direction + "%", 0],
        });
        // New Image
        animejs_1.default({
            targets: newSlideImg,
            duration: (this.transition * 2000),
            easing: env_1.easing.ease,
            translateX: [50 * -direction + "%", 0],
        });
        // Hide slide
        animejs_1.default({
            targets: currSlide,
            duration: (this.transition * 2000),
            easing: env_1.easing.ease,
            translateX: [0, 100 * -direction + "%"],
            complete: function () {
                _this.cleanGallery();
            }
        });
        // Old Image
        animejs_1.default({
            targets: currSlideImg,
            duration: (this.transition * 2000),
            easing: env_1.easing.ease,
            translateX: [0, 50 * direction + "%"],
        });
    };
    /**
     * Handles switching slides.
     * First we get our current slide ID.
     * Then we set our new slide ID based on the current slide ID and the direction we're heading.
     * Then we handle the edges of the array to loop our new slide ID.
     * We set `isDirty` to true to prevent additional transitions from triggering along with user input.
     * Use the switch to handle the different gallery transition types.
     * Finally we set our `slideID` variable to the value of our `newSlideID`.
     * @param { number } direction Decides what direction in the slides array is the gallery going. Default value is `1`.
     */
    BasicGallery.prototype.switchSlides = function (direction) {
        if (direction === void 0) { direction = 1; }
        var currSlideID = this.slideID;
        var newSlideID = this.slideID + direction;
        if (newSlideID < 0)
            newSlideID = this.slides.length - 1;
        else if (newSlideID >= this.slides.length)
            newSlideID = 0;
        this.isDirty = true;
        switch (this.style) {
            case 'fade':
                this.handleFadeTransition(newSlideID, currSlideID);
                break;
            case 'slide':
                this.handleSlideTransition(newSlideID, currSlideID, direction);
                break;
            case 'stack':
                this.handleStackTransition(newSlideID, currSlideID, direction);
                break;
            case 'parallax':
                this.handleParallaxTransition(newSlideID, currSlideID, direction);
                break;
        }
        this.slideID = newSlideID;
    };
    /**
     * This is the callback loop for the `requestAnimationFrame`.
     * It is called along with the DOM's repaint call.
     * We calculate `deltaTime` by comparing the differences inbetween the callbacks.
     * If the gallery is not dirty subtract `deltaTime` from `this.counter`.
     * If the DOM has the users focus and they gallery is out of time and it's not already dirty
     * handle the slide switch.
     * Finally we pass our callback method back into `reqeustAnimationFrame` to be called again.
     * @see https://developer.mozilla.org/en-US/docs/Web/API/window/requestAnimationFrame
     */
    BasicGallery.prototype.callbackLoop = function () {
        var _this = this;
        var timeNew = Date.now();
        var deltaTime = (timeNew - this.time) / 1000;
        this.time = timeNew;
        if (!this.isDirty)
            this.counter -= deltaTime;
        if (document.hasFocus()) {
            if (this.counter <= 0 && !this.isDirty)
                this.switchSlides(1);
        }
        window.requestAnimationFrame(function () { return _this.callbackLoop(); });
    };
    /**
     * This method handles our aciton buttons click events.
     * When a user clicks on a button we find our actual button using `getParent`.
     * Once we have our button element we grab the direciton of the button.
     * Then we call the switch slides method and pass along the desired direciton.
     * @param { Event } e Event fired when a user clicks our galleries action buttons
     */
    BasicGallery.prototype.handleActionButton = function (e) {
        if (e.target instanceof Element) {
            var button = getParent_1.getParent(e.target, 'js-button');
            var direction = parseInt(button.getAttribute('data-direction'));
            if (!this.isDirty)
                this.switchSlides(direction);
        }
    };
    /**
     * Called when the module is destroyed
     * Remove all event listners before calling super.destory()
     */
    BasicGallery.prototype.destroy = function () {
        var _this = this;
        this.actionsEls.forEach(function (el) { el.removeEventListener('click', function (e) { return _this.handleActionButton(e); }); });
        this.callbackLoop = function () { };
        _super.prototype.destroy.call(this, env_1.isDebug, BasicGallery.MODULE_NAME);
    };
    BasicGallery.MODULE_NAME = 'BasicGallery';
    return BasicGallery;
}(AbstractModule_1.default));
exports.default = BasicGallery;


/***/ }),

/***/ "./app/scripts/modules/Freeform.ts":
/*!*****************************************!*\
  !*** ./app/scripts/modules/Freeform.ts ***!
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
    };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
var env_1 = __webpack_require__(/*! ../env */ "./app/scripts/env.ts");
var AbstractModule_1 = __importDefault(__webpack_require__(/*! ./AbstractModule */ "./app/scripts/modules/AbstractModule.ts"));
var animejs_1 = __importDefault(__webpack_require__(/*! animejs */ "./node_modules/animejs/lib/anime.es.js"));
var Freeform = /** @class */ (function (_super) {
    __extends(Freeform, _super);
    function Freeform(el, uuid, app) {
        var _this = _super.call(this, el, uuid, app) || this;
        _this.handleTabInput = function (e) {
            var target = e.currentTarget;
            if (target.classList.contains('has-seen')) {
                _this.switchPage(parseInt(target.getAttribute('data-page')));
            }
        };
        _this.validatePage = function () {
            _this.handleValidation();
        };
        _this.resetForm = function () {
            animejs_1.default({
                targets: _this._success,
                duration: 150,
                opacity: [1, 0],
                easing: env_1.easing.sharp,
                complete: function () {
                    _this._form.reset();
                    _this._success.classList.remove('is-visible');
                    _this._pages.forEach(function (el) { el.classList.remove('is-active-page'); });
                    _this._tabs.forEach(function (el) { el.classList.remove('is-active-page'); });
                    _this._active = 0;
                    _this._pages[_this._active].classList.add('is-active-page');
                    _this._tabs[_this._active].classList.add('is-active-page');
                    _this.removeEvents();
                    var rows = Array.from(_this._pages[_this._active].querySelectorAll('.js-row'));
                    animejs_1.default({
                        targets: rows,
                        opacity: [0, 1],
                        translateY: ['25px', 0],
                        duration: 150,
                        easing: env_1.easing.in,
                        delay: animejs_1.default.stagger(35),
                        complete: function () {
                            _this.getPageElements();
                            _this.addEvents();
                            _this.handleValidation();
                        }
                    });
                    if (_this._tabWrapper) {
                        animejs_1.default({
                            targets: _this._tabWrapper,
                            opacity: [0, 1],
                            duration: 150,
                            easing: env_1.easing.in
                        });
                    }
                }
            });
        };
        _this.checkButton = function (e) {
            e.preventDefault();
            e.stopImmediatePropagation();
            var target = e.currentTarget;
            var type = target.getAttribute('data-type');
            if (type === 'back') {
                _this.switchPage(_this._active - 1);
                return;
            }
            if (_this.hardValidation()) {
                if (type === 'next') {
                    _this.switchPage(_this._active + 1);
                }
                else if (type === 'submit') {
                    _this.submitForm();
                }
            }
        };
        if (env_1.isDebug) {
            console.log('%c[module] ' + ("%cBuilding: " + Freeform.MODULE_NAME + " - " + _this.uuid), 'color:#4688f2', 'color:#eee');
        }
        // Form Elements
        _this._inputs = null;
        _this._passwords = null;
        _this._textareas = null;
        _this._selects = null;
        _this._switches = null;
        // General Elements
        _this._tabs = Array.from(_this.el.querySelectorAll('.js-tab'));
        _this._pages = Array.from(_this.el.querySelectorAll('.js-page'));
        _this._backButton = null;
        _this._nextButton = null;
        _this._submitButton = null;
        _this._spinner = _this.el.querySelector('.js-spinner');
        _this._success = _this.el.querySelector('.js-success');
        _this._resetButton = _this.el.querySelector('.js-reset');
        _this._form = _this.el.querySelector('form');
        _this._tabWrapper = _this.el.querySelector('.js-tabs');
        // Variables
        _this._active = 0;
        return _this;
    }
    /**
     * Called when the module is created
     * Used to call any initial methods or to
     * register any initial event listeners
     */
    Freeform.prototype.init = function () {
        var _this = this;
        this.getPageElements();
        this.addEvents();
        this.handleValidation();
        // this._resetButton.addEventListener('click', this.resetForm );
        this._tabs.forEach(function (el) {
            el.addEventListener('click', _this.handleTabInput);
        });
    };
    Freeform.prototype.getPageElements = function () {
        this._inputs = Array.from(this._pages[this._active].querySelectorAll('.js-input input[required]'));
        this._passwords = Array.from(this._pages[this._active].querySelectorAll('.js-password-checker input[required]'));
        this._textareas = Array.from(this._pages[this._active].querySelectorAll('.js-textarea textarea[required]'));
        this._selects = Array.from(this._pages[this._active].querySelectorAll('.js-select select[required]'));
        this._switches = Array.from(this._pages[this._active].querySelectorAll('.js-switch input[required]'));
        this._nextButton = this._pages[this._active].querySelector('.js-next-button');
        this._backButton = this._pages[this._active].querySelector('.js-back-button');
        this._submitButton = this._pages[this._active].querySelector('.js-submit-button');
    };
    Freeform.prototype.removeEvents = function () {
        var _this = this;
        this._inputs.forEach(function (el) { el.removeEventListener('blur', _this.validatePage); });
        this._inputs.forEach(function (el) { el.removeEventListener('keyup', _this.validatePage); });
        this._inputs.forEach(function (el) { el.removeEventListener('change', _this.validatePage); });
        this._passwords.forEach(function (el) { el.removeEventListener('blur', _this.validatePage); });
        this._passwords.forEach(function (el) { el.removeEventListener('keyup', _this.validatePage); });
        this._passwords.forEach(function (el) { el.removeEventListener('change', _this.validatePage); });
        this._textareas.forEach(function (el) { el.removeEventListener('keyup', _this.validatePage); });
        this._textareas.forEach(function (el) { el.removeEventListener('blur', _this.validatePage); });
        this._selects.forEach(function (el) { el.removeEventListener('change', _this.validatePage); });
        this._switches.forEach(function (el) { el.removeEventListener('change', _this.validatePage); });
        if (this._nextButton) {
            this._nextButton.removeEventListener('click', this.checkButton);
        }
        if (this._backButton) {
            this._backButton.removeEventListener('click', this.checkButton);
        }
        if (this._submitButton) {
            this._submitButton.removeEventListener('click', this.checkButton);
        }
    };
    Freeform.prototype.addEvents = function () {
        var _this = this;
        this._inputs.forEach(function (el) { el.addEventListener('blur', _this.validatePage); });
        this._inputs.forEach(function (el) { el.addEventListener('keyup', _this.validatePage); });
        this._inputs.forEach(function (el) { el.addEventListener('change', _this.validatePage); });
        this._passwords.forEach(function (el) { el.addEventListener('blur', _this.validatePage); });
        this._passwords.forEach(function (el) { el.addEventListener('keyup', _this.validatePage); });
        this._passwords.forEach(function (el) { el.addEventListener('change', _this.validatePage); });
        this._textareas.forEach(function (el) { el.addEventListener('keyup', _this.validatePage); });
        this._textareas.forEach(function (el) { el.addEventListener('blur', _this.validatePage); });
        this._selects.forEach(function (el) { el.addEventListener('change', _this.validatePage); });
        this._switches.forEach(function (el) { el.addEventListener('change', _this.validatePage); });
        if (this._nextButton) {
            this._nextButton.addEventListener('click', this.checkButton);
        }
        if (this._backButton) {
            this._backButton.addEventListener('click', this.checkButton);
        }
        if (this._submitButton) {
            this._submitButton.addEventListener('click', this.checkButton);
        }
    };
    Freeform.prototype.hardValidation = function () {
        var _this = this;
        var passedAllValidation = true;
        this._inputs.forEach(function (el) {
            var parent = el.parentElement;
            el.setAttribute('data-touched', 'true');
            if (el.validity.valid) {
                parent.classList.add('is-valid');
                parent.classList.remove('is-invalid');
            }
            else {
                parent.classList.remove('is-valid');
                parent.classList.add('is-invalid');
                passedAllValidation = false;
                var errorEl = parent.querySelector('.js-error');
                if (errorEl) {
                    errorEl.innerHTML = el.validationMessage;
                }
            }
        });
        this._selects.forEach(function (el) {
            var parent = el.parentElement;
            var isRequried = (el.getAttribute('required') === null) ? false : true;
            if (isRequried && el.value === 'any') {
                parent.classList.add('is-invalid');
                parent.classList.remove('is-valid');
                passedAllValidation = false;
                var errorEl = parent.querySelector('.js-error');
                if (errorEl) {
                    errorEl.innerHTML = 'Please fill out this field.';
                }
            }
            else {
                parent.classList.remove('is-invalid');
                parent.classList.add('is-valid');
            }
        });
        this._textareas.forEach(function (el) {
            var parent = el.parentElement;
            el.setAttribute('data-touched', 'true');
            if (el.validity.valid) {
                parent.classList.add('is-valid');
                parent.classList.remove('is-invalid');
            }
            else {
                parent.classList.remove('is-valid');
                parent.classList.add('is-invalid');
                passedAllValidation = false;
                var errorEl = parent.querySelector('.js-error');
                if (errorEl) {
                    errorEl.innerHTML = el.validationMessage;
                }
            }
        });
        this._switches.forEach(function (el) {
            var inputWrapper = el.parentElement;
            var parent = inputWrapper.parentElement;
            parent.classList.remove('is-valid', 'is-invalid');
            if (el.validity.valid) {
                parent.classList.add('is-valid');
            }
            else {
                parent.classList.add('is-invalid');
                passedAllValidation = false;
                var errorObject = inputWrapper.querySelector('.js-error');
                if (errorObject) {
                    errorObject.innerHTML = el.validationMessage;
                }
            }
        });
        this._passwords.forEach(function (el) {
            var parent = el.parentElement;
            var forEl = _this._pages[_this._active].querySelector(".js-password input[name=\"" + parent.getAttribute('data-for') + "\"]");
            el.setAttribute('data-touched', 'true');
            parent.classList.remove('is-valid', 'is-invalid');
            if (el.validity.valid && forEl.value === el.value) {
                parent.classList.add('is-valid');
            }
            else {
                parent.classList.add('is-invalid');
                passedAllValidation = false;
                var errorEl = parent.querySelector('.js-error');
                if (errorEl) {
                    if (!el.validity.valid) {
                        errorEl.innerHTML = el.validationMessage;
                    }
                    else {
                        errorEl.innerHTML = 'Passwords don\'t match.';
                    }
                }
            }
        });
        return passedAllValidation;
    };
    Freeform.prototype.getValidation = function () {
        var _this = this;
        var isValid = true;
        this._inputs.forEach(function (el) {
            if (!el.validity.valid || el.value === '') {
                isValid = false;
            }
        });
        if (isValid) {
            this._textareas.forEach(function (el) {
                if (!el.validity.valid || el.value === '') {
                    isValid = false;
                }
            });
        }
        if (isValid) {
            this._selects.forEach(function (el) {
                if (el.value === 'any') {
                    isValid = false;
                }
            });
        }
        if (isValid) {
            this._switches.forEach(function (el) {
                if (!el.validity.valid) {
                    isValid = false;
                }
            });
        }
        if (isValid) {
            this._passwords.forEach(function (el) {
                var parent = el.parentElement;
                var forEl = _this._pages[_this._active].querySelector(".js-password input[name=\"" + parent.getAttribute('data-for') + "\"]");
                if (!el.validity.valid || forEl.value !== el.value) {
                    isValid = false;
                }
            });
        }
        return isValid;
    };
    Freeform.prototype.handleValidation = function () {
        if (this.getValidation()) {
            if (this._nextButton) {
                this._nextButton.classList.remove('is-disabled');
            }
            if (this._submitButton) {
                this._submitButton.classList.remove('is-disabled');
            }
        }
        else {
            if (this._nextButton) {
                this._nextButton.classList.add('is-disabled');
            }
            if (this._submitButton) {
                this._submitButton.classList.add('is-disabled');
            }
        }
    };
    Freeform.prototype.ajustFormPosition = function () {
        var formOffset = this._form.getBoundingClientRect();
        var newScrollY = Math.round(window.scrollY + formOffset.top - (window.innerHeight * (Freeform.MOBILE_OFFSET / 100)));
        window.scroll(0, newScrollY);
    };
    Freeform.prototype.switchPage = function (newPageNumber) {
        var _this = this;
        var formOffset = this._form.getBoundingClientRect();
        if (formOffset.top < Math.round(window.innerHeight * (Freeform.MOBILE_OFFSET / 100))) {
            this.ajustFormPosition();
        }
        if (newPageNumber === this._active) {
            return;
        }
        if (!this.getValidation() && newPageNumber > this._active) {
            this.hardValidation();
            return;
        }
        var rows = Array.from(this._pages[this._active].querySelectorAll('.js-row'));
        animejs_1.default({
            targets: rows,
            opacity: [1, 0],
            translateY: [0, '-25px'],
            duration: 150,
            easing: env_1.easing.sharp,
            delay: animejs_1.default.stagger(35),
            complete: function () {
                _this.removeEvents();
                _this._pages[_this._active].classList.remove('is-active-page');
                _this._tabs[_this._active].classList.remove('is-active-page');
                _this._tabs[_this._active].classList.add('has-seen');
                _this._active = newPageNumber;
                _this._pages[_this._active].classList.add('is-active-page');
                _this._tabs[_this._active].classList.add('is-active-page');
                var newRows = Array.from(_this._pages[_this._active].querySelectorAll('.js-row'));
                animejs_1.default({
                    targets: newRows,
                    opacity: [0, 1],
                    translateY: ['25px', 0],
                    duration: 150,
                    easing: env_1.easing.in,
                    delay: animejs_1.default.stagger(35),
                    complete: function () {
                        _this.getPageElements();
                        _this.addEvents();
                        _this.handleValidation();
                    }
                });
            }
        });
    };
    Freeform.prototype.handleFreeformResponse = function (response) {
        var _this = this;
        if (env_1.isDebug) {
            console.log('%c[Freeform] ' + ("%cResponse Status: " + ((response.success) ? 'succcess' : 'failed')), 'color:#46f287', 'color:#eee');
            if (response.errors) {
                console.log(response);
            }
        }
        if (response.finished && response.success) {
            animejs_1.default({
                targets: this._spinner,
                opacity: [0, 1],
                duration: 150,
                easing: env_1.easing.out,
                complete: function () {
                    _this._spinner.classList.remove('is-visible');
                    _this._success.classList.add('is-visible');
                    animejs_1.default({
                        targets: _this._success,
                        duration: 150,
                        opacity: [0, 1],
                        easing: env_1.easing.in
                    });
                }
            });
        }
    };
    Freeform.prototype.submitForm = function () {
        var _this = this;
        var csrfToken = this._form.querySelector('input[name="CRAFT_CSRF_TOKEN"]');
        csrfToken.value = env_1.html.getAttribute('data-csrf');
        var data = new FormData(this._form);
        var method = this._form.getAttribute("method");
        var action = this._form.querySelector('input[name="action"]');
        var request = new XMLHttpRequest();
        request.open(method, window.location.origin + "/actions/" + action.value, true);
        request.setRequestHeader("Cache-Control", "no-cache");
        request.setRequestHeader("X-Requested-With", "XMLHttpRequest");
        request.setRequestHeader("HTTP_X_REQUESTED_WITH", "XMLHttpRequest");
        request.onload = function (e) {
            var request = e.currentTarget;
            var response = JSON.parse(request.responseText);
            _this.handleFreeformResponse(response);
        };
        request.send(data);
        var rows = Array.from(this._pages[this._active].querySelectorAll('.js-row'));
        if (this._tabWrapper) {
            animejs_1.default({
                targets: this._tabWrapper,
                opacity: [1, 0],
                duration: 150,
                easing: env_1.easing.sharp
            });
        }
        animejs_1.default({
            targets: rows,
            opacity: [1, 0],
            translateY: [0, '-25px'],
            duration: 150,
            easing: env_1.easing.sharp,
            delay: animejs_1.default.stagger(35),
            complete: function () {
                _this._pages[_this._active].classList.remove('is-active-page');
                _this._spinner.classList.add('is-visible');
                _this._form.style.display = 'none';
                animejs_1.default({
                    targets: _this._spinner,
                    duration: 300,
                    easing: env_1.easing.in,
                    opacity: [0, 1]
                });
            }
        });
    };
    Freeform.prototype.destroy = function () {
        _super.prototype.destroy.call(this, env_1.isDebug, Freeform.MODULE_NAME);
    };
    Freeform.MODULE_NAME = 'Freeform';
    Freeform.MOBILE_OFFSET = 5; // % of vertical viewport height
    return Freeform;
}(AbstractModule_1.default));
exports.default = Freeform;


/***/ }),

/***/ "./app/scripts/polyfill.ts":
/*!*********************************!*\
  !*** ./app/scripts/polyfill.ts ***!
  \*********************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

/* tslint:disable */
Object.defineProperty(exports, "__esModule", { value: true });
/**
 * Array.from() polyfill
 * Souce: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/from#Polyfill
 */
exports.default = (function () {
    if (!Array.from) {
        Array.from = (function () {
            var toStr = Object.prototype.toString;
            var isCallable = function (fn) {
                return typeof fn === 'function' || toStr.call(fn) === '[object Function]';
            };
            var toInteger = function (value) {
                var number = Number(value);
                if (isNaN(number)) {
                    return 0;
                }
                if (number === 0 || !isFinite(number)) {
                    return number;
                }
                return (number > 0 ? 1 : -1) * Math.floor(Math.abs(number));
            };
            var maxSafeInteger = Math.pow(2, 53) - 1;
            var toLength = function (value) {
                var len = toInteger(value);
                return Math.min(Math.max(len, 0), maxSafeInteger);
            };
            // The length property of the from method is 1.
            return function from(arrayLike) {
                // 1. Let C be the this value.
                var C = this;
                // 2. Let items be ToObject(arrayLike).
                var items = Object(arrayLike);
                // 3. ReturnIfAbrupt(items).
                if (arrayLike == null) {
                    throw new TypeError('Array.from requires an array-like object - not null or undefined');
                }
                // 4. If mapfn is undefined, then let mapping be false.
                var mapFn = arguments.length > 1 ? arguments[1] : void undefined;
                var T;
                if (typeof mapFn !== 'undefined') {
                    // 5. else
                    // 5. a If IsCallable(mapfn) is false, throw a TypeError exception.
                    if (!isCallable(mapFn)) {
                        throw new TypeError('Array.from: when provided, the second argument must be a function');
                    }
                    // 5. b. If thisArg was supplied, let T be thisArg; else let T be undefined.
                    if (arguments.length > 2) {
                        T = arguments[2];
                    }
                }
                // 10. Let lenValue be Get(items, "length").
                // 11. Let len be ToLength(lenValue).
                var len = toLength(items.length);
                // 13. If IsConstructor(C) is true, then
                // 13. a. Let A be the result of calling the [[Construct]] internal method
                // of C with an argument list containing the single item len.
                // 14. a. Else, Let A be ArrayCreate(len).
                var A = isCallable(C) ? Object(new C(len)) : new Array(len);
                // 16. Let k be 0.
                var k = 0;
                // 17. Repeat, while k < len… (also steps a - h)
                var kValue;
                while (k < len) {
                    kValue = items[k];
                    if (mapFn) {
                        A[k] = typeof T === 'undefined' ? mapFn(kValue, k) : mapFn.call(T, kValue, k);
                    }
                    else {
                        A[k] = kValue;
                    }
                    k += 1;
                }
                // 18. Let putStatus be Put(A, "length", len, true).
                A.length = len;
                // 20. Return A.
                return A;
            };
        }());
    }
});


/***/ }),

/***/ "./app/scripts/transitions/BaseTransition.ts":
/*!***************************************************!*\
  !*** ./app/scripts/transitions/BaseTransition.ts ***!
  \***************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
var BaseTransition = /** @class */ (function () {
    function BaseTransition() {
    }
    /**
     * Called by the TransitionManager when Pjax is switching pages
     * Used to start any custom page transition animaitons
     */
    BaseTransition.prototype.launch = function () {
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
    BaseTransition.prototype.launchFinished = function () {
        var e = new Event('pjax:continue');
        document.dispatchEvent(e);
    };
    /**
     * Call by the TransitionManager when Pjax has switched pages
     * Used to stop any custom page transition animations
     */
    BaseTransition.prototype.hide = function () {
        // Handle custom transition effects
    };
    return BaseTransition;
}());
exports.default = BaseTransition;


/***/ }),

/***/ "./app/scripts/transitions/TransitionManager.ts":
/*!******************************************************!*\
  !*** ./app/scripts/transitions/TransitionManager.ts ***!
  \******************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (Object.hasOwnProperty.call(mod, k)) result[k] = mod[k];
    result["default"] = mod;
    return result;
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
var env_1 = __webpack_require__(/*! ../env */ "./app/scripts/env.ts");
var transitions = __importStar(__webpack_require__(/*! ./transitions */ "./app/scripts/transitions/transitions.ts"));
var fuel_pjax_1 = __importDefault(__webpack_require__(/*! @codewithkyle/fuel-pjax */ "./node_modules/@codewithkyle/fuel-pjax/pjax.js"));
var App_1 = __importDefault(__webpack_require__(/*! ../App */ "./app/scripts/App.ts"));
var TransitionManager = /** @class */ (function () {
    function TransitionManager(app) {
        this._app = app;
        this._transitions = transitions;
        this._transition = null;
        this._pjax = new fuel_pjax_1.default({ debug: env_1.isDebug, selectors: ["" + env_1.pjaxContainer] });
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
        setTimeout(function () { env_1.html.classList.add('dom-is-animated'); }, App_1.default.ANIMATION_DELAY);
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
        this._transition = new this._transitions[transition].prototype.constructor();
        env_1.html.classList.remove('dom-is-loaded', 'dom-is-animated');
        env_1.html.classList.add('dom-is-loading');
        this._transition.launch();
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
        if (env_1.isDebug) {
            console.log('%c[view] ' + ("%cDisplaying: " + templateName), 'color:#ecc653', 'color:#eee');
        }
        env_1.html.classList.add('dom-is-loaded');
        env_1.html.classList.remove('dom-is-loading');
        setTimeout(function () { env_1.html.classList.add('dom-is-animated'); }, App_1.default.ANIMATION_DELAY);
        if (templateName === 'home') {
            env_1.html.classList.add('is-homepage');
        }
        else {
            env_1.html.classList.remove('is-homepage');
        }
        if (this._transition === null) {
            return;
        }
        // Tell our transition it can end the transition
        this._transition.hide();
        // Tell our main applicaiton it can init any new modules
        this._app.initModules();
        // Tell our main applicaiton it can delete any old modules
        this._app.deleteModules();
        // Reset for next transition
        this.reinit();
    };
    /**
     * Gets the first element with a `data-template` attribute.
     * If the element exists get the template name.
     * Return the templates name or our missing name value.
     * @returns string
     */
    TransitionManager.prototype.getTemplateName = function () {
        var templateName = 'MISSING_TEMPLATE_NAME';
        var templateEl = env_1.html.querySelector('[data-template]');
        if (templateEl) {
            templateName = templateEl.getAttribute('data-template');
        }
        return templateName;
    };
    /**
     * Called when we've finished our transition
     * Resets our transition object and the DOM's `data-transition` attribute
     */
    TransitionManager.prototype.reinit = function () {
        env_1.html.setAttribute('data-transition', '');
        this._transition = null;
        console.log('Transition renit');
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

/***/ "./app/scripts/utils/getParent.ts":
/*!****************************************!*\
  !*** ./app/scripts/utils/getParent.ts ***!
  \****************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
/**
 * Attempt to find the elements parent with the desired class
 * @param {Element} el starting element
 * @param {String} selector parent elements class
 * @returns parent or starting element
 */
function getParent(el, selector) {
    var parent = el;
    do {
        parent = parent.parentElement;
        if (parent.classList.contains(selector))
            return parent;
    } while (parent.parentElement !== null);
    return el;
}
exports.getParent = getParent;


/***/ }),

/***/ "./node_modules/@codewithkyle/fuel-pjax/lib/events/link-events.js":
/*!************************************************************************!*\
  !*** ./node_modules/@codewithkyle/fuel-pjax/lib/events/link-events.js ***!
  \************************************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
var on_1 = __webpack_require__(/*! ./on */ "./node_modules/@codewithkyle/fuel-pjax/lib/events/on.js");
var attrState = 'data-pjax-state';
var isDefaultPrevented = function (el, e) {
    var isPrevented = false;
    if (e.defaultPrevented)
        isPrevented = true;
    else if (el.getAttribute('prevent-pjax') !== null)
        isPrevented = true;
    else if (el.classList.contains('no-transition'))
        isPrevented = true;
    else if (el.getAttribute('download') !== null)
        isPrevented = true;
    else if (el.getAttribute('target') === '_blank')
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
    if (isDefaultPrevented(el, e)) {
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
    e.preventDefault();
    if (el.href === window.location.href.split('#')[0]) {
        el.setAttribute(attrState, 'reload');
    }
    else {
        el.setAttribute(attrState, 'load');
    }
    pjax.handleLoad(el.href, el.getAttribute(attrState), el);
};
var handleHover = function (el, e, pjax) {
    if (isDefaultPrevented(el, e))
        return;
    if (e.type === 'mouseleave') {
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
    on_1.default(el, 'mouseenter', function (e) { handleHover(el, e, pjax); });
    on_1.default(el, 'mouseleave', function (e) { handleHover(el, e, pjax); });
    on_1.default(el, 'keyup', function (e) {
        if (e.key === 'enter' || e.keyCode === 13)
            handleClick(el, e, pjax);
    });
});


/***/ }),

/***/ "./node_modules/@codewithkyle/fuel-pjax/lib/events/on.js":
/*!***************************************************************!*\
  !*** ./node_modules/@codewithkyle/fuel-pjax/lib/events/on.js ***!
  \***************************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
exports.default = (function (el, event, listener) {
    el.addEventListener(event, listener);
});


/***/ }),

/***/ "./node_modules/@codewithkyle/fuel-pjax/lib/events/trigger.js":
/*!********************************************************************!*\
  !*** ./node_modules/@codewithkyle/fuel-pjax/lib/events/trigger.js ***!
  \********************************************************************/
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

/***/ "./node_modules/@codewithkyle/fuel-pjax/lib/parse-options.js":
/*!*******************************************************************!*\
  !*** ./node_modules/@codewithkyle/fuel-pjax/lib/parse-options.js ***!
  \*******************************************************************/
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

/***/ "./node_modules/@codewithkyle/fuel-pjax/lib/util/check-element.js":
/*!************************************************************************!*\
  !*** ./node_modules/@codewithkyle/fuel-pjax/lib/util/check-element.js ***!
  \************************************************************************/
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

/***/ "./node_modules/@codewithkyle/fuel-pjax/lib/util/contains.js":
/*!*******************************************************************!*\
  !*** ./node_modules/@codewithkyle/fuel-pjax/lib/util/contains.js ***!
  \*******************************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
exports.default = (function (doc, selectors, element) {
    selectors.map(function (selector) {
        var selectorEls = Array.from(doc.querySelectorAll(selector));
        selectorEls.forEach(function (el) {
            if (el.contains(element)) {
                return true;
            }
        });
    });
    return false;
});


/***/ }),

/***/ "./node_modules/@codewithkyle/fuel-pjax/lib/uuid.js":
/*!**********************************************************!*\
  !*** ./node_modules/@codewithkyle/fuel-pjax/lib/uuid.js ***!
  \**********************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
exports.default = (function () {
    return Date.now().toString();
});


/***/ }),

/***/ "./node_modules/@codewithkyle/fuel-pjax/pjax.js":
/*!******************************************************!*\
  !*** ./node_modules/@codewithkyle/fuel-pjax/pjax.js ***!
  \******************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
var parse_options_1 = __webpack_require__(/*! ./lib/parse-options */ "./node_modules/@codewithkyle/fuel-pjax/lib/parse-options.js");
var uuid_1 = __webpack_require__(/*! ./lib/uuid */ "./node_modules/@codewithkyle/fuel-pjax/lib/uuid.js");
var trigger_1 = __webpack_require__(/*! ./lib/events/trigger */ "./node_modules/@codewithkyle/fuel-pjax/lib/events/trigger.js");
var contains_1 = __webpack_require__(/*! ./lib/util/contains */ "./node_modules/@codewithkyle/fuel-pjax/lib/util/contains.js");
var link_events_1 = __webpack_require__(/*! ./lib/events/link-events */ "./node_modules/@codewithkyle/fuel-pjax/lib/events/link-events.js");
var check_element_1 = __webpack_require__(/*! ./lib/util/check-element */ "./node_modules/@codewithkyle/fuel-pjax/lib/util/check-element.js");
var Pjax = (function () {
    function Pjax(options) {
        if ('-ms-scroll-limit' in document.documentElement.style && '-ms-ime-align' in document.documentElement.style) {
            console.log('IE 11 detected - fuel-pjax aborted!');
            return;
        }
        this.state = {
            url: window.location.href,
            title: document.title,
            history: false,
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
        this.handlePushState();
    };
    Pjax.prototype.handleReload = function () {
        window.location.reload();
    };
    Pjax.prototype.setLinkListeners = function (el) {
        link_events_1.default(el, this);
    };
    Pjax.prototype.getElements = function (el) {
        return Array.from(el.querySelectorAll(this.options.elements));
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
        if (this.request === null) {
            return;
        }
        if (this.request.readyState !== 4) {
            this.request.abort();
        }
        this.request = null;
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
        if (this.options.debug) {
            console.log('Finishing Pjax');
        }
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
        var contiansScripts = false;
        selectors.forEach(function (selector) {
            var newEls = Array.from(toEl.querySelectorAll(selector));
            var oldEls = Array.from(fromEl.querySelectorAll(selector));
            if (_this.options.debug) {
                console.log('Pjax Switch Selector: ', selector, newEls, oldEls);
            }
            if (newEls.length !== oldEls.length) {
                if (_this.options.debug) {
                    console.log('DOM doesn\'t look the same on the new page');
                }
                _this.lastChance(_this.request.responseURL);
                return;
            }
            newEls.forEach(function (newElement, i) {
                var oldElement = oldEls[i];
                var scripts = newElement.querySelectorAll('script');
                if (scripts.length > 0) {
                    contiansScripts = true;
                }
                var elSwitch = {
                    newEl: newElement,
                    oldEl: oldElement
                };
                switchQueue.push(elSwitch);
            });
        });
        if (switchQueue.length === 0) {
            if (this.options.debug) {
                console.log('Couldn\'t find anything to switch');
            }
            this.lastChance(this.request.responseURL);
            return;
        }
        if (contiansScripts) {
            if (this.options.debug) {
                console.log('New page contains script elements.');
            }
            this.lastChance(this.request.responseURL);
            return;
        }
        if (!this.options.customTransitions) {
            if (this.options.titleSwitch) {
                document.title = toEl.title;
            }
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
        if (this.options.debug) {
            console.log("Something went wrong, native loading " + uri);
        }
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
        if (this.confirmed) {
            return;
        }
        if (this.options.debug) {
            console.log('Prefetching: ', href);
        }
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
        if (this.confirmed) {
            return;
        }
        trigger_1.default(document, ['pjax:send'], el);
        this.confirmed = true;
        if (this.cache !== null) {
            if (this.options.debug) {
                console.log('Loading Cached: ', href);
            }
            this.loadCachedContent();
        }
        else if (this.request !== null) {
            if (this.options.debug) {
                console.log('Loading Prefetch: ', href);
            }
            this.confirmed = true;
        }
        else {
            if (this.options.debug)
                console.log('Loading: ', href);
            this.doRequest(href)
                .then(function (e) { _this.handleResponse(e, loadType); })
                .catch(function (e) {
                if (_this.options.debug) {
                    console.log('XHR Request Error: ', e);
                }
            });
        }
    };
    Pjax.prototype.clearPrefetch = function () {
        if (!this.confirmed) {
            this.cache = null;
            this.abortRequest();
            trigger_1.default(document, ['pjax:cancel']);
        }
    };
    return Pjax;
}());
exports.default = Pjax;


/***/ }),

/***/ "./node_modules/animejs/lib/anime.es.js":
/*!**********************************************!*\
  !*** ./node_modules/animejs/lib/anime.es.js ***!
  \**********************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/*
 * anime.js v3.0.1
 * (c) 2019 Julian Garnier
 * Released under the MIT license
 * animejs.com
 */

// Defaults

var defaultInstanceSettings = {
  update: null,
  begin: null,
  loopBegin: null,
  changeBegin: null,
  change: null,
  changeComplete: null,
  loopComplete: null,
  complete: null,
  loop: 1,
  direction: 'normal',
  autoplay: true,
  timelineOffset: 0
};

var defaultTweenSettings = {
  duration: 1000,
  delay: 0,
  endDelay: 0,
  easing: 'easeOutElastic(1, .5)',
  round: 0
};

var validTransforms = ['translateX', 'translateY', 'translateZ', 'rotate', 'rotateX', 'rotateY', 'rotateZ', 'scale', 'scaleX', 'scaleY', 'scaleZ', 'skew', 'skewX', 'skewY', 'perspective'];

// Caching

var cache = {
  CSS: {},
  springs: {}
};

// Utils

function minMax(val, min, max) {
  return Math.min(Math.max(val, min), max);
}

function stringContains(str, text) {
  return str.indexOf(text) > -1;
}

function applyArguments(func, args) {
  return func.apply(null, args);
}

var is = {
  arr: function (a) { return Array.isArray(a); },
  obj: function (a) { return stringContains(Object.prototype.toString.call(a), 'Object'); },
  pth: function (a) { return is.obj(a) && a.hasOwnProperty('totalLength'); },
  svg: function (a) { return a instanceof SVGElement; },
  inp: function (a) { return a instanceof HTMLInputElement; },
  dom: function (a) { return a.nodeType || is.svg(a); },
  str: function (a) { return typeof a === 'string'; },
  fnc: function (a) { return typeof a === 'function'; },
  und: function (a) { return typeof a === 'undefined'; },
  hex: function (a) { return /(^#[0-9A-F]{6}$)|(^#[0-9A-F]{3}$)/i.test(a); },
  rgb: function (a) { return /^rgb/.test(a); },
  hsl: function (a) { return /^hsl/.test(a); },
  col: function (a) { return (is.hex(a) || is.rgb(a) || is.hsl(a)); },
  key: function (a) { return !defaultInstanceSettings.hasOwnProperty(a) && !defaultTweenSettings.hasOwnProperty(a) && a !== 'targets' && a !== 'keyframes'; }
};

// Easings

function parseEasingParameters(string) {
  var match = /\(([^)]+)\)/.exec(string);
  return match ? match[1].split(',').map(function (p) { return parseFloat(p); }) : [];
}

// Spring solver inspired by Webkit Copyright © 2016 Apple Inc. All rights reserved. https://webkit.org/demos/spring/spring.js

function spring(string, duration) {

  var params = parseEasingParameters(string);
  var mass = minMax(is.und(params[0]) ? 1 : params[0], .1, 100);
  var stiffness = minMax(is.und(params[1]) ? 100 : params[1], .1, 100);
  var damping = minMax(is.und(params[2]) ? 10 : params[2], .1, 100);
  var velocity =  minMax(is.und(params[3]) ? 0 : params[3], .1, 100);
  var w0 = Math.sqrt(stiffness / mass);
  var zeta = damping / (2 * Math.sqrt(stiffness * mass));
  var wd = zeta < 1 ? w0 * Math.sqrt(1 - zeta * zeta) : 0;
  var a = 1;
  var b = zeta < 1 ? (zeta * w0 + -velocity) / wd : -velocity + w0;

  function solver(t) {
    var progress = duration ? (duration * t) / 1000 : t;
    if (zeta < 1) {
      progress = Math.exp(-progress * zeta * w0) * (a * Math.cos(wd * progress) + b * Math.sin(wd * progress));
    } else {
      progress = (a + b * progress) * Math.exp(-progress * w0);
    }
    if (t === 0 || t === 1) { return t; }
    return 1 - progress;
  }

  function getDuration() {
    var cached = cache.springs[string];
    if (cached) { return cached; }
    var frame = 1/6;
    var elapsed = 0;
    var rest = 0;
    while(true) {
      elapsed += frame;
      if (solver(elapsed) === 1) {
        rest++;
        if (rest >= 16) { break; }
      } else {
        rest = 0;
      }
    }
    var duration = elapsed * frame * 1000;
    cache.springs[string] = duration;
    return duration;
  }

  return duration ? solver : getDuration;

}

// Elastic easing adapted from jQueryUI http://api.jqueryui.com/easings/

function elastic(amplitude, period) {
  if ( amplitude === void 0 ) amplitude = 1;
  if ( period === void 0 ) period = .5;

  var a = minMax(amplitude, 1, 10);
  var p = minMax(period, .1, 2);
  return function (t) {
    return (t === 0 || t === 1) ? t : 
      -a * Math.pow(2, 10 * (t - 1)) * Math.sin((((t - 1) - (p / (Math.PI * 2) * Math.asin(1 / a))) * (Math.PI * 2)) / p);
  }
}

// Basic steps easing implementation https://developer.mozilla.org/fr/docs/Web/CSS/transition-timing-function

function steps(steps) {
  if ( steps === void 0 ) steps = 10;

  return function (t) { return Math.round(t * steps) * (1 / steps); };
}

// BezierEasing https://github.com/gre/bezier-easing

var bezier = (function () {

  var kSplineTableSize = 11;
  var kSampleStepSize = 1.0 / (kSplineTableSize - 1.0);

  function A(aA1, aA2) { return 1.0 - 3.0 * aA2 + 3.0 * aA1 }
  function B(aA1, aA2) { return 3.0 * aA2 - 6.0 * aA1 }
  function C(aA1)      { return 3.0 * aA1 }

  function calcBezier(aT, aA1, aA2) { return ((A(aA1, aA2) * aT + B(aA1, aA2)) * aT + C(aA1)) * aT }
  function getSlope(aT, aA1, aA2) { return 3.0 * A(aA1, aA2) * aT * aT + 2.0 * B(aA1, aA2) * aT + C(aA1) }

  function binarySubdivide(aX, aA, aB, mX1, mX2) {
    var currentX, currentT, i = 0;
    do {
      currentT = aA + (aB - aA) / 2.0;
      currentX = calcBezier(currentT, mX1, mX2) - aX;
      if (currentX > 0.0) { aB = currentT; } else { aA = currentT; }
    } while (Math.abs(currentX) > 0.0000001 && ++i < 10);
    return currentT;
  }

  function newtonRaphsonIterate(aX, aGuessT, mX1, mX2) {
    for (var i = 0; i < 4; ++i) {
      var currentSlope = getSlope(aGuessT, mX1, mX2);
      if (currentSlope === 0.0) { return aGuessT; }
      var currentX = calcBezier(aGuessT, mX1, mX2) - aX;
      aGuessT -= currentX / currentSlope;
    }
    return aGuessT;
  }

  function bezier(mX1, mY1, mX2, mY2) {

    if (!(0 <= mX1 && mX1 <= 1 && 0 <= mX2 && mX2 <= 1)) { return; }
    var sampleValues = new Float32Array(kSplineTableSize);

    if (mX1 !== mY1 || mX2 !== mY2) {
      for (var i = 0; i < kSplineTableSize; ++i) {
        sampleValues[i] = calcBezier(i * kSampleStepSize, mX1, mX2);
      }
    }

    function getTForX(aX) {

      var intervalStart = 0;
      var currentSample = 1;
      var lastSample = kSplineTableSize - 1;

      for (; currentSample !== lastSample && sampleValues[currentSample] <= aX; ++currentSample) {
        intervalStart += kSampleStepSize;
      }

      --currentSample;

      var dist = (aX - sampleValues[currentSample]) / (sampleValues[currentSample + 1] - sampleValues[currentSample]);
      var guessForT = intervalStart + dist * kSampleStepSize;
      var initialSlope = getSlope(guessForT, mX1, mX2);

      if (initialSlope >= 0.001) {
        return newtonRaphsonIterate(aX, guessForT, mX1, mX2);
      } else if (initialSlope === 0.0) {
        return guessForT;
      } else {
        return binarySubdivide(aX, intervalStart, intervalStart + kSampleStepSize, mX1, mX2);
      }

    }

    return function (x) {
      if (mX1 === mY1 && mX2 === mY2) { return x; }
      if (x === 0 || x === 1) { return x; }
      return calcBezier(getTForX(x), mY1, mY2);
    }

  }

  return bezier;

})();

var penner = (function () {

  var names = ['Quad', 'Cubic', 'Quart', 'Quint', 'Sine', 'Expo', 'Circ', 'Back', 'Elastic'];

  // Approximated Penner equations http://matthewlein.com/ceaser/

  var curves = {
    In: [
      [0.550, 0.085, 0.680, 0.530], /* inQuad */
      [0.550, 0.055, 0.675, 0.190], /* inCubic */
      [0.895, 0.030, 0.685, 0.220], /* inQuart */
      [0.755, 0.050, 0.855, 0.060], /* inQuint */
      [0.470, 0.000, 0.745, 0.715], /* inSine */
      [0.950, 0.050, 0.795, 0.035], /* inExpo */
      [0.600, 0.040, 0.980, 0.335], /* inCirc */
      [0.600,-0.280, 0.735, 0.045], /* inBack */
      elastic /* inElastic */
    ],
    Out: [
      [0.250, 0.460, 0.450, 0.940], /* outQuad */
      [0.215, 0.610, 0.355, 1.000], /* outCubic */
      [0.165, 0.840, 0.440, 1.000], /* outQuart */
      [0.230, 1.000, 0.320, 1.000], /* outQuint */
      [0.390, 0.575, 0.565, 1.000], /* outSine */
      [0.190, 1.000, 0.220, 1.000], /* outExpo */
      [0.075, 0.820, 0.165, 1.000], /* outCirc */
      [0.175, 0.885, 0.320, 1.275], /* outBack */
      function (a, p) { return function (t) { return 1 - elastic(a, p)(1 - t); }; } /* outElastic */
    ],
    InOut: [
      [0.455, 0.030, 0.515, 0.955], /* inOutQuad */
      [0.645, 0.045, 0.355, 1.000], /* inOutCubic */
      [0.770, 0.000, 0.175, 1.000], /* inOutQuart */
      [0.860, 0.000, 0.070, 1.000], /* inOutQuint */
      [0.445, 0.050, 0.550, 0.950], /* inOutSine */
      [1.000, 0.000, 0.000, 1.000], /* inOutExpo */
      [0.785, 0.135, 0.150, 0.860], /* inOutCirc */
      [0.680,-0.550, 0.265, 1.550], /* inOutBack */
      function (a, p) { return function (t) { return t < .5 ? elastic(a, p)(t * 2) / 2 : 1 - elastic(a, p)(t * -2 + 2) / 2; }; } /* inOutElastic */
    ]
  };

  var eases = { 
    linear: [0.250, 0.250, 0.750, 0.750]
  };

  var loop = function ( coords ) {
    curves[coords].forEach(function (ease, i) {
      eases['ease'+coords+names[i]] = ease;
    });
  };

  for (var coords in curves) loop( coords );

  return eases;

})();

function parseEasings(easing, duration) {
  if (is.fnc(easing)) { return easing; }
  var name = easing.split('(')[0];
  var ease = penner[name];
  var args = parseEasingParameters(easing);
  switch (name) {
    case 'spring' : return spring(easing, duration);
    case 'cubicBezier' : return applyArguments(bezier, args);
    case 'steps' : return applyArguments(steps, args);
    default : return is.fnc(ease) ? applyArguments(ease, args) : applyArguments(bezier, ease);
  }
}

// Strings

function selectString(str) {
  try {
    var nodes = document.querySelectorAll(str);
    return nodes;
  } catch(e) {
    return;
  }
}

// Arrays

function filterArray(arr, callback) {
  var len = arr.length;
  var thisArg = arguments.length >= 2 ? arguments[1] : void 0;
  var result = [];
  for (var i = 0; i < len; i++) {
    if (i in arr) {
      var val = arr[i];
      if (callback.call(thisArg, val, i, arr)) {
        result.push(val);
      }
    }
  }
  return result;
}

function flattenArray(arr) {
  return arr.reduce(function (a, b) { return a.concat(is.arr(b) ? flattenArray(b) : b); }, []);
}

function toArray(o) {
  if (is.arr(o)) { return o; }
  if (is.str(o)) { o = selectString(o) || o; }
  if (o instanceof NodeList || o instanceof HTMLCollection) { return [].slice.call(o); }
  return [o];
}

function arrayContains(arr, val) {
  return arr.some(function (a) { return a === val; });
}

// Objects

function cloneObject(o) {
  var clone = {};
  for (var p in o) { clone[p] = o[p]; }
  return clone;
}

function replaceObjectProps(o1, o2) {
  var o = cloneObject(o1);
  for (var p in o1) { o[p] = o2.hasOwnProperty(p) ? o2[p] : o1[p]; }
  return o;
}

function mergeObjects(o1, o2) {
  var o = cloneObject(o1);
  for (var p in o2) { o[p] = is.und(o1[p]) ? o2[p] : o1[p]; }
  return o;
}

// Colors

function rgbToRgba(rgbValue) {
  var rgb = /rgb\((\d+,\s*[\d]+,\s*[\d]+)\)/g.exec(rgbValue);
  return rgb ? ("rgba(" + (rgb[1]) + ",1)") : rgbValue;
}

function hexToRgba(hexValue) {
  var rgx = /^#?([a-f\d])([a-f\d])([a-f\d])$/i;
  var hex = hexValue.replace(rgx, function (m, r, g, b) { return r + r + g + g + b + b; } );
  var rgb = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
  var r = parseInt(rgb[1], 16);
  var g = parseInt(rgb[2], 16);
  var b = parseInt(rgb[3], 16);
  return ("rgba(" + r + "," + g + "," + b + ",1)");
}

function hslToRgba(hslValue) {
  var hsl = /hsl\((\d+),\s*([\d.]+)%,\s*([\d.]+)%\)/g.exec(hslValue) || /hsla\((\d+),\s*([\d.]+)%,\s*([\d.]+)%,\s*([\d.]+)\)/g.exec(hslValue);
  var h = parseInt(hsl[1], 10) / 360;
  var s = parseInt(hsl[2], 10) / 100;
  var l = parseInt(hsl[3], 10) / 100;
  var a = hsl[4] || 1;
  function hue2rgb(p, q, t) {
    if (t < 0) { t += 1; }
    if (t > 1) { t -= 1; }
    if (t < 1/6) { return p + (q - p) * 6 * t; }
    if (t < 1/2) { return q; }
    if (t < 2/3) { return p + (q - p) * (2/3 - t) * 6; }
    return p;
  }
  var r, g, b;
  if (s == 0) {
    r = g = b = l;
  } else {
    var q = l < 0.5 ? l * (1 + s) : l + s - l * s;
    var p = 2 * l - q;
    r = hue2rgb(p, q, h + 1/3);
    g = hue2rgb(p, q, h);
    b = hue2rgb(p, q, h - 1/3);
  }
  return ("rgba(" + (r * 255) + "," + (g * 255) + "," + (b * 255) + "," + a + ")");
}

function colorToRgb(val) {
  if (is.rgb(val)) { return rgbToRgba(val); }
  if (is.hex(val)) { return hexToRgba(val); }
  if (is.hsl(val)) { return hslToRgba(val); }
}

// Units

function getUnit(val) {
  var split = /([\+\-]?[0-9#\.]+)(%|px|pt|em|rem|in|cm|mm|ex|ch|pc|vw|vh|vmin|vmax|deg|rad|turn)?$/.exec(val);
  if (split) { return split[2]; }
}

function getTransformUnit(propName) {
  if (stringContains(propName, 'translate') || propName === 'perspective') { return 'px'; }
  if (stringContains(propName, 'rotate') || stringContains(propName, 'skew')) { return 'deg'; }
}

// Values

function getFunctionValue(val, animatable) {
  if (!is.fnc(val)) { return val; }
  return val(animatable.target, animatable.id, animatable.total);
}

function getAttribute(el, prop) {
  return el.getAttribute(prop);
}

function convertPxToUnit(el, value, unit) {
  var valueUnit = getUnit(value);
  if (arrayContains([unit, 'deg', 'rad', 'turn'], valueUnit)) { return value; }
  var cached = cache.CSS[value + unit];
  if (!is.und(cached)) { return cached; }
  var baseline = 100;
  var tempEl = document.createElement(el.tagName);
  var parentEl = (el.parentNode && (el.parentNode !== document)) ? el.parentNode : document.body;
  parentEl.appendChild(tempEl);
  tempEl.style.position = 'absolute';
  tempEl.style.width = baseline + unit;
  var factor = baseline / tempEl.offsetWidth;
  parentEl.removeChild(tempEl);
  var convertedUnit = factor * parseFloat(value);
  cache.CSS[value + unit] = convertedUnit;
  return convertedUnit;
}

function getCSSValue(el, prop, unit) {
  if (prop in el.style) {
    var uppercasePropName = prop.replace(/([a-z])([A-Z])/g, '$1-$2').toLowerCase();
    var value = el.style[prop] || getComputedStyle(el).getPropertyValue(uppercasePropName) || '0';
    return unit ? convertPxToUnit(el, value, unit) : value;
  }
}

function getAnimationType(el, prop) {
  if (is.dom(el) && !is.inp(el) && (getAttribute(el, prop) || (is.svg(el) && el[prop]))) { return 'attribute'; }
  if (is.dom(el) && arrayContains(validTransforms, prop)) { return 'transform'; }
  if (is.dom(el) && (prop !== 'transform' && getCSSValue(el, prop))) { return 'css'; }
  if (el[prop] != null) { return 'object'; }
}

function getElementTransforms(el) {
  if (!is.dom(el)) { return; }
  var str = el.style.transform || '';
  var reg  = /(\w+)\(([^)]*)\)/g;
  var transforms = new Map();
  var m; while (m = reg.exec(str)) { transforms.set(m[1], m[2]); }
  return transforms;
}

function getTransformValue(el, propName, animatable, unit) {
  var defaultVal = stringContains(propName, 'scale') ? 1 : 0 + getTransformUnit(propName);
  var value = getElementTransforms(el).get(propName) || defaultVal;
  if (animatable) {
    animatable.transforms.list.set(propName, value);
    animatable.transforms['last'] = propName;
  }
  return unit ? convertPxToUnit(el, value, unit) : value;
}

function getOriginalTargetValue(target, propName, unit, animatable) {
  switch (getAnimationType(target, propName)) {
    case 'transform': return getTransformValue(target, propName, animatable, unit);
    case 'css': return getCSSValue(target, propName, unit);
    case 'attribute': return getAttribute(target, propName);
    default: return target[propName] || 0;
  }
}

function getRelativeValue(to, from) {
  var operator = /^(\*=|\+=|-=)/.exec(to);
  if (!operator) { return to; }
  var u = getUnit(to) || 0;
  var x = parseFloat(from);
  var y = parseFloat(to.replace(operator[0], ''));
  switch (operator[0][0]) {
    case '+': return x + y + u;
    case '-': return x - y + u;
    case '*': return x * y + u;
  }
}

function validateValue(val, unit) {
  if (is.col(val)) { return colorToRgb(val); }
  var originalUnit = getUnit(val);
  var unitLess = originalUnit ? val.substr(0, val.length - originalUnit.length) : val;
  return unit && !/\s/g.test(val) ? unitLess + unit : unitLess;
}

// getTotalLength() equivalent for circle, rect, polyline, polygon and line shapes
// adapted from https://gist.github.com/SebLambla/3e0550c496c236709744

function getDistance(p1, p2) {
  return Math.sqrt(Math.pow(p2.x - p1.x, 2) + Math.pow(p2.y - p1.y, 2));
}

function getCircleLength(el) {
  return Math.PI * 2 * getAttribute(el, 'r');
}

function getRectLength(el) {
  return (getAttribute(el, 'width') * 2) + (getAttribute(el, 'height') * 2);
}

function getLineLength(el) {
  return getDistance(
    {x: getAttribute(el, 'x1'), y: getAttribute(el, 'y1')}, 
    {x: getAttribute(el, 'x2'), y: getAttribute(el, 'y2')}
  );
}

function getPolylineLength(el) {
  var points = el.points;
  var totalLength = 0;
  var previousPos;
  for (var i = 0 ; i < points.numberOfItems; i++) {
    var currentPos = points.getItem(i);
    if (i > 0) { totalLength += getDistance(previousPos, currentPos); }
    previousPos = currentPos;
  }
  return totalLength;
}

function getPolygonLength(el) {
  var points = el.points;
  return getPolylineLength(el) + getDistance(points.getItem(points.numberOfItems - 1), points.getItem(0));
}

// Path animation

function getTotalLength(el) {
  if (el.getTotalLength) { return el.getTotalLength(); }
  switch(el.tagName.toLowerCase()) {
    case 'circle': return getCircleLength(el);
    case 'rect': return getRectLength(el);
    case 'line': return getLineLength(el);
    case 'polyline': return getPolylineLength(el);
    case 'polygon': return getPolygonLength(el);
  }
}

function setDashoffset(el) {
  var pathLength = getTotalLength(el);
  el.setAttribute('stroke-dasharray', pathLength);
  return pathLength;
}

// Motion path

function getParentSvgEl(el) {
  var parentEl = el.parentNode;
  while (is.svg(parentEl)) {
    parentEl = parentEl.parentNode;
    if (!is.svg(parentEl.parentNode)) { break; }
  }
  return parentEl;
}

function getParentSvg(pathEl, svgData) {
  var svg = svgData || {};
  var parentSvgEl = svg.el || getParentSvgEl(pathEl);
  var rect = parentSvgEl.getBoundingClientRect();
  var viewBoxAttr = getAttribute(parentSvgEl, 'viewBox');
  var width = rect.width;
  var height = rect.height;
  var viewBox = svg.viewBox || (viewBoxAttr ? viewBoxAttr.split(' ') : [0, 0, width, height]);
  return {
    el: parentSvgEl,
    viewBox: viewBox,
    x: viewBox[0] / 1,
    y: viewBox[1] / 1,
    w: width / viewBox[2],
    h: height / viewBox[3]
  }
}

function getPath(path, percent) {
  var pathEl = is.str(path) ? selectString(path)[0] : path;
  var p = percent || 100;
  return function(property) {
    return {
      property: property,
      el: pathEl,
      svg: getParentSvg(pathEl),
      totalLength: getTotalLength(pathEl) * (p / 100)
    }
  }
}

function getPathProgress(path, progress) {
  function point(offset) {
    if ( offset === void 0 ) offset = 0;

    var l = progress + offset >= 1 ? progress + offset : 0;
    return path.el.getPointAtLength(l);
  }
  var svg = getParentSvg(path.el, path.svg);
  var p = point();
  var p0 = point(-1);
  var p1 = point(+1);
  switch (path.property) {
    case 'x': return (p.x - svg.x) * svg.w;
    case 'y': return (p.y - svg.y) * svg.h;
    case 'angle': return Math.atan2(p1.y - p0.y, p1.x - p0.x) * 180 / Math.PI;
  }
}

// Decompose value

function decomposeValue(val, unit) {
  var rgx = /-?\d*\.?\d+/g;
  var value = validateValue((is.pth(val) ? val.totalLength : val), unit) + '';
  return {
    original: value,
    numbers: value.match(rgx) ? value.match(rgx).map(Number) : [0],
    strings: (is.str(val) || unit) ? value.split(rgx) : []
  }
}

// Animatables

function parseTargets(targets) {
  var targetsArray = targets ? (flattenArray(is.arr(targets) ? targets.map(toArray) : toArray(targets))) : [];
  return filterArray(targetsArray, function (item, pos, self) { return self.indexOf(item) === pos; });
}

function getAnimatables(targets) {
  var parsed = parseTargets(targets);
  return parsed.map(function (t, i) {
    return {target: t, id: i, total: parsed.length, transforms: { list: getElementTransforms(t) } };
  });
}

// Properties

function normalizePropertyTweens(prop, tweenSettings) {
  var settings = cloneObject(tweenSettings);
  // Override duration if easing is a spring
  if (/^spring/.test(settings.easing)) { settings.duration = spring(settings.easing); }
  if (is.arr(prop)) {
    var l = prop.length;
    var isFromTo = (l === 2 && !is.obj(prop[0]));
    if (!isFromTo) {
      // Duration divided by the number of tweens
      if (!is.fnc(tweenSettings.duration)) { settings.duration = tweenSettings.duration / l; }
    } else {
      // Transform [from, to] values shorthand to a valid tween value
      prop = {value: prop};
    }
  }
  var propArray = is.arr(prop) ? prop : [prop];
  return propArray.map(function (v, i) {
    var obj = (is.obj(v) && !is.pth(v)) ? v : {value: v};
    // Default delay value should only be applied to the first tween
    if (is.und(obj.delay)) { obj.delay = !i ? tweenSettings.delay : 0; }
    // Default endDelay value should only be applied to the last tween
    if (is.und(obj.endDelay)) { obj.endDelay = i === propArray.length - 1 ? tweenSettings.endDelay : 0; }
    return obj;
  }).map(function (k) { return mergeObjects(k, settings); });
}


function flattenKeyframes(keyframes) {
  var propertyNames = filterArray(flattenArray(keyframes.map(function (key) { return Object.keys(key); })), function (p) { return is.key(p); })
  .reduce(function (a,b) { if (a.indexOf(b) < 0) { a.push(b); } return a; }, []);
  var properties = {};
  var loop = function ( i ) {
    var propName = propertyNames[i];
    properties[propName] = keyframes.map(function (key) {
      var newKey = {};
      for (var p in key) {
        if (is.key(p)) {
          if (p == propName) { newKey.value = key[p]; }
        } else {
          newKey[p] = key[p];
        }
      }
      return newKey;
    });
  };

  for (var i = 0; i < propertyNames.length; i++) loop( i );
  return properties;
}

function getProperties(tweenSettings, params) {
  var properties = [];
  var keyframes = params.keyframes;
  if (keyframes) { params = mergeObjects(flattenKeyframes(keyframes), params); }
  for (var p in params) {
    if (is.key(p)) {
      properties.push({
        name: p,
        tweens: normalizePropertyTweens(params[p], tweenSettings)
      });
    }
  }
  return properties;
}

// Tweens

function normalizeTweenValues(tween, animatable) {
  var t = {};
  for (var p in tween) {
    var value = getFunctionValue(tween[p], animatable);
    if (is.arr(value)) {
      value = value.map(function (v) { return getFunctionValue(v, animatable); });
      if (value.length === 1) { value = value[0]; }
    }
    t[p] = value;
  }
  t.duration = parseFloat(t.duration);
  t.delay = parseFloat(t.delay);
  return t;
}

function normalizeTweens(prop, animatable) {
  var previousTween;
  return prop.tweens.map(function (t) {
    var tween = normalizeTweenValues(t, animatable);
    var tweenValue = tween.value;
    var to = is.arr(tweenValue) ? tweenValue[1] : tweenValue;
    var toUnit = getUnit(to);
    var originalValue = getOriginalTargetValue(animatable.target, prop.name, toUnit, animatable);
    var previousValue = previousTween ? previousTween.to.original : originalValue;
    var from = is.arr(tweenValue) ? tweenValue[0] : previousValue;
    var fromUnit = getUnit(from) || getUnit(originalValue);
    var unit = toUnit || fromUnit;
    if (is.und(to)) { to = previousValue; }
    tween.from = decomposeValue(from, unit);
    tween.to = decomposeValue(getRelativeValue(to, from), unit);
    tween.start = previousTween ? previousTween.end : 0;
    tween.end = tween.start + tween.delay + tween.duration + tween.endDelay;
    tween.easing = parseEasings(tween.easing, tween.duration);
    tween.isPath = is.pth(tweenValue);
    tween.isColor = is.col(tween.from.original);
    if (tween.isColor) { tween.round = 1; }
    previousTween = tween;
    return tween;
  });
}

// Tween progress

var setProgressValue = {
  css: function (t, p, v) { return t.style[p] = v; },
  attribute: function (t, p, v) { return t.setAttribute(p, v); },
  object: function (t, p, v) { return t[p] = v; },
  transform: function (t, p, v, transforms, manual) {
    transforms.list.set(p, v);
    if (p === transforms.last || manual) {
      var str = '';
      transforms.list.forEach(function (value, prop) { str += prop + "(" + value + ") "; });
      t.style.transform = str;
    }
  }
};

// Set Value helper

function setTargetsValue(targets, properties) {
  var animatables = getAnimatables(targets);
  animatables.forEach(function (animatable) {
    for (var property in properties) {
      var value = getFunctionValue(properties[property], animatable);
      var target = animatable.target;
      var valueUnit = getUnit(value);
      var originalValue = getOriginalTargetValue(target, property, valueUnit, animatable);
      var unit = valueUnit || getUnit(originalValue);
      var to = getRelativeValue(validateValue(value, unit), originalValue);
      var animType = getAnimationType(target, property);
      setProgressValue[animType](target, property, to, animatable.transforms, true);
    }
  });
}

// Animations

function createAnimation(animatable, prop) {
  var animType = getAnimationType(animatable.target, prop.name);
  if (animType) {
    var tweens = normalizeTweens(prop, animatable);
    var lastTween = tweens[tweens.length - 1];
    return {
      type: animType,
      property: prop.name,
      animatable: animatable,
      tweens: tweens,
      duration: lastTween.end,
      delay: tweens[0].delay,
      endDelay: lastTween.endDelay
    }
  }
}

function getAnimations(animatables, properties) {
  return filterArray(flattenArray(animatables.map(function (animatable) {
    return properties.map(function (prop) {
      return createAnimation(animatable, prop);
    });
  })), function (a) { return !is.und(a); });
}

// Create Instance

function getInstanceTimings(animations, tweenSettings) {
  var animLength = animations.length;
  var getTlOffset = function (anim) { return anim.timelineOffset ? anim.timelineOffset : 0; };
  var timings = {};
  timings.duration = animLength ? Math.max.apply(Math, animations.map(function (anim) { return getTlOffset(anim) + anim.duration; })) : tweenSettings.duration;
  timings.delay = animLength ? Math.min.apply(Math, animations.map(function (anim) { return getTlOffset(anim) + anim.delay; })) : tweenSettings.delay;
  timings.endDelay = animLength ? timings.duration - Math.max.apply(Math, animations.map(function (anim) { return getTlOffset(anim) + anim.duration - anim.endDelay; })) : tweenSettings.endDelay;
  return timings;
}

var instanceID = 0;

function createNewInstance(params) {
  var instanceSettings = replaceObjectProps(defaultInstanceSettings, params);
  var tweenSettings = replaceObjectProps(defaultTweenSettings, params);
  var properties = getProperties(tweenSettings, params);
  var animatables = getAnimatables(params.targets);
  var animations = getAnimations(animatables, properties);
  var timings = getInstanceTimings(animations, tweenSettings);
  var id = instanceID;
  instanceID++;
  return mergeObjects(instanceSettings, {
    id: id,
    children: [],
    animatables: animatables,
    animations: animations,
    duration: timings.duration,
    delay: timings.delay,
    endDelay: timings.endDelay
  });
}

// Core

var activeInstances = [];
var pausedInstances = [];
var raf;

var engine = (function () {
  function play() { 
    raf = requestAnimationFrame(step);
  }
  function step(t) {
    var activeInstancesLength = activeInstances.length;
    if (activeInstancesLength) {
      var i = 0;
      while (i < activeInstancesLength) {
        var activeInstance = activeInstances[i];
        if (!activeInstance.paused) {
          activeInstance.tick(t);
        } else {
          var instanceIndex = activeInstances.indexOf(activeInstance);
          if (instanceIndex > -1) {
            activeInstances.splice(instanceIndex, 1);
            activeInstancesLength = activeInstances.length;
          }
        }
        i++;
      }
      play();
    } else {
      raf = cancelAnimationFrame(raf);
    }
  }
  return play;
})();

function handleVisibilityChange() {
  if (document.hidden) {
    activeInstances.forEach(function (ins) { return ins.pause(); });
    pausedInstances = activeInstances.slice(0);
    activeInstances = [];
  } else {
    pausedInstances.forEach(function (ins) { return ins.play(); });
  }
}

if (typeof document !== 'undefined') {
  document.addEventListener('visibilitychange', handleVisibilityChange);
}

// Public Instance

function anime(params) {
  if ( params === void 0 ) params = {};


  var startTime = 0, lastTime = 0, now = 0;
  var children, childrenLength = 0;
  var resolve = null;

  function makePromise(instance) {
    var promise = window.Promise && new Promise(function (_resolve) { return resolve = _resolve; });
    instance.finished = promise;
    return promise;
  }

  var instance = createNewInstance(params);
  var promise = makePromise(instance);

  function toggleInstanceDirection() {
    var direction = instance.direction;
    if (direction !== 'alternate') {
      instance.direction = direction !== 'normal' ? 'normal' : 'reverse';
    }
    instance.reversed = !instance.reversed;
    children.forEach(function (child) { return child.reversed = instance.reversed; });
  }

  function adjustTime(time) {
    return instance.reversed ? instance.duration - time : time;
  }

  function resetTime() {
    startTime = 0;
    lastTime = adjustTime(instance.currentTime) * (1 / anime.speed);
  }

  function seekCild(time, child) {
    if (child) { child.seek(time - child.timelineOffset); }
  }

  function syncInstanceChildren(time) {
    if (!instance.reversePlayback) {
      for (var i = 0; i < childrenLength; i++) { seekCild(time, children[i]); }
    } else {
      for (var i$1 = childrenLength; i$1--;) { seekCild(time, children[i$1]); }
    }
  }

  function setAnimationsProgress(insTime) {
    var i = 0;
    var animations = instance.animations;
    var animationsLength = animations.length;
    while (i < animationsLength) {
      var anim = animations[i];
      var animatable = anim.animatable;
      var tweens = anim.tweens;
      var tweenLength = tweens.length - 1;
      var tween = tweens[tweenLength];
      // Only check for keyframes if there is more than one tween
      if (tweenLength) { tween = filterArray(tweens, function (t) { return (insTime < t.end); })[0] || tween; }
      var elapsed = minMax(insTime - tween.start - tween.delay, 0, tween.duration) / tween.duration;
      var eased = isNaN(elapsed) ? 1 : tween.easing(elapsed);
      var strings = tween.to.strings;
      var round = tween.round;
      var numbers = [];
      var toNumbersLength = tween.to.numbers.length;
      var progress = (void 0);
      for (var n = 0; n < toNumbersLength; n++) {
        var value = (void 0);
        var toNumber = tween.to.numbers[n];
        var fromNumber = tween.from.numbers[n] || 0;
        if (!tween.isPath) {
          value = fromNumber + (eased * (toNumber - fromNumber));
        } else {
          value = getPathProgress(tween.value, eased * toNumber);
        }
        if (round) {
          if (!(tween.isColor && n > 2)) {
            value = Math.round(value * round) / round;
          }
        }
        numbers.push(value);
      }
      // Manual Array.reduce for better performances
      var stringsLength = strings.length;
      if (!stringsLength) {
        progress = numbers[0];
      } else {
        progress = strings[0];
        for (var s = 0; s < stringsLength; s++) {
          var a = strings[s];
          var b = strings[s + 1];
          var n$1 = numbers[s];
          if (!isNaN(n$1)) {
            if (!b) {
              progress += n$1 + ' ';
            } else {
              progress += n$1 + b;
            }
          }
        }
      }
      setProgressValue[anim.type](animatable.target, anim.property, progress, animatable.transforms);
      anim.currentValue = progress;
      i++;
    }
  }

  function setCallback(cb) {
    if (instance[cb] && !instance.passThrough) { instance[cb](instance); }
  }

  function countIteration() {
    if (instance.remaining && instance.remaining !== true) {
      instance.remaining--;
    }
  }

  function setInstanceProgress(engineTime) {
    var insDuration = instance.duration;
    var insDelay = instance.delay;
    var insEndDelay = insDuration - instance.endDelay;
    var insTime = adjustTime(engineTime);
    instance.progress = minMax((insTime / insDuration) * 100, 0, 100);
    instance.reversePlayback = insTime < instance.currentTime;
    if (children) { syncInstanceChildren(insTime); }
    if (!instance.began && instance.currentTime > 0) {
      instance.began = true;
      setCallback('begin');
      setCallback('loopBegin');
    }
    if (insTime <= insDelay && instance.currentTime !== 0) {
      setAnimationsProgress(0);
    }
    if ((insTime >= insEndDelay && instance.currentTime !== insDuration) || !insDuration) {
      setAnimationsProgress(insDuration);
    }
    if (insTime > insDelay && insTime < insEndDelay) {
      if (!instance.changeBegan) {
        instance.changeBegan = true;
        instance.changeCompleted = false;
        setCallback('changeBegin');
      }
      setCallback('change');
      setAnimationsProgress(insTime);
    } else {
      if (instance.changeBegan) {
        instance.changeCompleted = true;
        instance.changeBegan = false;
        setCallback('changeComplete');
      }
    }
    instance.currentTime = minMax(insTime, 0, insDuration);
    if (instance.began) { setCallback('update'); }
    if (engineTime >= insDuration) {
      lastTime = 0;
      countIteration();
      if (instance.remaining) {
        startTime = now;
        setCallback('loopComplete');
        setCallback('loopBegin');
        if (instance.direction === 'alternate') { toggleInstanceDirection(); }
      } else {
        instance.paused = true;
        if (!instance.completed) {
          instance.completed = true;
          setCallback('loopComplete');
          setCallback('complete');
          if (!instance.passThrough && 'Promise' in window) {
            resolve();
            promise = makePromise(instance);
          }
        }
      }
    }
  }

  instance.reset = function() {
    var direction = instance.direction;
    instance.passThrough = false;
    instance.currentTime = 0;
    instance.progress = 0;
    instance.paused = true;
    instance.began = false;
    instance.changeBegan = false;
    instance.completed = false;
    instance.changeCompleted = false;
    instance.reversePlayback = false;
    instance.reversed = direction === 'reverse';
    instance.remaining = instance.loop;
    children = instance.children;
    childrenLength = children.length;
    for (var i = childrenLength; i--;) { instance.children[i].reset(); }
    if (instance.reversed && instance.loop !== true || (direction === 'alternate' && instance.loop === 1)) { instance.remaining++; }
    setAnimationsProgress(0);
  };

  // Set Value helper

  instance.set = function(targets, properties) {
    setTargetsValue(targets, properties);
    return instance;
  };

  instance.tick = function(t) {
    now = t;
    if (!startTime) { startTime = now; }
    setInstanceProgress((now + (lastTime - startTime)) * anime.speed);
  };

  instance.seek = function(time) {
    setInstanceProgress(adjustTime(time));
  };

  instance.pause = function() {
    instance.paused = true;
    resetTime();
  };

  instance.play = function() {
    if (!instance.paused) { return; }
    if (instance.completed) { instance.reset(); }
    instance.paused = false;
    activeInstances.push(instance);
    resetTime();
    if (!raf) { engine(); }
  };

  instance.reverse = function() {
    toggleInstanceDirection();
    resetTime();
  };

  instance.restart = function() {
    instance.reset();
    instance.play();
  };

  instance.reset();

  if (instance.autoplay) { instance.play(); }

  return instance;

}

// Remove targets from animation

function removeTargetsFromAnimations(targetsArray, animations) {
  for (var a = animations.length; a--;) {
    if (arrayContains(targetsArray, animations[a].animatable.target)) {
      animations.splice(a, 1);
    }
  }
}

function removeTargets(targets) {
  var targetsArray = parseTargets(targets);
  for (var i = activeInstances.length; i--;) {
    var instance = activeInstances[i];
    var animations = instance.animations;
    var children = instance.children;
    removeTargetsFromAnimations(targetsArray, animations);
    for (var c = children.length; c--;) {
      var child = children[c];
      var childAnimations = child.animations;
      removeTargetsFromAnimations(targetsArray, childAnimations);
      if (!childAnimations.length && !child.children.length) { children.splice(c, 1); }
    }
    if (!animations.length && !children.length) { instance.pause(); }
  }
}

// Stagger helpers

function stagger(val, params) {
  if ( params === void 0 ) params = {};

  var direction = params.direction || 'normal';
  var easing = params.easing ? parseEasings(params.easing) : null;
  var grid = params.grid;
  var axis = params.axis;
  var fromIndex = params.from || 0;
  var fromFirst = fromIndex === 'first';
  var fromCenter = fromIndex === 'center';
  var fromLast = fromIndex === 'last';
  var isRange = is.arr(val);
  var val1 = isRange ? parseFloat(val[0]) : parseFloat(val);
  var val2 = isRange ? parseFloat(val[1]) : 0;
  var unit = getUnit(isRange ? val[1] : val) || 0;
  var start = params.start || 0 + (isRange ? val1 : 0);
  var values = [];
  var maxValue = 0;
  return function (el, i, t) {
    if (fromFirst) { fromIndex = 0; }
    if (fromCenter) { fromIndex = (t - 1) / 2; }
    if (fromLast) { fromIndex = t - 1; }
    if (!values.length) {
      for (var index = 0; index < t; index++) {
        if (!grid) {
          values.push(Math.abs(fromIndex - index));
        } else {
          var fromX = !fromCenter ? fromIndex%grid[0] : (grid[0]-1)/2;
          var fromY = !fromCenter ? Math.floor(fromIndex/grid[0]) : (grid[1]-1)/2;
          var toX = index%grid[0];
          var toY = Math.floor(index/grid[0]);
          var distanceX = fromX - toX;
          var distanceY = fromY - toY;
          var value = Math.sqrt(distanceX * distanceX + distanceY * distanceY);
          if (axis === 'x') { value = -distanceX; }
          if (axis === 'y') { value = -distanceY; }
          values.push(value);
        }
        maxValue = Math.max.apply(Math, values);
      }
      if (easing) { values = values.map(function (val) { return easing(val / maxValue) * maxValue; }); }
      if (direction === 'reverse') { values = values.map(function (val) { return axis ? (val < 0) ? val * -1 : -val : Math.abs(maxValue - val); }); }
    }
    var spacing = isRange ? (val2 - val1) / maxValue : val1;
    return start + (spacing * (Math.round(values[i] * 100) / 100)) + unit;
  }
}

// Timeline

function timeline(params) {
  if ( params === void 0 ) params = {};

  var tl = anime(params);
  tl.duration = 0;
  tl.add = function(instanceParams, timelineOffset) {
    var tlIndex = activeInstances.indexOf(tl);
    var children = tl.children;
    if (tlIndex > -1) { activeInstances.splice(tlIndex, 1); }
    function passThrough(ins) { ins.passThrough = true; }
    for (var i = 0; i < children.length; i++) { passThrough(children[i]); }
    var insParams = mergeObjects(instanceParams, replaceObjectProps(defaultTweenSettings, params));
    insParams.targets = insParams.targets || params.targets;
    var tlDuration = tl.duration;
    insParams.autoplay = false;
    insParams.direction = tl.direction;
    insParams.timelineOffset = is.und(timelineOffset) ? tlDuration : getRelativeValue(timelineOffset, tlDuration);
    passThrough(tl);
    tl.seek(insParams.timelineOffset);
    var ins = anime(insParams);
    passThrough(ins);
    children.push(ins);
    var timings = getInstanceTimings(children, params);
    tl.delay = timings.delay;
    tl.endDelay = timings.endDelay;
    tl.duration = timings.duration;
    tl.seek(0);
    tl.reset();
    if (tl.autoplay) { tl.play(); }
    return tl;
  };
  return tl;
}

anime.version = '3.0.1';
anime.speed = 1;
anime.running = activeInstances;
anime.remove = removeTargets;
anime.get = getOriginalTargetValue;
anime.set = setTargetsValue;
anime.convertPx = convertPxToUnit;
anime.path = getPath;
anime.setDashoffset = setDashoffset;
anime.stagger = stagger;
anime.timeline = timeline;
anime.easing = parseEasings;
anime.penner = penner;
anime.random = function (min, max) { return Math.floor(Math.random() * (max - min + 1)) + min; };

/* harmony default export */ __webpack_exports__["default"] = (anime);


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