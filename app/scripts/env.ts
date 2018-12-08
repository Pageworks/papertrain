import dotenv from 'dotenv';
const env = dotenv.config({ path: '../../.env' });

const APP_NAME          = process.env.PROJECT_NAME.replace(/\s/g, '-').toLowerCase();
const html              = document.documentElement;
const body              = document.body;
const pjaxContainer     = '.js-pjax-container';
const pjaxWrapper       = '.js-pjax-wrapper';
const isDebug           = (process.env.ENVIRONMENT === 'dev') ? true : false;

export { APP_NAME, html, body, pjaxWrapper, pjaxContainer, isDebug };