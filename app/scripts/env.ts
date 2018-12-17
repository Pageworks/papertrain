const APP_NAME          = 'REPLACE_ME';
let isDebug             = true;

const html              = document.documentElement;
const body              = document.body;
const pjaxContainer     = '.js-pjax-container';
const pjaxWrapper       = '.js-pjax-wrapper';

export { APP_NAME, html, body, pjaxWrapper, pjaxContainer, isDebug };

export function setDebug(status:boolean){
    isDebug = status;
}
