(window.webpackJsonp=window.webpackJsonp||[]).push([[6],{19:function(module,exports,__webpack_require__){"use strict";Object.defineProperty(exports,"__esModule",{value:!0});var Application_1=__webpack_require__(0),Module=function(){function Module(view,uuid){this.view=view,this.uuid=uuid,this.parent=null,this.submodules=[],this.futureParent=null}return Module.prototype.register=function(submodule){this.submodules.push(submodule)},Module.prototype.mount=function(){this.view.dataset.uuid=this.uuid;var parent=this.view.closest('[data-module]:not([data-uuid="'+this.uuid+'"])');parent&&(this.parent=Application_1.Application.getModuleByUUID(parent.getAttribute("data-uuid")),this.parent?this.parent.register(this):this.futureParent=parent)},Module.prototype.afterMount=function(){},Module.prototype.seppuku=function(){Application_1.Application.destroyModule(this.uuid)},Module.prototype.beforeDestroy=function(){},Module.prototype.destroy=function(){if(this.submodules.length)for(var i=this.submodules.length-1;i>=0;i--)Application_1.Application.destroyModule(this.submodules[i].uuid);this.view.remove()},Module}();exports.Module=Module}},[[19,1,2,3,0]]]);