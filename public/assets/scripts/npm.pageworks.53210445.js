(window["webpackJsonp"] = window["webpackJsonp"] || []).push([[5],[
/* 0 */,
/* 1 */,
/* 2 */,
/* 3 */,
/* 4 */,
/* 5 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
var DeviceManager = /** @class */ (function () {
    function DeviceManager(debug, setStatusClasses) {
        var _this = this;
        /**
         * Called when the `touchstart` event fires on an element that has a `js-touch` class.
         */
        this.userTouchedElement = function (e) {
            var target = e.currentTarget;
            target.classList.add('is-touching');
        };
        /**
         * Called when the `touchend` or `touchcancel` or `touchleave` event(s) fire on
         * an element with the `js-touch` class.
         */
        this.userReleasedTouchedElement = function (e) {
            var target = e.currentTarget;
            target.classList.remove('is-touching');
        };
        /**
         * Called when the `change` event is fired on `NetworkInformation`.
         * @see https://developer.mozilla.org/en-US/docs/Web/API/NetworkInformation#Event_handlers
         */
        this.handleConnectionChange = function (e) {
            _this._navigator = window.navigator;
            // @ts-ignore
            DeviceManager.connection = _this._navigator.connection || _this._navigator.mozConnection || _this._navigator.webkitConnection;
        };
        /**
         * Called when the `mouseover` event is fired on the body.
         * Sets a status class confirming that the user is using a pointer device (mouse).
         */
        this.handleMouseEvent = function (e) {
            _this._body.removeEventListener('mouseover', _this.handleMouseEvent);
            _this._html.classList.add('is-pointer-device');
            _this._html.classList.remove('is-not-pointer-device');
            if (_this._isDebug) {
                console.log('%c[Device Manager] ' + "%cUser is using a pointer device", 'color:#35ffb8', 'color:#eee');
            }
        };
        /**
         * Called when the `touchstart` event is fired on the body.
         * Sets a status class confirming that the user is using touch input.
         */
        this.handleTouchEvent = function (e) {
            _this._body.removeEventListener('touchstart', _this.handleTouchEvent);
            _this._html.classList.add('has-touched');
            if (_this._isDebug) {
                console.log('%c[Device Manager] ' + "%cUser has touched their device", 'color:#35ffb8', 'color:#eee');
            }
        };
        this._isDebug = (debug) ? debug : false;
        this._html = document.documentElement;
        this._body = document.body;
        this._navigator = window.navigator;
        // @ts-ignore
        DeviceManager.connection = this._navigator.connection || this._navigator.mozConnection || this._navigator.webkitConnection;
        DeviceManager.connection.addEventListener('change', this.handleConnectionChange);
        if (setStatusClasses) {
            this.setStatusClasses();
        }
        this._trackedElements = [];
        this.getTouchElements();
    }
    /**
     * Called when the page has changed and `DeviceManager` needs to handle the new/old touch tracked elements.
     */
    DeviceManager.prototype.reinit = function () {
        this.purgeTouchElements();
        this.getTouchElements();
    };
    /**
     * Get all the elements that require touch tracking if they're not already tracked.
     */
    DeviceManager.prototype.getTouchElements = function () {
        var _this = this;
        // Do nothing on non-touch devices
        if (!DeviceManager.supportsTouch) {
            return;
        }
        // Create an array of elements with the `.js-touch` class if they're not already tracked
        var elements = Array.from(document.body.querySelectorAll('.js-touch:not([data-touch-tracked="true"])'));
        elements.forEach(function (el) {
            // Sets tracking attribute
            el.setAttribute('data-touch-tracked', 'true');
            // Sets event listeners
            el.addEventListener('touchstart', _this.userTouchedElement);
            el.addEventListener('touchend', _this.userReleasedTouchedElement);
            el.addEventListener('touchleave', _this.userReleasedTouchedElement);
            el.addEventListener('touchcancel', _this.userReleasedTouchedElement);
            // Places element in the arrray
            _this._trackedElements.push(el);
        });
    };
    /**
     * Grabs all the current touch elements and removes any that are missing in the DOM.
     */
    DeviceManager.prototype.purgeTouchElements = function () {
        // Do nothing on non-touch devices
        if (!DeviceManager.supportsTouch) {
            return;
        }
        // Check if there are elements to check
        if (this._trackedElements.length === 0) {
            return;
        }
        var currentElements = Array.from(document.body.querySelectorAll('.js-touch'));
        var deadElements = [];
        // Loop through all tracked touch elements
        for (var i = 0; i < this._trackedElements.length; i++) {
            var survived = false;
            // Compare aginst all current touch elements
            for (var k = 0; k < currentElements.length; k++) {
                if (this._trackedElements[i] === currentElements[k]) {
                    survived = true;
                }
            }
            // Prepare dead elements for the purge
            if (!survived) {
                deadElements.push(this._trackedElements[i]);
            }
        }
        // Verify we have elements to remove
        if (deadElements.length !== 0) {
            // Loop though all the elements we need to remove
            for (var k = 0; k < deadElements.length; k++) {
                // Loop through all the current elements
                for (var i = 0; i < this._trackedElements.length; i++) {
                    // Check if the current element matches the element marked for death
                    if (this._trackedElements[i] === deadElements[i]) {
                        // Remove event listeners
                        deadElements[i].removeEventListener('touchstart', this.userTouchedElement);
                        deadElements[i].removeEventListener('touchend', this.userReleasedTouchedElement);
                        deadElements[i].removeEventListener('touchleave', this.userReleasedTouchedElement);
                        deadElements[i].removeEventListener('touchcancel', this.userReleasedTouchedElement);
                        // Get the elements index
                        var index = this._trackedElements.indexOf(this._trackedElements[i]);
                        // Splice the array at the index and shift the remaining elements
                        this._trackedElements.splice(index, 1);
                    }
                }
            }
        }
    };
    /**
     * Sets custom status classes on the HTML Document.
     */
    DeviceManager.prototype.setStatusClasses = function () {
        this._html.classList.add('has-js');
        this._html.classList.remove('has-no-js');
        if (this._isDebug) {
            console.log('%c[Device Manager] ' + "%cSetting status classes", 'color:#35ffb8', 'color:#eee');
        }
        // Listen for basic device event types
        this._body.addEventListener('mouseover', this.handleMouseEvent);
        this._body.addEventListener('touchstart', this.handleTouchEvent);
        // Set a status class if the device supports touch
        if (DeviceManager.supportsTouch) {
            this._html.classList.add('is-touch-device');
            this._html.classList.remove('is-not-touch-device');
            if (this._isDebug) {
                console.log('%c[Device Manager] ' + ("%cSupports Touch: %c" + DeviceManager.supportsTouch), 'color:#35ffb8', 'color:#eee', 'color:#68e5ff');
            }
        }
        // Sets a status class if the browser is using the Blink engine
        if (DeviceManager.isBlinkEngine) {
            this._html.classList.add('is-blink');
            if (this._isDebug) {
                console.log('%c[Device Manager] ' + ("%cUsing Blink Engine: %c" + DeviceManager.isBlinkEngine), 'color:#35ffb8', 'color:#eee', 'color:#68e5ff');
            }
        }
        // Sets a status class if the browser is Chrome
        if (DeviceManager.isChrome) {
            this._html.classList.add('is-chrome');
            if (this._isDebug) {
                console.log('%c[Device Manager] ' + ("%cChrome: %c" + DeviceManager.isChrome), 'color:#35ffb8', 'color:#eee', 'color:#68e5ff');
            }
        }
        // Sets a status class if the browser is IE 11
        if (DeviceManager.isIE) {
            this._html.classList.add('is-ie');
            if (this._isDebug) {
                console.log('%c[Device Manager] ' + ("%cInternet Explorer: %c" + DeviceManager.isIE), 'color:#35ffb8', 'color:#eee', 'color:#68e5ff');
            }
        }
        // Sets a status class if the browser is Edge
        if (DeviceManager.isEdge) {
            this._html.classList.add('is-edge');
            if (this._isDebug) {
                console.log('%c[Device Manager] ' + ("%cEdge: %c" + DeviceManager.isEdge), 'color:#35ffb8', 'color:#eee', 'color:#68e5ff');
            }
        }
        // Sets a status class if the browser is Firefox
        if (DeviceManager.isFirefox) {
            this._html.classList.add('is-firefox');
            if (this._isDebug) {
                console.log('%c[Device Manager] ' + ("%cFirefox: %c" + DeviceManager.isFirefox), 'color:#35ffb8', 'color:#eee', 'color:#68e5ff');
            }
        }
        // Sets a status class if the browser is Safari
        if (DeviceManager.isSafari) {
            this._html.classList.add('is-safari');
            if (this._isDebug) {
                console.log('%c[Device Manager] ' + ("%cSafari: %c" + DeviceManager.isSafari), 'color:#35ffb8', 'color:#eee', 'color:#68e5ff');
            }
        }
        // Sets a status class if the browser is Opera
        if (DeviceManager.isOpera) {
            this._html.classList.add('is-opera');
            if (this._isDebug) {
                console.log('%c[Device Manager] ' + ("%cOpera: %c" + DeviceManager.isOpera), 'color:#35ffb8', 'color:#eee', 'color:#68e5ff');
            }
        }
        // Sets a status class if the device's connection type is known
        if (DeviceManager.connection !== undefined) {
            this._html.classList.add("is-" + DeviceManager.connection.effectiveType);
            if (this._isDebug) {
                console.log('%c[Device Manager] ' + ("%cConnection Type: %c" + DeviceManager.connection.effectiveType), 'color:#35ffb8', 'color:#eee', 'color:#68e5ff');
            }
        }
    };
    DeviceManager.connection = undefined;
    /**
     * Checks if the browser is Chrome 1 - 71.
     * @returns `boolean`
     */
    DeviceManager.isChrome = (function () {
        var isChrome = false;
        // @ts-ignore
        if (!!window.chrome && (window.StyleMedia === undefined)) {
            isChrome = true;
        }
        return isChrome;
    })();
    /**
     * Checks if the browser is Edge 20+.
     * @returns `boolean`
     */
    DeviceManager.isEdge = (function () {
        var isEdge = false;
        // @ts-ignore
        if (!!window.StyleMedia && !!window.chrome) {
            isEdge = true;
        }
        return isEdge;
    })();
    /**
     * Checks if the browser is Internet Explorer 6 - 11.
     * @returns `boolean`
     */
    DeviceManager.isIE = (function () {
        var isIE = false;
        // @ts-ignore
        if (!!window.MSInputMethodContext && !!document.documentMode && (window.chrome === undefined)) {
            isIE = true;
        }
        return isIE;
    })();
    /**
     * Checks if the browser is Firefox 1+.
     * @returns `boolean`
     */
    DeviceManager.isFirefox = (function () {
        var isFirefox = false;
        // @ts-ignore
        if (typeof InstallTrigger !== 'undefined') {
            isFirefox = true;
        }
        return isFirefox;
    })();
    /**
     * Checks if the browser is Safari 3+.
     * @returns `boolean`
     */
    DeviceManager.isSafari = (function () {
        var isSafari = false;
        // @ts-ignore
        if (/constructor/i.test(window.HTMLElement) || (function (p) { return p.toString() === "[object SafariRemoteNotification]"; })(!window['safari'] || (typeof safari !== 'undefined' && safari.pushNotification))) {
            isSafari = true;
        }
        return isSafari;
    })();
    /**
     * Checks if the browser is Opera 8+.
     * @returns `boolean`
     */
    DeviceManager.isOpera = (function () {
        var isOpera = false;
        // @ts-ignore
        if ((!!window.opr && !!opr.addons) || !!window.opera || navigator.userAgent.indexOf(' OPR/') >= 0) {
            isOpera = true;
        }
        return isOpera;
    })();
    /**
     * Checks if the browser is using the Blink Engine.
     * @see https://en.wikipedia.org/wiki/Blink_(browser_engine)
     * @returns `boolean`
     */
    DeviceManager.isBlinkEngine = (function () {
        var isBlink = false;
        // @ts-ignore
        if ((DeviceManager.isChrome || DeviceManager.isOpera) && !!window.CSS) {
            isBlink = true;
        }
        return isBlink;
    })();
    /**
     * Checks if the browser supports touch input.
     * @returns `boolean`
     */
    DeviceManager.supportsTouch = (function () {
        var isTouchSupported = false;
        if (('ontouchstart' in window) || (navigator.maxTouchPoints > 0) || (navigator.msMaxTouchPoints > 0)) {
            isTouchSupported = true;
        }
        return isTouchSupported;
    })();
    return DeviceManager;
}());
exports.default = DeviceManager;
//# sourceMappingURL=DeviceManager.js.map

/***/ }),
/* 6 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : new P(function (resolve) { resolve(result.value); }).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (_) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
Object.defineProperty(exports, "__esModule", { value: true });
var parse_options_1 = __webpack_require__(7);
var trigger_1 = __webpack_require__(8);
var parse_dom_1 = __webpack_require__(9);
var scroll_1 = __webpack_require__(14);
var clear_active_1 = __webpack_require__(15);
var state_manager_1 = __webpack_require__(16);
var device_manager_1 = __webpack_require__(18);
var Pjax = (function () {
    function Pjax(options) {
        var _this = this;
        this.handleManualLoad = function (e) {
            var uri = e.detail.uri;
            if (_this.options.debug) {
                console.log('%c[Pjax] ' + ("%cmanually loading " + uri), 'color:#f3ff35', 'color:#eee');
            }
            _this.doRequest(uri);
        };
        this.handlePopstate = function (e) {
            if (e.state) {
                if (_this.options.debug) {
                    console.log('%c[Pjax] ' + "%chijacking popstate event", 'color:#f3ff35', 'color:#eee');
                }
                _this._scrollTo = e.state.scrollPos;
                _this.loadUrl(e.state.uri, 'popstate');
            }
        };
        this.handleContinue = function (e) {
            if (_this._cachedSwitch !== null) {
                if (_this.options.titleSwitch) {
                    document.title = _this._cachedSwitch.title;
                }
                _this.handleSwitches(_this._cachedSwitch.queue);
            }
            else {
                if (_this.options.debug) {
                    console.log('%c[Pjax] ' + "%cswitch queue was empty. You might be sending pjax:continue early", 'color:#f3ff35', 'color:#eee');
                }
                trigger_1.default(document, ['pjax:error']);
            }
        };
        this._dom = document.documentElement;
        if (device_manager_1.default.isIE) {
            console.log('%c[Pjax] ' + "%cIE 11 detected - Pjax aborted", 'color:#f3ff35', 'color:#eee');
            this._dom.classList.remove('dom-is-loading');
            this._dom.classList.add('dom-is-loaded');
            return;
        }
        this._cache = null;
        this.options = parse_options_1.default(options);
        this._request = null;
        this._response = null;
        this._confirmed = false;
        this._cachedSwitch = null;
        this._scrollTo = { x: 0, y: 0 };
        this._isPushstate = true;
        this._scriptsToAppend = [];
        this._requestId = 0;
        this.init();
    }
    Pjax.prototype.init = function () {
        if (this.options.debug) {
            console.group();
            console.log('%c[Pjax] ' + ("%cinitializing Pjax version " + Pjax.VERSION), 'color:#f3ff35', 'color:#eee');
            console.log('%c[Pjax] ' + "%cview Pjax documentation at http://papertrain.io/pjax", 'color:#f3ff35', 'color:#eee');
            console.log('%c[Pjax] ' + "%cloaded with the following options: ", 'color:#f3ff35', 'color:#eee');
            console.log(this.options);
            console.groupEnd();
        }
        this._dom.classList.add('dom-is-loaded');
        this._dom.classList.remove('dom-is-loading');
        new state_manager_1.default(this.options.debug, true);
        window.addEventListener('popstate', this.handlePopstate);
        if (this.options.customTransitions) {
            document.addEventListener('pjax:continue', this.handleContinue);
        }
        document.addEventListener('pjax:load', this.handleManualLoad);
        parse_dom_1.default(document.body, this);
    };
    Pjax.prototype.loadUrl = function (href, loadType) {
        if (this._confirmed) {
            return;
        }
        this.abortRequest();
        this._cache = null;
        this.handleLoad(href, loadType);
    };
    Pjax.prototype.abortRequest = function () {
        this._request = null;
        this._response = null;
    };
    Pjax.prototype.finalize = function () {
        if (this.options.debug) {
            console.log('%c[Pjax] ' + "%cpage transition completed", 'color:#f3ff35', 'color:#eee');
        }
        scroll_1.default(this._scrollTo);
        if (this.options.history) {
            if (this._isPushstate) {
                state_manager_1.default.doPush(this._response.url, document.title);
            }
            else {
                state_manager_1.default.doReplace(this._response.url, document.title);
            }
        }
        trigger_1.default(document, ['pjax:complete']);
        if (!this._scriptsToAppend.length) {
            if (this.options.debug) {
                console.log('%c[Pjax] ' + "%cNo new scripts to load", 'color:#f3ff35', 'color:#eee');
                trigger_1.default(document, ['pjax:scriptContentLoaded']);
            }
        }
        this._dom.classList.add('dom-is-loaded');
        this._dom.classList.remove('dom-is-loading');
        this._cache = null;
        this._request = null;
        this._response = null;
        this._cachedSwitch = null;
        this._isPushstate = true;
        this._scrollTo = { x: 0, y: 0 };
        this._confirmed = false;
    };
    Pjax.prototype.handleSwitches = function (switchQueue) {
        for (var i = 0; i < switchQueue.length; i++) {
            switchQueue[i].current.innerHTML = switchQueue[i].new.innerHTML;
            parse_dom_1.default(switchQueue[i].current, this);
        }
        this.finalize();
    };
    Pjax.prototype.switchSelectors = function (selectors, tempDocument) {
        var _this = this;
        if (tempDocument === null) {
            if (this.options.debug) {
                console.log('%c[Pjax] ' + ("%ctemporary document was null, telling the browser to load " + ((this._cache !== null) ? this._cache.url : this._response.url)), 'color:#f3ff35', 'color:#eee');
            }
            if (this._cache !== null) {
                this.lastChance(this._cache.url);
            }
            else {
                this.lastChance(this._response.url);
            }
            return;
        }
        if (!this.options.importScripts) {
            var newScripts = Array.from(tempDocument.querySelectorAll('script'));
            if (newScripts.length) {
                var currentScripts_1 = Array.from(document.querySelectorAll('script'));
                newScripts.forEach(function (newScript) {
                    var isNewScript = true;
                    currentScripts_1.forEach(function (currentScript) {
                        if (newScript.src === currentScript.src) {
                            isNewScript = false;
                        }
                    });
                    if (isNewScript) {
                        if (_this.options.debug) {
                            console.log('%c[Pjax] ' + "%cthe new page contains scripts", 'color:#f3ff35', 'color:#eee');
                        }
                        _this.lastChance(_this._response.url);
                    }
                });
            }
        }
        if (!this.options.importCSS) {
            var newStylesheets = Array.from(tempDocument.querySelectorAll('link[rel="stylesheet"]'));
            if (newStylesheets.length) {
                var currentStylesheets_1 = Array.from(document.querySelectorAll('link[rel="stylesheet"]'));
                newStylesheets.forEach(function (newStylesheet) {
                    var isNewSheet = true;
                    currentStylesheets_1.forEach(function (currentStylesheet) {
                        if (newStylesheet.getAttribute('href') === currentStylesheet.getAttribute('href')) {
                            isNewSheet = false;
                        }
                    });
                    if (isNewSheet) {
                        if (_this.options.debug) {
                            console.log('%c[Pjax] ' + "%cthe new page contains new stylesheets", 'color:#f3ff35', 'color:#eee');
                        }
                        _this.lastChance(_this._response.url);
                    }
                });
            }
        }
        var switchQueue = [];
        for (var i = 0; i < selectors.length; i++) {
            var newContainers = Array.from(tempDocument.querySelectorAll(selectors[i]));
            var currentContainers = Array.from(document.querySelectorAll(selectors[i]));
            if (this.options.debug) {
                console.log('%c[Pjax] ' + ("%cswapping content from " + selectors[i]), 'color:#f3ff35', 'color:#eee');
            }
            if (newContainers.length !== currentContainers.length) {
                if (this.options.debug) {
                    console.log('%c[Pjax] ' + "%cthe dom doesn't look the same", 'color:#f3ff35', 'color:#eee');
                }
                this.lastChance(this._response.url);
                return;
            }
            for (var k = 0; k < newContainers.length; k++) {
                var newContainer = newContainers[k];
                var currentContainer = currentContainers[k];
                var switchObject = {
                    new: newContainer,
                    current: currentContainer
                };
                switchQueue.push(switchObject);
            }
        }
        if (switchQueue.length === 0) {
            if (this.options.debug) {
                console.log('%c[Pjax] ' + "%ccouldn't find anything to switch", 'color:#f3ff35', 'color:#eee');
            }
            this.lastChance(this._response.url);
            return;
        }
        if (this.options.importScripts) {
            this.handleScripts(tempDocument);
        }
        if (this.options.importCSS) {
            this.handleCSS(tempDocument);
        }
        if (!this.options.customTransitions) {
            if (this.options.titleSwitch) {
                document.title = tempDocument.title;
            }
            this.handleSwitches(switchQueue);
        }
        else {
            this._cachedSwitch = {
                queue: switchQueue,
                title: tempDocument.title
            };
        }
    };
    Pjax.prototype.lastChance = function (uri) {
        if (this.options.debug) {
            console.log('%c[Pjax] ' + ("%csomething caused Pjax to break, native loading " + uri), 'color:#f3ff35', 'color:#eee');
        }
        window.location.href = uri;
    };
    Pjax.prototype.statusCheck = function () {
        for (var status_1 = 200; status_1 <= 206; status_1++) {
            if (this._cache.status === status_1) {
                return true;
            }
        }
        return false;
    };
    Pjax.prototype.loadCachedContent = function () {
        if (!this.statusCheck()) {
            this.lastChance(this._cache.url);
            return;
        }
        clear_active_1.default();
        state_manager_1.default.doReplace(window.location.href, document.title);
        this.switchSelectors(this.options.selectors, this._cache.document);
    };
    Pjax.prototype.parseContent = function (responseText) {
        var tempDocument = document.implementation.createHTMLDocument('pjax-temp-document');
        var contentType = this._response.headers.get('Content-Type');
        var htmlRegex = /text\/html/gi;
        var matches = contentType.match(htmlRegex);
        if (matches !== null) {
            tempDocument.documentElement.innerHTML = responseText;
            return tempDocument;
        }
        return null;
    };
    Pjax.prototype.cacheContent = function (responseText, responseStatus, uri) {
        var tempDocument = this.parseContent(responseText);
        this._cache = {
            status: responseStatus,
            document: tempDocument,
            url: uri
        };
        if (tempDocument instanceof HTMLDocument) {
            if (this.options.debug) {
                console.log('%c[Pjax] ' + "%ccaching content", 'color:#f3ff35', 'color:#eee');
            }
        }
        else {
            if (this.options.debug) {
                console.log('%c[Pjax] ' + "%cresponse wan't an HTML document", 'color:#f3ff35', 'color:#eee');
            }
            trigger_1.default(document, ['pjax:error']);
        }
    };
    Pjax.prototype.loadContent = function (responseText) {
        var tempDocument = this.parseContent(responseText);
        if (tempDocument instanceof HTMLDocument) {
            clear_active_1.default();
            state_manager_1.default.doReplace(window.location.href, document.title);
            this.switchSelectors(this.options.selectors, tempDocument);
        }
        else {
            if (this.options.debug) {
                console.log('%c[Pjax] ' + "%cresponse wasn't an HTML document", 'color:#f3ff35', 'color:#eee');
            }
            trigger_1.default(document, ['pjax:error']);
            this.lastChance(this._response.url);
            return;
        }
    };
    Pjax.prototype.handleScripts = function (newDocument) {
        var _this = this;
        if (newDocument instanceof HTMLDocument) {
            var newScripts = Array.from(newDocument.querySelectorAll('script'));
            var currentScripts_2 = Array.from(document.querySelectorAll('script'));
            newScripts.forEach(function (newScript) {
                var appendScript = true;
                var newScriptFilename = (newScript.getAttribute('src') !== null) ? newScript.getAttribute('src').match(/[^/]+$/g)[0] : 'custom-script';
                currentScripts_2.forEach(function (currentScript) {
                    var currentScriptFilename = (currentScript.getAttribute('src') !== null) ? currentScript.getAttribute('src').match(/[^/]+$/g)[0] : 'custom-script';
                    if (newScriptFilename === currentScriptFilename) {
                        appendScript = false;
                    }
                });
                if (appendScript) {
                    _this._scriptsToAppend.push(newScript);
                }
            });
            if (this._scriptsToAppend.length) {
                this._scriptsToAppend.forEach(function (script) {
                    if (script.src === '') {
                        var newScript = document.createElement('script');
                        newScript.setAttribute('src', _this._response.url);
                        newScript.innerHTML = script.innerHTML;
                        document.body.appendChild(newScript);
                        _this.checkForScriptLoadComplete(script);
                    }
                    else {
                        (function () { return __awaiter(_this, void 0, void 0, function () {
                            var response, responseText, newScript;
                            return __generator(this, function (_a) {
                                switch (_a.label) {
                                    case 0: return [4, fetch(script.src)];
                                    case 1:
                                        response = _a.sent();
                                        return [4, response.text()];
                                    case 2:
                                        responseText = _a.sent();
                                        newScript = document.createElement('script');
                                        newScript.setAttribute('src', script.src);
                                        newScript.innerHTML = responseText;
                                        document.body.appendChild(newScript);
                                        this.checkForScriptLoadComplete(script);
                                        return [2];
                                }
                            });
                        }); })();
                    }
                });
            }
        }
    };
    Pjax.prototype.checkForScriptLoadComplete = function (script) {
        if (script === void 0) { script = null; }
        if (this._scriptsToAppend.length) {
            if (script === null) {
                if (this.options.debug) {
                    console.error('%c[Pjax] ' + "%cScript element provided to be spliced was null", 'color:#f3ff35', 'color:#eee');
                }
                return;
            }
            var scriptIndex = this._scriptsToAppend.indexOf(script);
            this._scriptsToAppend.splice(scriptIndex, 1);
            if (!this._scriptsToAppend.length) {
                if (this.options.debug) {
                    console.log('%c[Pjax] ' + "%cAll scripts have been loaded", 'color:#f3ff35', 'color:#eee');
                }
                trigger_1.default(document, ['pjax:scriptContentLoaded']);
            }
        }
    };
    Pjax.prototype.handleCSS = function (newDocument) {
        var _this = this;
        if (newDocument instanceof HTMLDocument) {
            var newStyles = Array.from(newDocument.querySelectorAll('link[rel="stylesheet"]'));
            var currentStyles_1 = Array.from(document.querySelectorAll('link[rel="stylesheet"], style[href]'));
            var stylesToAppend_1 = [];
            newStyles.forEach(function (newStyle) {
                var appendStyle = true;
                var newStyleFile = newStyle.getAttribute('href').match(/[^/]+$/g)[0];
                currentStyles_1.forEach(function (currentStyle) {
                    var currentStyleFile = currentStyle.getAttribute('href').match(/[^/]+$/g)[0];
                    if (newStyleFile === currentStyleFile) {
                        appendStyle = false;
                    }
                });
                if (appendStyle) {
                    stylesToAppend_1.push(newStyle);
                }
            });
            if (stylesToAppend_1.length) {
                stylesToAppend_1.forEach(function (style) {
                    (function () { return __awaiter(_this, void 0, void 0, function () {
                        var response, responseText, newStyle;
                        return __generator(this, function (_a) {
                            switch (_a.label) {
                                case 0: return [4, fetch(style.href)];
                                case 1:
                                    response = _a.sent();
                                    return [4, response.text()];
                                case 2:
                                    responseText = _a.sent();
                                    newStyle = document.createElement('style');
                                    newStyle.setAttribute('rel', 'stylesheet');
                                    newStyle.setAttribute('href', style.href);
                                    newStyle.innerHTML = responseText;
                                    document.head.appendChild(newStyle);
                                    return [2];
                            }
                        });
                    }); })();
                });
            }
        }
    };
    Pjax.prototype.handleResponse = function (response) {
        var _this = this;
        if (this._request === null) {
            return;
        }
        if (this.options.debug) {
            console.log('%c[Pjax] ' + ("%cRequest status: " + response.status), 'color:#f3ff35', 'color:#eee');
        }
        if (!response.ok) {
            trigger_1.default(document, ['pjax:error']);
            return;
        }
        this._response = response;
        response.text().then(function (responseText) {
            switch (_this._request) {
                case 'prefetch':
                    if (_this._confirmed) {
                        _this.loadContent(responseText);
                    }
                    else {
                        _this.cacheContent(responseText, _this._response.status, _this._response.url);
                    }
                    break;
                case 'popstate':
                    _this._isPushstate = false;
                    _this.loadContent(responseText);
                    break;
                case 'reload':
                    _this._isPushstate = false;
                    _this.loadContent(responseText);
                    break;
                default:
                    _this.loadContent(responseText);
                    break;
            }
        });
    };
    Pjax.prototype.doRequest = function (href) {
        var _this = this;
        this._requestId++;
        var idAtStartOfRequest = this._requestId;
        var uri = href;
        var queryString = href.split('?')[1];
        if (this.options.cacheBust) {
            uri += (queryString === undefined) ? ("?cb=" + Date.now()) : ("&cb=" + Date.now());
        }
        var fetchMethod = 'GET';
        var fetchHeaders = new Headers({
            'X-Requested-With': 'XMLHttpRequest',
            'X-Pjax': 'true'
        });
        fetch(uri, {
            method: fetchMethod,
            headers: fetchHeaders
        }).then(function (response) {
            if (idAtStartOfRequest === _this._requestId) {
                _this.handleResponse(response);
            }
        }).catch(function (error) {
            if (_this.options.debug) {
                console.group();
                console.error('%c[Pjax] ' + "%cFetch error:", 'color:#f3ff35', 'color:#eee');
                console.error(error);
                console.groupEnd();
            }
        });
    };
    Pjax.prototype.handlePrefetch = function (href) {
        if (this._confirmed) {
            return;
        }
        if (this.options.debug) {
            console.log('%c[Pjax] ' + ("%cprefetching " + href), 'color:#f3ff35', 'color:#eee');
        }
        this.abortRequest();
        trigger_1.default(document, ['pjax:prefetch']);
        this._request = 'prefetch';
        this.doRequest(href);
    };
    Pjax.prototype.handleLoad = function (href, loadType, el) {
        if (el === void 0) { el = null; }
        if (this._confirmed) {
            return;
        }
        trigger_1.default(document, ['pjax:send'], el);
        this._dom.classList.remove('dom-is-loaded');
        this._dom.classList.add('dom-is-loading');
        this._confirmed = true;
        if (this._cache !== null) {
            if (this.options.debug) {
                console.log('%c[Pjax] ' + ("%cloading cached content from " + href), 'color:#f3ff35', 'color:#eee');
            }
            this.loadCachedContent();
        }
        else if (this._request !== 'prefetch') {
            if (this.options.debug) {
                console.log('%c[Pjax] ' + ("%cloading " + href), 'color:#f3ff35', 'color:#eee');
            }
            this._request = loadType;
            this.doRequest(href);
        }
    };
    Pjax.prototype.clearPrefetch = function () {
        if (!this._confirmed) {
            this._cache = null;
            this.abortRequest();
            trigger_1.default(document, ['pjax:cancel']);
        }
    };
    Pjax.load = function (url) {
        var customEvent = new CustomEvent('pjax:load', {
            detail: {
                uri: url
            }
        });
        document.dispatchEvent(customEvent);
    };
    Pjax.VERSION = '2.1.4';
    return Pjax;
}());
exports.default = Pjax;
//# sourceMappingURL=pjax.js.map

/***/ }),
/* 7 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
exports.default = (function (options) {
    if (options === void 0) { options = null; }
    var parsedOptions = (options !== null) ? options : {};
    parsedOptions.elements = (options !== null && options.elements !== undefined) ? options.elements : 'a[href]';
    parsedOptions.selectors = (options !== null && options.selectors !== undefined) ? options.selectors : ['.js-pjax'];
    parsedOptions.history = (options !== null && options.history !== undefined) ? options.history : true;
    parsedOptions.cacheBust = (options !== null && options.cacheBust !== undefined) ? options.cacheBust : false;
    parsedOptions.debug = (options !== null && options.debug !== undefined) ? options.debug : false;
    parsedOptions.titleSwitch = (options !== null && options.titleSwitch !== undefined) ? options.titleSwitch : true;
    parsedOptions.customTransitions = (options !== null && options.customTransitions !== undefined) ? options.customTransitions : false;
    parsedOptions.customPreventionAttributes = (options !== null && options.customPreventionAttributes !== undefined) ? options.customPreventionAttributes : [];
    parsedOptions.importScripts = (options !== null && options.importScripts !== undefined) ? options.importScripts : true;
    parsedOptions.importCSS = (options !== null && options.importCSS !== undefined) ? options.importCSS : true;
    return parsedOptions;
});
//# sourceMappingURL=parse-options.js.map

/***/ }),
/* 8 */
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
//# sourceMappingURL=trigger.js.map

/***/ }),
/* 9 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
var get_elements_1 = __webpack_require__(10);
var check_element_1 = __webpack_require__(11);
exports.default = (function (el, pjax) {
    var elements = get_elements_1.default(el, pjax);
    if (pjax.options.debug && elements.length === 0) {
        console.log('%c[Pjax] ' + "%cno elements could be found, check what selectors you're providing Pjax", 'color:#f3ff35', 'color:#eee');
        return;
    }
    for (var i = 0; i < elements.length; i++) {
        check_element_1.default(elements[i], pjax);
    }
});
//# sourceMappingURL=parse-dom.js.map

/***/ }),
/* 10 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
exports.default = (function (el, pjax) {
    var elements = Array.from(el.querySelectorAll(pjax.options.elements));
    return elements;
});
//# sourceMappingURL=get-elements.js.map

/***/ }),
/* 11 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
var link_events_1 = __webpack_require__(12);
exports.default = (function (el, pjax) {
    if (el.getAttribute('href')) {
        link_events_1.default(el, pjax);
    }
    else {
        if (pjax.options.debug) {
            console.log('%c[Pjax] ' + ("%c" + el + " is missing a href attribute, Pjax couldn't assign the event listener"), 'color:#f3ff35', 'color:#eee');
        }
    }
});
//# sourceMappingURL=check-element.js.map

/***/ }),
/* 12 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
var on_1 = __webpack_require__(13);
var attrState = 'data-pjax-state';
var isDefaultPrevented = function (el, e, options) {
    var isPrevented = false;
    if (e.defaultPrevented) {
        isPrevented = true;
    }
    else if (el.getAttribute('prevent-pjax') !== null) {
        isPrevented = true;
    }
    else if (el.classList.contains('no-transition')) {
        isPrevented = true;
    }
    else if (el.getAttribute('download') !== null) {
        isPrevented = true;
    }
    else if (el.getAttribute('target') === '_blank') {
        isPrevented = true;
    }
    if (options.length > 0) {
        for (var i = 0; i < options.length; i++) {
            if (el.getAttribute(options[i]) !== null) {
                isPrevented = true;
            }
        }
    }
    return isPrevented;
};
var checkForAbort = function (el, e) {
    if (el instanceof HTMLAnchorElement) {
        if (el.protocol !== window.location.protocol || el.host !== window.location.host) {
            return 'external';
        }
        if (el.hash && el.href.replace(el.hash, '') === window.location.href.replace(location.hash, '')) {
            return 'anchor';
        }
        if (el.href === window.location.href.split('#')[0] + ", '#'") {
            return 'anchor-empty';
        }
    }
    return null;
};
var handleClick = function (el, e, pjax) {
    if (isDefaultPrevented(el, e, pjax.options.customPreventionAttributes)) {
        return;
    }
    var attrValue = checkForAbort(el, e);
    if (attrValue !== null) {
        el.setAttribute(attrState, attrValue);
        return;
    }
    e.preventDefault();
    var elementLink = el.getAttribute('href');
    if (elementLink === window.location.href.split('#')[0]) {
        el.setAttribute(attrState, 'reload');
    }
    else {
        el.setAttribute(attrState, 'load');
    }
    pjax.handleLoad(elementLink, el.getAttribute(attrState), el);
};
var handleHover = function (el, e, pjax) {
    if (isDefaultPrevented(el, e, pjax.options.customPreventionAttributes)) {
        return;
    }
    if (e.type === 'mouseleave') {
        pjax.clearPrefetch();
        return;
    }
    var attrValue = checkForAbort(el, e);
    if (attrValue !== null) {
        el.setAttribute(attrState, attrValue);
        return;
    }
    var elementLink = el.getAttribute('href');
    if (elementLink !== window.location.href.split('#')[0]) {
        el.setAttribute(attrState, 'prefetch');
    }
    else {
        return;
    }
    pjax.handlePrefetch(elementLink);
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
//# sourceMappingURL=link-events.js.map

/***/ }),
/* 13 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
exports.default = (function (el, event, listener) {
    el.addEventListener(event, listener);
});
//# sourceMappingURL=on.js.map

/***/ }),
/* 14 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
exports.default = (function (scrollTo) {
    window.scrollTo(scrollTo.x, scrollTo.y);
});
//# sourceMappingURL=scroll.js.map

/***/ }),
/* 15 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
exports.default = (function () {
    if (document.activeElement) {
        try {
            document.activeElement.blur();
        }
        catch (e) {
            console.log(e);
        }
    }
});
//# sourceMappingURL=clear-active.js.map

/***/ }),
/* 16 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
var timestamp_1 = __webpack_require__(17);
var StateManager = /** @class */ (function () {
    function StateManager(debug, initialpushState) {
        this._doInitialPushState = (initialpushState) ? initialpushState : false;
        StateManager._isDebug = (debug) ? debug : false;
        // Check if the initial page state needs to be pushed into history
        if (this._doInitialPushState) {
            StateManager.doReplace(window.location.href);
        }
    }
    /**
     * Replaces the current `StateObject` in the windows history.
     * @param stateObject - the new`StateObject`
     */
    StateManager.handleReplaceState = function (stateObject) {
        if (StateManager._isDebug) {
            console.log('Replacing History State: ', stateObject);
        }
        window.history.replaceState(stateObject, stateObject.title, stateObject.uri);
    };
    /**
     * Pushes the `StateObject` into the windows history.
     * @param stateObject - `StateObject` that will be pushed into the windows history
     */
    StateManager.handlePushState = function (stateObject) {
        if (StateManager._isDebug) {
            console.log('Pushing History State: ', stateObject);
        }
        window.history.pushState(stateObject, stateObject.title, stateObject.uri);
    };
    /**
     * Builds the custom `StateObject`
     * @param pageURI - the new URI of the page
     * @param isPushstate - the new document title
     * @param pageTitle - the current scroll position of the page
     */
    StateManager.buildStateObject = function (pageURI, isPushstate, pageTitle, scrollOffset) {
        var stateObject = {
            uri: pageURI,
            timestamp: timestamp_1.default(),
            history: isPushstate,
            scrollPos: {
                x: (window.scrollX + scrollOffset.x),
                y: (window.scrollY + scrollOffset.y)
            }
        };
        stateObject.title = (pageTitle !== null && pageTitle !== undefined) ? pageTitle : document.title;
        // Handle the state type
        if (isPushstate) {
            StateManager.handlePushState(stateObject);
        }
        else {
            StateManager.handleReplaceState(stateObject);
        }
    };
    /**
     * Called when a new `window.history.pushState()` needs to occur.
     * @param uri - the new URI of the page
     * @param title - the new document title
     * @param scrollPosition - the current scroll position of the page
     */
    StateManager.doPush = function (uri, title, scrollOffset) {
        if (title === void 0) { title = document.title; }
        if (scrollOffset === void 0) { scrollOffset = { x: 0, y: 0 }; }
        StateManager.buildStateObject(uri, true, title, scrollOffset);
    };
    /**
     * Called when a new `window.history.replaceState()` needs to occur.
     * @param uri - the new URI of the page
     * @param title - the new document title
     * @param scrollPosition - the current scroll position of the page
     */
    StateManager.doReplace = function (uri, title, scrollOffset) {
        if (title === void 0) { title = document.title; }
        if (scrollOffset === void 0) { scrollOffset = { x: 0, y: 0 }; }
        StateManager.buildStateObject(uri, false, title, scrollOffset);
    };
    return StateManager;
}());
exports.default = StateManager;
//# sourceMappingURL=manager.js.map

/***/ }),
/* 17 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
/**
 * Grab the current timestamp.
 * @returns `Date.now()` number
 */
exports.default = (function () {
    return Date.now();
});
//# sourceMappingURL=timestamp.js.map

/***/ }),
/* 18 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
var DeviceManager = /** @class */ (function () {
    function DeviceManager(debug, setStatusClasses) {
        var _this = this;
        /**
         * Called when the `touchstart` event fires on an element that has a `js-touch` class.
         */
        this.userTouchedElement = function (e) {
            var target = e.currentTarget;
            target.classList.add('is-touching');
        };
        /**
         * Called when the `touchend` or `touchcancel` or `touchleave` event(s) fire on
         * an element with the `js-touch` class.
         */
        this.userReleasedTouchedElement = function (e) {
            var target = e.currentTarget;
            target.classList.remove('is-touching');
        };
        /**
         * Called when the `change` event is fired on `NetworkInformation`.
         * @see https://developer.mozilla.org/en-US/docs/Web/API/NetworkInformation#Event_handlers
         */
        this.handleConnectionChange = function (e) {
            _this._navigator = window.navigator;
            // @ts-ignore
            DeviceManager.connection = _this._navigator.connection || _this._navigator.mozConnection || _this._navigator.webkitConnection;
        };
        /**
         * Called when the `mouseover` event is fired on the body.
         * Sets a status class confirming that the user is using a pointer device (mouse).
         */
        this.handleMouseEvent = function (e) {
            _this._body.removeEventListener('mouseover', _this.handleMouseEvent);
            _this._html.classList.add('is-pointer-device');
            _this._html.classList.remove('is-not-pointer-device');
            if (_this._isDebug) {
                console.log('%c[Device Manager] ' + "%cUser is using a pointer device", 'color:#35ffb8', 'color:#eee');
            }
        };
        /**
         * Called when the `touchstart` event is fired on the body.
         * Sets a status class confirming that the user is using touch input.
         */
        this.handleTouchEvent = function (e) {
            _this._body.removeEventListener('touchstart', _this.handleTouchEvent);
            _this._html.classList.add('has-touched');
            if (_this._isDebug) {
                console.log('%c[Device Manager] ' + "%cUser has touched their device", 'color:#35ffb8', 'color:#eee');
            }
        };
        this._isDebug = (debug) ? debug : false;
        this._html = document.documentElement;
        this._body = document.body;
        this._navigator = window.navigator;
        // @ts-ignore
        DeviceManager.connection = this._navigator.connection || this._navigator.mozConnection || this._navigator.webkitConnection;
        DeviceManager.connection.addEventListener('change', this.handleConnectionChange);
        if (setStatusClasses) {
            this.setStatusClasses();
        }
        this._trackedElements = [];
        this.getTouchElements();
    }
    /**
     * Called when the page has changed and `DeviceManager` needs to handle the new/old touch tracked elements.
     */
    DeviceManager.prototype.reinit = function () {
        this.purgeTouchElements();
        this.getTouchElements();
    };
    /**
     * Get all the elements that require touch tracking if they're not already tracked.
     */
    DeviceManager.prototype.getTouchElements = function () {
        var _this = this;
        // Do nothing on non-touch devices
        if (!DeviceManager.supportsTouch) {
            return;
        }
        // Create an array of elements with the `.js-touch` class if they're not already tracked
        var elements = Array.from(document.body.querySelectorAll('.js-touch:not([data-touch-tracked="true"])'));
        elements.forEach(function (el) {
            // Sets tracking attribute
            el.setAttribute('data-touch-tracked', 'true');
            // Sets event listeners
            el.addEventListener('touchstart', _this.userTouchedElement);
            el.addEventListener('touchend', _this.userReleasedTouchedElement);
            el.addEventListener('touchleave', _this.userReleasedTouchedElement);
            el.addEventListener('touchcancel', _this.userReleasedTouchedElement);
            // Places element in the arrray
            _this._trackedElements.push(el);
        });
    };
    /**
     * Grabs all the current touch elements and removes any that are missing in the DOM.
     */
    DeviceManager.prototype.purgeTouchElements = function () {
        // Do nothing on non-touch devices
        if (!DeviceManager.supportsTouch) {
            return;
        }
        // Check if there are elements to check
        if (this._trackedElements.length === 0) {
            return;
        }
        var currentElements = Array.from(document.body.querySelectorAll('.js-touch'));
        var deadElements = [];
        // Loop through all tracked touch elements
        for (var i = 0; i < this._trackedElements.length; i++) {
            var survived = false;
            // Compare aginst all current touch elements
            for (var k = 0; k < currentElements.length; k++) {
                if (this._trackedElements[i] === currentElements[k]) {
                    survived = true;
                }
            }
            // Prepare dead elements for the purge
            if (!survived) {
                deadElements.push(this._trackedElements[i]);
            }
        }
        // Verify we have elements to remove
        if (deadElements.length !== 0) {
            // Loop though all the elements we need to remove
            for (var k = 0; k < deadElements.length; k++) {
                // Loop through all the current elements
                for (var i = 0; i < this._trackedElements.length; i++) {
                    // Check if the current element matches the element marked for death
                    if (this._trackedElements[i] === deadElements[i]) {
                        // Remove event listeners
                        deadElements[i].removeEventListener('touchstart', this.userTouchedElement);
                        deadElements[i].removeEventListener('touchend', this.userReleasedTouchedElement);
                        deadElements[i].removeEventListener('touchleave', this.userReleasedTouchedElement);
                        deadElements[i].removeEventListener('touchcancel', this.userReleasedTouchedElement);
                        // Get the elements index
                        var index = this._trackedElements.indexOf(this._trackedElements[i]);
                        // Splice the array at the index and shift the remaining elements
                        this._trackedElements.splice(index, 1);
                    }
                }
            }
        }
    };
    /**
     * Sets custom status classes on the HTML Document.
     */
    DeviceManager.prototype.setStatusClasses = function () {
        this._html.classList.add('has-js');
        this._html.classList.remove('has-no-js');
        if (this._isDebug) {
            console.log('%c[Device Manager] ' + "%cSetting status classes", 'color:#35ffb8', 'color:#eee');
        }
        // Listen for basic device event types
        this._body.addEventListener('mouseover', this.handleMouseEvent);
        this._body.addEventListener('touchstart', this.handleTouchEvent);
        // Set a status class if the device supports touch
        if (DeviceManager.supportsTouch) {
            this._html.classList.add('is-touch-device');
            this._html.classList.remove('is-not-touch-device');
            if (this._isDebug) {
                console.log('%c[Device Manager] ' + ("%cSupports Touch: %c" + DeviceManager.supportsTouch), 'color:#35ffb8', 'color:#eee', 'color:#68e5ff');
            }
        }
        // Sets a status class if the browser is using the Blink engine
        if (DeviceManager.isBlinkEngine) {
            this._html.classList.add('is-blink');
            if (this._isDebug) {
                console.log('%c[Device Manager] ' + ("%cUsing Blink Engine: %c" + DeviceManager.isBlinkEngine), 'color:#35ffb8', 'color:#eee', 'color:#68e5ff');
            }
        }
        // Sets a status class if the browser is Chrome
        if (DeviceManager.isChrome) {
            this._html.classList.add('is-chrome');
            if (this._isDebug) {
                console.log('%c[Device Manager] ' + ("%cChrome: %c" + DeviceManager.isChrome), 'color:#35ffb8', 'color:#eee', 'color:#68e5ff');
            }
        }
        // Sets a status class if the browser is IE 11
        if (DeviceManager.isIE) {
            this._html.classList.add('is-ie');
            if (this._isDebug) {
                console.log('%c[Device Manager] ' + ("%cInternet Explorer: %c" + DeviceManager.isIE), 'color:#35ffb8', 'color:#eee', 'color:#68e5ff');
            }
        }
        // Sets a status class if the browser is Edge
        if (DeviceManager.isEdge) {
            this._html.classList.add('is-edge');
            if (this._isDebug) {
                console.log('%c[Device Manager] ' + ("%cEdge: %c" + DeviceManager.isEdge), 'color:#35ffb8', 'color:#eee', 'color:#68e5ff');
            }
        }
        // Sets a status class if the browser is Firefox
        if (DeviceManager.isFirefox) {
            this._html.classList.add('is-firefox');
            if (this._isDebug) {
                console.log('%c[Device Manager] ' + ("%cFirefox: %c" + DeviceManager.isFirefox), 'color:#35ffb8', 'color:#eee', 'color:#68e5ff');
            }
        }
        // Sets a status class if the browser is Safari
        if (DeviceManager.isSafari) {
            this._html.classList.add('is-safari');
            if (this._isDebug) {
                console.log('%c[Device Manager] ' + ("%cSafari: %c" + DeviceManager.isSafari), 'color:#35ffb8', 'color:#eee', 'color:#68e5ff');
            }
        }
        // Sets a status class if the browser is Opera
        if (DeviceManager.isOpera) {
            this._html.classList.add('is-opera');
            if (this._isDebug) {
                console.log('%c[Device Manager] ' + ("%cOpera: %c" + DeviceManager.isOpera), 'color:#35ffb8', 'color:#eee', 'color:#68e5ff');
            }
        }
        // Sets a status class if the device's connection type is known
        if (DeviceManager.connection !== undefined) {
            this._html.classList.add("is-" + DeviceManager.connection.effectiveType);
            if (this._isDebug) {
                console.log('%c[Device Manager] ' + ("%cConnection Type: %c" + DeviceManager.connection.effectiveType), 'color:#35ffb8', 'color:#eee', 'color:#68e5ff');
            }
        }
    };
    DeviceManager.connection = undefined;
    /**
     * Checks if the browser is Chrome 1 - 71.
     * @returns `boolean`
     */
    DeviceManager.isChrome = (function () {
        var isChrome = false;
        // @ts-ignore
        if (!!window.chrome && (window.StyleMedia === undefined)) {
            isChrome = true;
        }
        return isChrome;
    })();
    /**
     * Checks if the browser is Edge 20+.
     * @returns `boolean`
     */
    DeviceManager.isEdge = (function () {
        var isEdge = false;
        // @ts-ignore
        if (!!window.StyleMedia && !!window.chrome) {
            isEdge = true;
        }
        return isEdge;
    })();
    /**
     * Checks if the browser is Internet Explorer 6 - 11.
     * @returns `boolean`
     */
    DeviceManager.isIE = (function () {
        var isIE = false;
        // @ts-ignore
        if (!!window.MSInputMethodContext && !!document.documentMode && (window.chrome === undefined)) {
            isIE = true;
        }
        return isIE;
    })();
    /**
     * Checks if the browser is Firefox 1+.
     * @returns `boolean`
     */
    DeviceManager.isFirefox = (function () {
        var isFirefox = false;
        // @ts-ignore
        if (typeof InstallTrigger !== 'undefined') {
            isFirefox = true;
        }
        return isFirefox;
    })();
    /**
     * Checks if the browser is Safari 3+.
     * @returns `boolean`
     */
    DeviceManager.isSafari = (function () {
        var isSafari = false;
        // @ts-ignore
        if (/constructor/i.test(window.HTMLElement) || (function (p) { return p.toString() === "[object SafariRemoteNotification]"; })(!window['safari'] || (typeof safari !== 'undefined' && safari.pushNotification))) {
            isSafari = true;
        }
        return isSafari;
    })();
    /**
     * Checks if the browser is Opera 8+.
     * @returns `boolean`
     */
    DeviceManager.isOpera = (function () {
        var isOpera = false;
        // @ts-ignore
        if ((!!window.opr && !!opr.addons) || !!window.opera || navigator.userAgent.indexOf(' OPR/') >= 0) {
            isOpera = true;
        }
        return isOpera;
    })();
    /**
     * Checks if the browser is using the Blink Engine.
     * @see https://en.wikipedia.org/wiki/Blink_(browser_engine)
     * @returns `boolean`
     */
    DeviceManager.isBlinkEngine = (function () {
        var isBlink = false;
        // @ts-ignore
        if ((DeviceManager.isChrome || DeviceManager.isOpera) && !!window.CSS) {
            isBlink = true;
        }
        return isBlink;
    })();
    /**
     * Checks if the browser supports touch input.
     * @returns `boolean`
     */
    DeviceManager.supportsTouch = (function () {
        var isTouchSupported = false;
        if (('ontouchstart' in window) || (navigator.maxTouchPoints > 0) || (navigator.msMaxTouchPoints > 0)) {
            isTouchSupported = true;
        }
        return isTouchSupported;
    })();
    return DeviceManager;
}());
exports.default = DeviceManager;
//# sourceMappingURL=DeviceManager.js.map

/***/ })
]]);