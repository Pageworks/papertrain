// @ts-nocheck
'use strict';

export const DeviceManager = /** @class */ (function () {
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
        try {
            // @ts-ignore
            DeviceManager.connection = this._navigator.connection || this._navigator.mozConnection || this._navigator.webkitConnection;
            DeviceManager.connection.addEventListener('change', this.handleConnectionChange);
        }
        catch (e) {
            if (this._isDebug) {
                console.error('Failed to setup navigator connection', e);
            }
        }
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