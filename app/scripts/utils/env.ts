const APP_NAME      = 'papertrain';

const html              = document.documentElement;
const body              = document.body;
const pjaxContainer     = '.js-pjax-container';
const pjaxWrapper       = '.js-pjax-wrapper';
const isDebug           = (html.getAttribute('data-debug') !== null) ? !!html.getAttribute('data-debug') : false;

export { APP_NAME, html, body, pjaxWrapper, pjaxContainer, isDebug };