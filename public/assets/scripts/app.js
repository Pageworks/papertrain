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
var App = /** @class */ (function () {
    function App() {
        this.modules = modules;
        this.currentModules = [];
        this.transitionManager = null;
        this.touchSupport = ('ontouchstart' in window) || (navigator.maxTouchPoints > 0) || (navigator.msMaxTouchPoints > 0);
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
        // Check for production debug status
        if (env_1.html.getAttribute('data-debug') !== null) {
            env_1.setDebug(true);
        }
        if (this.touchSupport) {
            env_1.html.classList.add('has-touch');
            env_1.html.classList.remove('has-no-touch');
        }
        window.addEventListener('load', function (e) { env_1.html.classList.add('has-loaded'); });
        window.addEventListener('scroll', function (e) { return _this.handleScroll(); });
        document.addEventListener('seppuku', function (e) { return _this.deleteModule(e); }); // Listen for our custom events
        this.initModules(); // Get initial modules
        this.handleStatus(); // Check the users visitor status
        this.transitionManager = new TransitionManager_1.default(this);
        if (!env_1.isDebug) {
            this.createEasterEgg();
        }
    };
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
     * If the user is scrolling down the page add the scroll delta to
     * the total tracked scroll distance. If the distance passes the
     * trigger distance add the `has-scrolled` status class.
     * If the user scrolled up reset the scroll distance and remove
     * the `has-scrolled` status class.
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
        else {
            env_1.html.classList.add('is-returning');
        }
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
                var newModule = new _this.modules[moduleType].prototype.constructor(module, _this);
                _this.currentModules.push(newModule);
                newModule.init();
            }
            else if (_this.modules[moduleType] === undefined) {
                if (env_1.isDebug) {
                    console.log('%cUndefined Module: ' + ("%c" + moduleType), 'color:#ff6e6e', 'color:#eee');
                }
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
            survivingModules.map(function (survivingModule) {
                if (survivingModule.getAttribute('data-uuid') === currModule.uuid) {
                    survived = true;
                }
            });
            if (!survived) {
                deadModules.push(currModule);
            }
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
            if (env_1.isDebug) {
                console.log('%cDelete Module Error: ' + '%cmodule UUID was not sent in the custom event', 'color:#ff6e6e', 'color:#eee');
            }
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
    ease: [0.4, 0.0, 0.2, 1],
    in: [0.0, 0.0, 0.2, 1],
    out: [0.4, 0.0, 1, 1],
    sharp: [0.4, 0.0, 0.6, 1]
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


/***/ }),

/***/ "./app/scripts/modules/AbstractModule.ts":
/*!***********************************************!*\
  !*** ./app/scripts/modules/AbstractModule.ts ***!
  \***********************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
var v4_1 = __importDefault(__webpack_require__(/*! uuid/v4 */ "./node_modules/uuid/v4.js"));
var AbstractModule = /** @class */ (function () {
    function AbstractModule(el, app) {
        this.el = el; // Sets initial reference to the element that generated the module
        this.uuid = v4_1.default(); // Generates a UUID using UUID v4
        this.app = app;
        this.el.setAttribute('data-uuid', this.uuid); // Sets modules UUID to be used later when handling modules destruction
    }
    AbstractModule.prototype.init = function () {
    };
    /**
     * Acts as the modules self-destruct method, when called the module will be removed from the page
     * Used when removing a specific module, call is initiated by a module
     */
    AbstractModule.prototype.seppuku = function () {
        this.app.deleteModule(this.uuid);
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
var animejs_1 = __importDefault(__webpack_require__(/*! animejs */ "./node_modules/animejs/anime.min.js"));
var BasicAccordion = /** @class */ (function (_super) {
    __extends(BasicAccordion, _super);
    function BasicAccordion(el, app) {
        var _this = _super.call(this, el, app) || this;
        if (env_1.isDebug)
            console.log('%c[module] ' + ("%cBuilding: " + BasicAccordion.MODULE_NAME + " - " + _this.uuid), 'color:#4688f2', 'color:#eee');
        _this.rows = Array.from(_this.el.querySelectorAll('.js-row'));
        _this.headlines = [];
        _this.multiRow = (_this.el.getAttribute('data-single-open') === 'true') ? true : false;
        return _this;
    }
    /**
     * Called when the module is created
     * Used to call any initial methods or to
     * register any initial event listeners
     */
    BasicAccordion.prototype.init = function () {
        var _this = this;
        this.rows.map(function (el) {
            var headline = el.querySelector('.js-headline');
            headline.addEventListener('click', function (e) { return _this.handleToggle(e); });
            _this.headlines.push(headline);
        });
    };
    BasicAccordion.prototype.closeRows = function (rowToClose) {
        if (rowToClose === null)
            return;
        rowToClose.classList.remove('is-open');
        var body = rowToClose.querySelector('.js-body');
        var bodyEls = body.querySelectorAll('*');
        animejs_1.default({
            targets: body,
            duration: 300,
            easing: [0.4, 0.0, 1, 1],
            height: [body.scrollHeight + "px", 0]
        });
        // Hide children
        animejs_1.default({
            targets: bodyEls,
            duration: 75,
            easing: [0.4, 0.0, 1, 1],
            opacity: [1, 0]
        });
    };
    BasicAccordion.prototype.handleToggle = function (e) {
        e.preventDefault();
        var target = e.currentTarget;
        var row = target.parentElement;
        var body = row.querySelector('.js-body');
        var bodyEls = body.querySelectorAll('*');
        if (row.classList.contains('is-open')) {
            row.classList.remove('is-open');
            // Close row
            animejs_1.default({
                targets: body,
                duration: 300,
                easing: [0.4, 0.0, 1, 1],
                height: [body.scrollHeight + "px", 0]
            });
            // Hide children
            animejs_1.default({
                targets: bodyEls,
                duration: 75,
                easing: [0.4, 0.0, 1, 1],
                opacity: [1, 0]
            });
        }
        else {
            if (!this.multiRow) {
                var oldRow = this.el.querySelector('.js-row.is-open');
                this.closeRows(oldRow);
            }
            row.classList.add('is-open');
            // Open row
            animejs_1.default({
                targets: body,
                duration: 300,
                easing: [0.0, 0.0, 0.2, 1],
                height: [0, body.scrollHeight + "px"],
            });
            // Show children
            animejs_1.default({
                targets: bodyEls,
                duration: 150,
                easing: [0.4, 0.0, 1, 1],
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
var getParent_1 = __webpack_require__(/*! ../utils/getParent */ "./app/scripts/utils/getParent.ts");
var BasicForm = /** @class */ (function (_super) {
    __extends(BasicForm, _super);
    function BasicForm(el, app) {
        var _this = _super.call(this, el, app) || this;
        if (env_1.isDebug)
            console.log('%c[module] ' + ("%cBuilding: " + BasicForm.MODULE_NAME + " - " + _this.uuid), 'color:#4688f2', 'color:#eee');
        _this.inputs = _this.el.querySelectorAll('input');
        _this.selects = _this.el.querySelectorAll('select');
        _this.textareas = _this.el.querySelectorAll('textarea');
        _this.passwordToggles = _this.el.querySelectorAll('.js-password-toggle');
        return _this;
    }
    /**
     * Called when the module is created
     * Used to call any initial methods or to
     * register any initial event listeners
     */
    BasicForm.prototype.init = function () {
        var _this = this;
        this.inputs.forEach(function (el) { el.addEventListener('focus', function (e) { return _this.handleFocus(e); }); });
        this.inputs.forEach(function (el) { el.addEventListener('blur', function (e) { return _this.handleBlur(e); }); });
        this.inputs.forEach(function (el) { el.addEventListener('keyup', function (e) { return _this.handleKeystroke(e); }); });
        this.selects.forEach(function (el) { el.addEventListener('change', function (e) { return _this.handleSelection(e); }); });
        this.textareas.forEach(function (el) { el.addEventListener('keyup', function (e) { return _this.handleTextarea(e); }); });
        this.textareas.forEach(function (el) { el.addEventListener('blur', function (e) { return _this.handleTextarea(e); }); });
        this.passwordToggles.forEach(function (el) { el.addEventListener('click', function (e) { return _this.handleToggle(e); }); });
        // Handle input status for prefilled elements
        this.inputs.forEach(function (el) {
            if (el instanceof HTMLInputElement) {
                if (el.value !== '' || el.innerText !== '')
                    _this.handleInputStatus(el);
            }
        });
        // Handle input status for prefilled elements
        this.selects.forEach(function (el) {
            if (el instanceof HTMLSelectElement) {
                if (el.value !== 'any') {
                    var inputWrapper = getParent_1.getParent(el, 'js-input');
                    inputWrapper.classList.add('has-value');
                    inputWrapper.classList.add('is-valid');
                }
            }
        });
    };
    /**
     * Called when a user releases a key while a textarea element has focus.
     * @param {Event} e
     */
    BasicForm.prototype.handleTextarea = function (e) {
        if (e.target instanceof HTMLTextAreaElement) {
            var inputWrapper = getParent_1.getParent(e.target, 'js-input');
            inputWrapper.classList.remove('has-value', 'is-valid', 'is-invalid');
            if (e.target.validity.valid && e.target.value !== '') {
                inputWrapper.classList.add('has-value');
                inputWrapper.classList.add('is-valid');
            }
            else if (!e.target.validity.valid) {
                inputWrapper.classList.add('is-invalid');
                var errorObject = inputWrapper.querySelector('.js-error');
                if (errorObject)
                    errorObject.innerHTML = e.target.validationMessage;
            }
        }
    };
    /**
     * Called when a user selects a different option in the selection dropdown.
     * If the selected option isn't `any` set the `has-value` status class.
     * @param {Event} e
     */
    BasicForm.prototype.handleSelection = function (e) {
        if (e.target instanceof HTMLSelectElement) {
            var inputWrapper = getParent_1.getParent(e.target, 'js-input');
            if (e.target.value === 'any') {
                inputWrapper.classList.remove('has-value', 'is-valid', 'is-invalid');
            }
            else {
                inputWrapper.classList.add('has-value');
                inputWrapper.classList.add('is-valid');
            }
        }
    };
    /**
     * Called when a user clicks on the eye icon for a password or pin input.
     * If the content is hidden we set the inputs type to `text`.
     * If the content isn't hidden we set the inputs type to `password`.
     * @param {Event} e
     */
    BasicForm.prototype.handleToggle = function (e) {
        if (e.target instanceof Element) {
            var inputWrapper = getParent_1.getParent(e.target, 'js-input');
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
        }
    };
    /**
     * Called when we need to make sure an input is valid.
     * If the input has innerText and a value and is valid return true.
     * @param {HTMLInputElement} el input element
     */
    BasicForm.prototype.validityCheck = function (el) {
        var isValid = true;
        if (el.innerText === '' && el.value === '' && el.getAttribute('required') !== null)
            isValid = false;
        else if (!el.validity.valid)
            isValid = false;
        return isValid;
    };
    /**
     * Called whenever a user releases a key while an input is in focus.
     * If the target is an input element and the input was marked as `is-invalid` on the previous blur event
     * we should check if the issue has been fixed. If it has add our `is-valid` class, otherwise, do nothing.
     * @param {Event} e
     */
    BasicForm.prototype.handleKeystroke = function (e) {
        if (e.target instanceof HTMLInputElement) {
            var inputWrapper = getParent_1.getParent(e.target, 'js-input');
            if (inputWrapper.classList.contains('is-invalid')) {
                if (this.validityCheck(e.target)) {
                    inputWrapper.classList.add('is-valid');
                    inputWrapper.classList.remove('is-invalid');
                }
            }
        }
    };
    BasicForm.prototype.handleInputStatus = function (el) {
        var inputWrapper = getParent_1.getParent(el, 'js-input');
        inputWrapper.classList.remove('has-focus');
        inputWrapper.classList.remove('has-value', 'is-valid', 'is-invalid');
        if (this.validityCheck(el)) {
            if (el.value !== '' || el.innerText !== '')
                inputWrapper.classList.add('has-value');
            inputWrapper.classList.add('is-valid');
        }
        else {
            inputWrapper.classList.add('is-invalid');
            var errorObject = inputWrapper.querySelector('.js-error');
            if (errorObject)
                errorObject.innerHTML = el.validationMessage;
        }
    };
    /**
     * Sets the status classes for the input wrapper based on the inputs validity
     * @todo Call on init to check prefilled inputs
     * @see https://developer.mozilla.org/en-US/docs/Web/API/ValidityState
     * @param {Event} e
     */
    BasicForm.prototype.handleBlur = function (e) {
        if (e.target instanceof HTMLInputElement)
            this.handleInputStatus(e.target);
    };
    /**
     * Sets the `has-focus` status class to the inputs wrapper
     * @param {Event} e
     */
    BasicForm.prototype.handleFocus = function (e) {
        var inputWrapper = getParent_1.getParent(e.target, 'js-input');
        inputWrapper.classList.add('has-focus');
    };
    /**
     * Called when the module is destroyed
     * Remove all event listners before calling super.destory()
     */
    BasicForm.prototype.destroy = function () {
        var _this = this;
        this.inputs.forEach(function (el) { el.removeEventListener('focus', function (e) { return _this.handleFocus(e); }); });
        this.inputs.forEach(function (el) { el.removeEventListener('blur', function (e) { return _this.handleBlur(e); }); });
        this.inputs.forEach(function (el) { el.removeEventListener('keyup', function (e) { return _this.handleKeystroke(e); }); });
        this.selects.forEach(function (el) { el.removeEventListener('change', function (e) { return _this.handleSelection(e); }); });
        this.textareas.forEach(function (el) { el.removeEventListener('keyup', function (e) { return _this.handleTextarea(e); }); });
        this.textareas.forEach(function (el) { el.removeEventListener('blur', function (e) { return _this.handleTextarea(e); }); });
        this.passwordToggles.forEach(function (el) { el.removeEventListener('click', function (e) { return _this.handleToggle(e); }); });
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
var animejs_1 = __importDefault(__webpack_require__(/*! animejs */ "./node_modules/animejs/anime.min.js"));
var getParent_1 = __webpack_require__(/*! ../utils/getParent */ "./app/scripts/utils/getParent.ts");
var BasicGallery = /** @class */ (function (_super) {
    __extends(BasicGallery, _super);
    function BasicGallery(el, app) {
        var _this = _super.call(this, el, app) || this;
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
            easing: [0.4, 0.0, 0.2, 1],
            translateX: [0, 100 * -direction + "%"]
        });
        // Show slide
        animejs_1.default({
            targets: newSlide,
            duration: (this.transition * 1000),
            easing: [0.4, 0.0, 0.2, 1],
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
            easing: [0.4, 0.0, 0.2, 1],
            opacity: [1, 0],
            zIndex: 1
        });
        // Show slide
        animejs_1.default({
            targets: newSlide,
            duration: (this.transition * 1000),
            easing: [0.4, 0.0, 0.2, 1],
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
            easing: [0.4, 0.0, 0.2, 1],
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
            easing: [0.4, 0.0, 0.2, 1],
            translateX: [100 * direction + "%", 0],
        });
        // New Image
        animejs_1.default({
            targets: newSlideImg,
            duration: (this.transition * 2000),
            easing: [0.4, 0.0, 0.2, 1],
            translateX: [50 * -direction + "%", 0],
        });
        // Hide slide
        animejs_1.default({
            targets: currSlide,
            duration: (this.transition * 2000),
            easing: [0.4, 0.0, 0.2, 1],
            translateX: [0, 100 * -direction + "%"],
            complete: function () {
                _this.cleanGallery();
            }
        });
        // Old Image
        animejs_1.default({
            targets: currSlideImg,
            duration: (this.transition * 2000),
            easing: [0.4, 0.0, 0.2, 1],
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
var fuel_pjax_1 = __importDefault(__webpack_require__(/*! fuel-pjax */ "./node_modules/fuel-pjax/pjax.js"));
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
        if (env_1.isDebug) {
            console.log('%c[view] ' + ("%cDisplaying: " + templateName), 'color:#ecc653', 'color:#eee');
        }
        env_1.html.classList.add('dom-is-loaded');
        env_1.html.classList.remove('dom-is-loading');
        setTimeout(function () { env_1.html.classList.add('dom-is-animated'); }, this.initialAnimationDelay);
        if (templateName === 'home') {
            env_1.html.classList.add('is-homepage');
        }
        else {
            env_1.html.classList.remove('is-homepage');
        }
        if (this.transition === null) {
            return;
        }
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

/***/ "./node_modules/animejs/anime.min.js":
/*!*******************************************!*\
  !*** ./node_modules/animejs/anime.min.js ***!
  \*******************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

/* WEBPACK VAR INJECTION */(function(global) {var __WEBPACK_AMD_DEFINE_FACTORY__, __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;/*
 2017 Julian Garnier
 Released under the MIT license
*/
var $jscomp={scope:{}};$jscomp.defineProperty="function"==typeof Object.defineProperties?Object.defineProperty:function(e,r,p){if(p.get||p.set)throw new TypeError("ES3 does not support getters and setters.");e!=Array.prototype&&e!=Object.prototype&&(e[r]=p.value)};$jscomp.getGlobal=function(e){return"undefined"!=typeof window&&window===e?e:"undefined"!=typeof global&&null!=global?global:e};$jscomp.global=$jscomp.getGlobal(this);$jscomp.SYMBOL_PREFIX="jscomp_symbol_";
$jscomp.initSymbol=function(){$jscomp.initSymbol=function(){};$jscomp.global.Symbol||($jscomp.global.Symbol=$jscomp.Symbol)};$jscomp.symbolCounter_=0;$jscomp.Symbol=function(e){return $jscomp.SYMBOL_PREFIX+(e||"")+$jscomp.symbolCounter_++};
$jscomp.initSymbolIterator=function(){$jscomp.initSymbol();var e=$jscomp.global.Symbol.iterator;e||(e=$jscomp.global.Symbol.iterator=$jscomp.global.Symbol("iterator"));"function"!=typeof Array.prototype[e]&&$jscomp.defineProperty(Array.prototype,e,{configurable:!0,writable:!0,value:function(){return $jscomp.arrayIterator(this)}});$jscomp.initSymbolIterator=function(){}};$jscomp.arrayIterator=function(e){var r=0;return $jscomp.iteratorPrototype(function(){return r<e.length?{done:!1,value:e[r++]}:{done:!0}})};
$jscomp.iteratorPrototype=function(e){$jscomp.initSymbolIterator();e={next:e};e[$jscomp.global.Symbol.iterator]=function(){return this};return e};$jscomp.array=$jscomp.array||{};$jscomp.iteratorFromArray=function(e,r){$jscomp.initSymbolIterator();e instanceof String&&(e+="");var p=0,m={next:function(){if(p<e.length){var u=p++;return{value:r(u,e[u]),done:!1}}m.next=function(){return{done:!0,value:void 0}};return m.next()}};m[Symbol.iterator]=function(){return m};return m};
$jscomp.polyfill=function(e,r,p,m){if(r){p=$jscomp.global;e=e.split(".");for(m=0;m<e.length-1;m++){var u=e[m];u in p||(p[u]={});p=p[u]}e=e[e.length-1];m=p[e];r=r(m);r!=m&&null!=r&&$jscomp.defineProperty(p,e,{configurable:!0,writable:!0,value:r})}};$jscomp.polyfill("Array.prototype.keys",function(e){return e?e:function(){return $jscomp.iteratorFromArray(this,function(e){return e})}},"es6-impl","es3");var $jscomp$this=this;
(function(e,r){ true?!(__WEBPACK_AMD_DEFINE_ARRAY__ = [], __WEBPACK_AMD_DEFINE_FACTORY__ = (r),
				__WEBPACK_AMD_DEFINE_RESULT__ = (typeof __WEBPACK_AMD_DEFINE_FACTORY__ === 'function' ?
				(__WEBPACK_AMD_DEFINE_FACTORY__.apply(exports, __WEBPACK_AMD_DEFINE_ARRAY__)) : __WEBPACK_AMD_DEFINE_FACTORY__),
				__WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__)):undefined})(this,function(){function e(a){if(!h.col(a))try{return document.querySelectorAll(a)}catch(c){}}function r(a,c){for(var d=a.length,b=2<=arguments.length?arguments[1]:void 0,f=[],n=0;n<d;n++)if(n in a){var k=a[n];c.call(b,k,n,a)&&f.push(k)}return f}function p(a){return a.reduce(function(a,d){return a.concat(h.arr(d)?p(d):d)},[])}function m(a){if(h.arr(a))return a;
h.str(a)&&(a=e(a)||a);return a instanceof NodeList||a instanceof HTMLCollection?[].slice.call(a):[a]}function u(a,c){return a.some(function(a){return a===c})}function C(a){var c={},d;for(d in a)c[d]=a[d];return c}function D(a,c){var d=C(a),b;for(b in a)d[b]=c.hasOwnProperty(b)?c[b]:a[b];return d}function z(a,c){var d=C(a),b;for(b in c)d[b]=h.und(a[b])?c[b]:a[b];return d}function T(a){a=a.replace(/^#?([a-f\d])([a-f\d])([a-f\d])$/i,function(a,c,d,k){return c+c+d+d+k+k});var c=/^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(a);
a=parseInt(c[1],16);var d=parseInt(c[2],16),c=parseInt(c[3],16);return"rgba("+a+","+d+","+c+",1)"}function U(a){function c(a,c,b){0>b&&(b+=1);1<b&&--b;return b<1/6?a+6*(c-a)*b:.5>b?c:b<2/3?a+(c-a)*(2/3-b)*6:a}var d=/hsl\((\d+),\s*([\d.]+)%,\s*([\d.]+)%\)/g.exec(a)||/hsla\((\d+),\s*([\d.]+)%,\s*([\d.]+)%,\s*([\d.]+)\)/g.exec(a);a=parseInt(d[1])/360;var b=parseInt(d[2])/100,f=parseInt(d[3])/100,d=d[4]||1;if(0==b)f=b=a=f;else{var n=.5>f?f*(1+b):f+b-f*b,k=2*f-n,f=c(k,n,a+1/3),b=c(k,n,a);a=c(k,n,a-1/3)}return"rgba("+
255*f+","+255*b+","+255*a+","+d+")"}function y(a){if(a=/([\+\-]?[0-9#\.]+)(%|px|pt|em|rem|in|cm|mm|ex|ch|pc|vw|vh|vmin|vmax|deg|rad|turn)?$/.exec(a))return a[2]}function V(a){if(-1<a.indexOf("translate")||"perspective"===a)return"px";if(-1<a.indexOf("rotate")||-1<a.indexOf("skew"))return"deg"}function I(a,c){return h.fnc(a)?a(c.target,c.id,c.total):a}function E(a,c){if(c in a.style)return getComputedStyle(a).getPropertyValue(c.replace(/([a-z])([A-Z])/g,"$1-$2").toLowerCase())||"0"}function J(a,c){if(h.dom(a)&&
u(W,c))return"transform";if(h.dom(a)&&(a.getAttribute(c)||h.svg(a)&&a[c]))return"attribute";if(h.dom(a)&&"transform"!==c&&E(a,c))return"css";if(null!=a[c])return"object"}function X(a,c){var d=V(c),d=-1<c.indexOf("scale")?1:0+d;a=a.style.transform;if(!a)return d;for(var b=[],f=[],n=[],k=/(\w+)\((.+?)\)/g;b=k.exec(a);)f.push(b[1]),n.push(b[2]);a=r(n,function(a,b){return f[b]===c});return a.length?a[0]:d}function K(a,c){switch(J(a,c)){case "transform":return X(a,c);case "css":return E(a,c);case "attribute":return a.getAttribute(c)}return a[c]||
0}function L(a,c){var d=/^(\*=|\+=|-=)/.exec(a);if(!d)return a;var b=y(a)||0;c=parseFloat(c);a=parseFloat(a.replace(d[0],""));switch(d[0][0]){case "+":return c+a+b;case "-":return c-a+b;case "*":return c*a+b}}function F(a,c){return Math.sqrt(Math.pow(c.x-a.x,2)+Math.pow(c.y-a.y,2))}function M(a){a=a.points;for(var c=0,d,b=0;b<a.numberOfItems;b++){var f=a.getItem(b);0<b&&(c+=F(d,f));d=f}return c}function N(a){if(a.getTotalLength)return a.getTotalLength();switch(a.tagName.toLowerCase()){case "circle":return 2*
Math.PI*a.getAttribute("r");case "rect":return 2*a.getAttribute("width")+2*a.getAttribute("height");case "line":return F({x:a.getAttribute("x1"),y:a.getAttribute("y1")},{x:a.getAttribute("x2"),y:a.getAttribute("y2")});case "polyline":return M(a);case "polygon":var c=a.points;return M(a)+F(c.getItem(c.numberOfItems-1),c.getItem(0))}}function Y(a,c){function d(b){b=void 0===b?0:b;return a.el.getPointAtLength(1<=c+b?c+b:0)}var b=d(),f=d(-1),n=d(1);switch(a.property){case "x":return b.x;case "y":return b.y;
case "angle":return 180*Math.atan2(n.y-f.y,n.x-f.x)/Math.PI}}function O(a,c){var d=/-?\d*\.?\d+/g,b;b=h.pth(a)?a.totalLength:a;if(h.col(b))if(h.rgb(b)){var f=/rgb\((\d+,\s*[\d]+,\s*[\d]+)\)/g.exec(b);b=f?"rgba("+f[1]+",1)":b}else b=h.hex(b)?T(b):h.hsl(b)?U(b):void 0;else f=(f=y(b))?b.substr(0,b.length-f.length):b,b=c&&!/\s/g.test(b)?f+c:f;b+="";return{original:b,numbers:b.match(d)?b.match(d).map(Number):[0],strings:h.str(a)||c?b.split(d):[]}}function P(a){a=a?p(h.arr(a)?a.map(m):m(a)):[];return r(a,
function(a,d,b){return b.indexOf(a)===d})}function Z(a){var c=P(a);return c.map(function(a,b){return{target:a,id:b,total:c.length}})}function aa(a,c){var d=C(c);if(h.arr(a)){var b=a.length;2!==b||h.obj(a[0])?h.fnc(c.duration)||(d.duration=c.duration/b):a={value:a}}return m(a).map(function(a,b){b=b?0:c.delay;a=h.obj(a)&&!h.pth(a)?a:{value:a};h.und(a.delay)&&(a.delay=b);return a}).map(function(a){return z(a,d)})}function ba(a,c){var d={},b;for(b in a){var f=I(a[b],c);h.arr(f)&&(f=f.map(function(a){return I(a,
c)}),1===f.length&&(f=f[0]));d[b]=f}d.duration=parseFloat(d.duration);d.delay=parseFloat(d.delay);return d}function ca(a){return h.arr(a)?A.apply(this,a):Q[a]}function da(a,c){var d;return a.tweens.map(function(b){b=ba(b,c);var f=b.value,e=K(c.target,a.name),k=d?d.to.original:e,k=h.arr(f)?f[0]:k,w=L(h.arr(f)?f[1]:f,k),e=y(w)||y(k)||y(e);b.from=O(k,e);b.to=O(w,e);b.start=d?d.end:a.offset;b.end=b.start+b.delay+b.duration;b.easing=ca(b.easing);b.elasticity=(1E3-Math.min(Math.max(b.elasticity,1),999))/
1E3;b.isPath=h.pth(f);b.isColor=h.col(b.from.original);b.isColor&&(b.round=1);return d=b})}function ea(a,c){return r(p(a.map(function(a){return c.map(function(b){var c=J(a.target,b.name);if(c){var d=da(b,a);b={type:c,property:b.name,animatable:a,tweens:d,duration:d[d.length-1].end,delay:d[0].delay}}else b=void 0;return b})})),function(a){return!h.und(a)})}function R(a,c,d,b){var f="delay"===a;return c.length?(f?Math.min:Math.max).apply(Math,c.map(function(b){return b[a]})):f?b.delay:d.offset+b.delay+
b.duration}function fa(a){var c=D(ga,a),d=D(S,a),b=Z(a.targets),f=[],e=z(c,d),k;for(k in a)e.hasOwnProperty(k)||"targets"===k||f.push({name:k,offset:e.offset,tweens:aa(a[k],d)});a=ea(b,f);return z(c,{children:[],animatables:b,animations:a,duration:R("duration",a,c,d),delay:R("delay",a,c,d)})}function q(a){function c(){return window.Promise&&new Promise(function(a){return p=a})}function d(a){return g.reversed?g.duration-a:a}function b(a){for(var b=0,c={},d=g.animations,f=d.length;b<f;){var e=d[b],
k=e.animatable,h=e.tweens,n=h.length-1,l=h[n];n&&(l=r(h,function(b){return a<b.end})[0]||l);for(var h=Math.min(Math.max(a-l.start-l.delay,0),l.duration)/l.duration,w=isNaN(h)?1:l.easing(h,l.elasticity),h=l.to.strings,p=l.round,n=[],m=void 0,m=l.to.numbers.length,t=0;t<m;t++){var x=void 0,x=l.to.numbers[t],q=l.from.numbers[t],x=l.isPath?Y(l.value,w*x):q+w*(x-q);p&&(l.isColor&&2<t||(x=Math.round(x*p)/p));n.push(x)}if(l=h.length)for(m=h[0],w=0;w<l;w++)p=h[w+1],t=n[w],isNaN(t)||(m=p?m+(t+p):m+(t+" "));
else m=n[0];ha[e.type](k.target,e.property,m,c,k.id);e.currentValue=m;b++}if(b=Object.keys(c).length)for(d=0;d<b;d++)H||(H=E(document.body,"transform")?"transform":"-webkit-transform"),g.animatables[d].target.style[H]=c[d].join(" ");g.currentTime=a;g.progress=a/g.duration*100}function f(a){if(g[a])g[a](g)}function e(){g.remaining&&!0!==g.remaining&&g.remaining--}function k(a){var k=g.duration,n=g.offset,w=n+g.delay,r=g.currentTime,x=g.reversed,q=d(a);if(g.children.length){var u=g.children,v=u.length;
if(q>=g.currentTime)for(var G=0;G<v;G++)u[G].seek(q);else for(;v--;)u[v].seek(q)}if(q>=w||!k)g.began||(g.began=!0,f("begin")),f("run");if(q>n&&q<k)b(q);else if(q<=n&&0!==r&&(b(0),x&&e()),q>=k&&r!==k||!k)b(k),x||e();f("update");a>=k&&(g.remaining?(t=h,"alternate"===g.direction&&(g.reversed=!g.reversed)):(g.pause(),g.completed||(g.completed=!0,f("complete"),"Promise"in window&&(p(),m=c()))),l=0)}a=void 0===a?{}:a;var h,t,l=0,p=null,m=c(),g=fa(a);g.reset=function(){var a=g.direction,c=g.loop;g.currentTime=
0;g.progress=0;g.paused=!0;g.began=!1;g.completed=!1;g.reversed="reverse"===a;g.remaining="alternate"===a&&1===c?2:c;b(0);for(a=g.children.length;a--;)g.children[a].reset()};g.tick=function(a){h=a;t||(t=h);k((l+h-t)*q.speed)};g.seek=function(a){k(d(a))};g.pause=function(){var a=v.indexOf(g);-1<a&&v.splice(a,1);g.paused=!0};g.play=function(){g.paused&&(g.paused=!1,t=0,l=d(g.currentTime),v.push(g),B||ia())};g.reverse=function(){g.reversed=!g.reversed;t=0;l=d(g.currentTime)};g.restart=function(){g.pause();
g.reset();g.play()};g.finished=m;g.reset();g.autoplay&&g.play();return g}var ga={update:void 0,begin:void 0,run:void 0,complete:void 0,loop:1,direction:"normal",autoplay:!0,offset:0},S={duration:1E3,delay:0,easing:"easeOutElastic",elasticity:500,round:0},W="translateX translateY translateZ rotate rotateX rotateY rotateZ scale scaleX scaleY scaleZ skewX skewY perspective".split(" "),H,h={arr:function(a){return Array.isArray(a)},obj:function(a){return-1<Object.prototype.toString.call(a).indexOf("Object")},
pth:function(a){return h.obj(a)&&a.hasOwnProperty("totalLength")},svg:function(a){return a instanceof SVGElement},dom:function(a){return a.nodeType||h.svg(a)},str:function(a){return"string"===typeof a},fnc:function(a){return"function"===typeof a},und:function(a){return"undefined"===typeof a},hex:function(a){return/(^#[0-9A-F]{6}$)|(^#[0-9A-F]{3}$)/i.test(a)},rgb:function(a){return/^rgb/.test(a)},hsl:function(a){return/^hsl/.test(a)},col:function(a){return h.hex(a)||h.rgb(a)||h.hsl(a)}},A=function(){function a(a,
d,b){return(((1-3*b+3*d)*a+(3*b-6*d))*a+3*d)*a}return function(c,d,b,f){if(0<=c&&1>=c&&0<=b&&1>=b){var e=new Float32Array(11);if(c!==d||b!==f)for(var k=0;11>k;++k)e[k]=a(.1*k,c,b);return function(k){if(c===d&&b===f)return k;if(0===k)return 0;if(1===k)return 1;for(var h=0,l=1;10!==l&&e[l]<=k;++l)h+=.1;--l;var l=h+(k-e[l])/(e[l+1]-e[l])*.1,n=3*(1-3*b+3*c)*l*l+2*(3*b-6*c)*l+3*c;if(.001<=n){for(h=0;4>h;++h){n=3*(1-3*b+3*c)*l*l+2*(3*b-6*c)*l+3*c;if(0===n)break;var m=a(l,c,b)-k,l=l-m/n}k=l}else if(0===
n)k=l;else{var l=h,h=h+.1,g=0;do m=l+(h-l)/2,n=a(m,c,b)-k,0<n?h=m:l=m;while(1e-7<Math.abs(n)&&10>++g);k=m}return a(k,d,f)}}}}(),Q=function(){function a(a,b){return 0===a||1===a?a:-Math.pow(2,10*(a-1))*Math.sin(2*(a-1-b/(2*Math.PI)*Math.asin(1))*Math.PI/b)}var c="Quad Cubic Quart Quint Sine Expo Circ Back Elastic".split(" "),d={In:[[.55,.085,.68,.53],[.55,.055,.675,.19],[.895,.03,.685,.22],[.755,.05,.855,.06],[.47,0,.745,.715],[.95,.05,.795,.035],[.6,.04,.98,.335],[.6,-.28,.735,.045],a],Out:[[.25,
.46,.45,.94],[.215,.61,.355,1],[.165,.84,.44,1],[.23,1,.32,1],[.39,.575,.565,1],[.19,1,.22,1],[.075,.82,.165,1],[.175,.885,.32,1.275],function(b,c){return 1-a(1-b,c)}],InOut:[[.455,.03,.515,.955],[.645,.045,.355,1],[.77,0,.175,1],[.86,0,.07,1],[.445,.05,.55,.95],[1,0,0,1],[.785,.135,.15,.86],[.68,-.55,.265,1.55],function(b,c){return.5>b?a(2*b,c)/2:1-a(-2*b+2,c)/2}]},b={linear:A(.25,.25,.75,.75)},f={},e;for(e in d)f.type=e,d[f.type].forEach(function(a){return function(d,f){b["ease"+a.type+c[f]]=h.fnc(d)?
d:A.apply($jscomp$this,d)}}(f)),f={type:f.type};return b}(),ha={css:function(a,c,d){return a.style[c]=d},attribute:function(a,c,d){return a.setAttribute(c,d)},object:function(a,c,d){return a[c]=d},transform:function(a,c,d,b,f){b[f]||(b[f]=[]);b[f].push(c+"("+d+")")}},v=[],B=0,ia=function(){function a(){B=requestAnimationFrame(c)}function c(c){var b=v.length;if(b){for(var d=0;d<b;)v[d]&&v[d].tick(c),d++;a()}else cancelAnimationFrame(B),B=0}return a}();q.version="2.2.0";q.speed=1;q.running=v;q.remove=
function(a){a=P(a);for(var c=v.length;c--;)for(var d=v[c],b=d.animations,f=b.length;f--;)u(a,b[f].animatable.target)&&(b.splice(f,1),b.length||d.pause())};q.getValue=K;q.path=function(a,c){var d=h.str(a)?e(a)[0]:a,b=c||100;return function(a){return{el:d,property:a,totalLength:N(d)*(b/100)}}};q.setDashoffset=function(a){var c=N(a);a.setAttribute("stroke-dasharray",c);return c};q.bezier=A;q.easings=Q;q.timeline=function(a){var c=q(a);c.pause();c.duration=0;c.add=function(d){c.children.forEach(function(a){a.began=
!0;a.completed=!0});m(d).forEach(function(b){var d=z(b,D(S,a||{}));d.targets=d.targets||a.targets;b=c.duration;var e=d.offset;d.autoplay=!1;d.direction=c.direction;d.offset=h.und(e)?b:L(e,b);c.began=!0;c.completed=!0;c.seek(d.offset);d=q(d);d.began=!0;d.completed=!0;d.duration>b&&(c.duration=d.duration);c.children.push(d)});c.seek(0);c.reset();c.autoplay&&c.restart();return c};return c};q.random=function(a,c){return Math.floor(Math.random()*(c-a+1))+a};return q});
/* WEBPACK VAR INJECTION */}.call(this, __webpack_require__(/*! ./../webpack/buildin/global.js */ "./node_modules/webpack/buildin/global.js")))

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
    on_1.default(el, 'mouseenter', function (e) { handleHover(el, e, pjax); });
    on_1.default(el, 'mouseleave', function (e) { handleHover(el, e, pjax); });
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
        if (this.options.debug) {
            console.log('Cached content has a non-200 response but we require a success response, fallback loading uri ', uri);
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

/***/ "./node_modules/webpack/buildin/global.js":
/*!***********************************!*\
  !*** (webpack)/buildin/global.js ***!
  \***********************************/
/*! no static exports found */
/***/ (function(module, exports) {

var g;

// This works in non-strict mode
g = (function() {
	return this;
})();

try {
	// This works if eval is allowed (see CSP)
	g = g || new Function("return this")();
} catch (e) {
	// This works if the window reference is available
	if (typeof window === "object") g = window;
}

// g can still be undefined, but nothing to do about it...
// We return undefined, instead of nothing here, so it's
// easier to handle this case. if(!global) { ...}

module.exports = g;


/***/ }),

/***/ 0:
/*!*******************************************************!*\
  !*** multi ./app/scripts/App.ts ./app/sass/main.scss ***!
  \*******************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

__webpack_require__(/*! /Users/andrewsk/Documents/projects/papertrain/app/scripts/App.ts */"./app/scripts/App.ts");
module.exports = __webpack_require__(/*! /Users/andrewsk/Documents/projects/papertrain/app/sass/main.scss */"./app/sass/main.scss");


/***/ })

/******/ });
//# sourceMappingURL=app.js.map