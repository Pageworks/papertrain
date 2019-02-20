import Env from './env';
import App from './App';
import { isInView } from './utils/isInView';

export default class ComplexContent{
    private _app:       App;
    private el:         Element;
    private _isDebug:   boolean;

    private _blocks:    Array<Element>;
    private _headings:  Array<Element>;
    private _hash:      string;

    constructor(application:App){
        this._app       = application;
        this._isDebug   = this._app.env.getDebugStatus();
        this.el;

        this._blocks;
        this._headings;
        this._hash = null;

        document.addEventListener('pjax:complete', this.handlePageLoad );
        window.addEventListener('scroll', this.handleScroll, { passive: true });

        this.getComplexContentElement();
    }

    private replaceState():void{

    }

    private getVisibleHeading(): string{
        let headingName = null;
        const headingInView = [];

        for(let i = 0; i < this._headings.length; i++){
            if(headingName === null){
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

            headingName = closestElToCenter.getAttribute('name');
        }
        else if(headingInView.length === 1){
            headingName = headingInView[0].getAttribute('name');
        }

        return headingName;
    }

    private manageUrl():void{
        if(window.scrollY <= Env.SCROLL_TRIGGER && this._hash !== null){
            this._hash = null;
            this.replaceState();
        }
        else if(window.scrollY > Env.SCROLL_TRIGGER){
            const newHash = this.getVisibleHeading();
            if(newHash !== this._hash && newHash){
                this._hash = newHash;
                this.replaceState();
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

        this._blocks = Array.from(this.el.querySelectorAll('.js-block'));
        this._headings = Array.from(this.el.querySelectorAll('[primary-heading]'));
    }
}
