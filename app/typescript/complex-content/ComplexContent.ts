import Env from '../env';
import App from '../App';
import { isInView } from '../utils/isInView';
import StateManager from 'fuel-state-manager';
import DebugManager from './DebugManager';

export default class ComplexContent{
    private _app:       App;
    private el:         Element;
    private _isDebug:   boolean;

    private _blocks:        Array<Element>;
    private _headings:      Array<Element>;
    private _hash:          string;

    private _stateManager:  StateManager;
    private _debugManager:  DebugManager;

    constructor(application:App){
        this._app       = application;
        this._isDebug   = this._app.env.getDebugStatus();
        this.el;

        this._blocks;
        this._headings;
        this._hash = null;

        this._stateManager = new StateManager(this._isDebug, false);
        this._debugManager = null;

        document.addEventListener('pjax:complete', this.handlePageLoad );
        window.addEventListener('scroll', this.handleScroll, { passive: true });

        this.getComplexContentElement();
    }

    private getVisibleHeading(): Element{
        let heading = null;
        const headingInView = [];

        for(let i = 0; i < this._headings.length; i++){
            if(heading === null){
                if(isInView(this._headings[i])){
                    const bounds = this._headings[i].getBoundingClientRect();
                    const centerPos = bounds.top + (bounds.height / 2);
                    if(centerPos >= 0){
                        headingInView.push(this._headings[i]);
                    }
                }
            }
        }

        if(headingInView.length > 1){
            let closestElToCenter = null;
            let distanceToBeat = null;

            for(let i = 0; i < headingInView.length; i++){
                const bounds = headingInView[i].getBoundingClientRect();
                const centerPos = bounds.top + (bounds.height / 2);

                if(closestElToCenter === null){
                    closestElToCenter = headingInView[i];
                    distanceToBeat = centerPos;
                }else{
                    if(centerPos < distanceToBeat){
                        distanceToBeat = centerPos;
                        closestElToCenter = headingInView[i];
                    }
                }
            }

            heading = closestElToCenter;
        }
        else if(headingInView.length === 1){
            heading = headingInView[0];
        }

        return heading;
    }

    private manageUrl():void{
        if(window.scrollY <= Env.SCROLL_TRIGGER && this._hash !== null){
            this._hash = null;
            const scrollOffset = {
                x: 0,
                y: -window.scrollY
            }
            this._stateManager.doReplace(`${ window.location.origin }${ window.location.pathname }`, document.title, scrollOffset);
        }
        else if(window.scrollY > Env.SCROLL_TRIGGER){
            const heading = this.getVisibleHeading();

            if(heading === null){
                return;
            }

            const newHash = heading.getAttribute('name');
            if(newHash !== this._hash && newHash){
                this._hash = newHash;

                const headingBounds = heading.getBoundingClientRect();
                const scrollOffset = {
                    x: 0,
                    y: (window.innerHeight - headingBounds.height)
                }
                this._stateManager.doReplace(`${ window.location.origin }${ window.location.pathname }#${ this._hash }`, document.title, scrollOffset);
            }
        }
    }

    private handleScroll:EventListener = (e:Event)=>{

        if(!this.el){
            return;
        }

        this.manageUrl();
    }

    private handlePageLoad:EventListener = (e:Event)=>{
        this.getComplexContentElement();
    }

    public getComplexContentElement(): void{
        this.el = document.body.querySelector('[complex-content]');

        if(this.el){
            this.init();
        }else{
            if(this._isDebug){
                console.log('%c[Complex Content] '+`%cthis is not a complex content page`,'color:#c36eff','color:#eee');
            }
        }
    }

    public init(): void{
        if(this._isDebug){
            console.log('%c[Complex Content] '+`%cEntry: %c${ this.el.getAttribute('data-template') } ${ this.el.getAttribute('data-entry') }`,'color:#c36eff','color:#eee','color:#46d4f2');
        }

        this._blocks = Array.from(this.el.querySelectorAll('.js-complex-content-block'));
        this._headings = Array.from(this.el.querySelectorAll('[primary-heading]'));
        if(this.el.getAttribute('complex-content-debug') !== null){
            this._debugManager = new DebugManager(document.body.querySelector('.js-debug-panel'), this.el);
        }else{
            this._debugManager = null;
        }
    }
}
