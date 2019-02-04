const APP_NAME          = 'REPLACE_ME';
let isDebug             = true;

const html              = document.documentElement;
const body              = document.body;
const pjaxContainer     = '.js-pjax-container';
const pjaxWrapper       = '.js-pjax-wrapper';

const scrollTrigger     = 100; // in pixels
const easing            = {
                            ease: 'cubicBezier(0.4, 0.0, 0.2, 1)',
                            in: 'cubicBezier(0.0, 0.0, 0.2, 1)',
                            out: 'cubicBezier(0.4, 0.0, 1, 1)',
                            sharp: 'cubicBezier(0.4, 0.0, 0.6, 1)'
                        }

export { APP_NAME, html, body, pjaxWrapper, pjaxContainer, isDebug, easing, scrollTrigger };

export function setDebug(status:boolean){
    isDebug = status;
}
