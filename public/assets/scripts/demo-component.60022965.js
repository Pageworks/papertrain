(window["webpackJsonp"] = window["webpackJsonp"] || []).push([[4],[
/* 0 */
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
Object.defineProperty(exports, "__esModule", { value: true });
var Module_1 = __webpack_require__(1);
var Application_1 = __webpack_require__(2);
var Env_1 = __webpack_require__(3);
var DemoComponent = (function (_super) {
    __extends(DemoComponent, _super);
    function DemoComponent(view, uuid) {
        var _this = _super.call(this, view, uuid) || this;
        if (Env_1.Env.isDebug) {
            console.log('%c[Module Manager] ' + ("%ccreated new %c" + DemoComponent.index + " %cmodule with an ID of %c" + uuid), 'color:#4882fd', 'color:#eee', 'color:#48eefd', 'color:#eee', 'color:#48eefd');
        }
        return _this;
    }
    DemoComponent.prototype.afterMount = function () {
    };
    DemoComponent.prototype.beforeDestroy = function () {
    };
    DemoComponent.index = 'DemoComponent';
    return DemoComponent;
}(Module_1.Module));
exports.DemoComponent = DemoComponent;
modules[DemoComponent.index] = DemoComponent;
if (Env_1.Env.isDebug) {
    console.log('%c[Module Manager] ' + ("%cmodule %c" + DemoComponent.index + " %chas finished loading"), 'color:#4882fd', 'color:#eee', 'color:#48eefd', 'color:#eee');
}
Application_1.Application.mountModules();


/***/ })
],[[0,3,7,6,5]]]);