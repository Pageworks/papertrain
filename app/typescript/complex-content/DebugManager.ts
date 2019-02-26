import Env from '../env';
import { isInView } from '../utils/isInView';
import BasicBlock from './BasicBlock';

export default class DebugManager{
    public el:      HTMLElement;
    public cc:      Element;
    private _isDebug:   boolean;

    private _debugButton:   Element;
    private _debugBackdrop: Element;

    private _blocks:        Array<Element>;
    private _basicBlocks:   Array<BasicBlock>;

    constructor(el:HTMLElement, debug:boolean, complexContent:Element){
        if(debug){
            console.log('%c[Debug Manager] '+`%cEntry is in debug mode. To disable debug mode uncheck the lightswitch in the Admin tab for the entry.`,'color:#edc035','color:#eee');
        }

        this.el         = el;
        this.cc         = complexContent;
        this._isDebug   = debug;

        this._debugButton = document.body.querySelector('.js-debug-button');
        this._debugButton.addEventListener('click', this.toggleDebugModal);

        this._debugBackdrop = this.el.querySelector('.js-backdrop');
        this._debugBackdrop.addEventListener('click', this.toggleDebugModal);

        this._blocks        = Array.from(this.cc.querySelectorAll('.js-complex-content-block'));
        this._basicBlocks   = [];

        this.init();
    }

    public init(): void{
        if(this._isDebug){
            console.log('%c[Debug Manager] '+`%cBuilding basic block modules.`,'color:#edc035','color:#eee');
        }

        if(this._blocks.length){
            this.buildBasicModules();
        }

    }

    private buildBasicModules():void{
        for(let i = 0; i < this._blocks.length; i++){
            const newBaiscBlock = new BasicBlock(this._blocks[i], this._isDebug);
            newBaiscBlock.init();
            this._basicBlocks.push(newBaiscBlock);
        }
        if(this._isDebug){
            console.log('%c[Debug Manager] '+`%cSuccessfully built %c${ this._basicBlocks.length } %cbasic block modules.`,'color:#edc035','color:#eee','color:#46d4f2','color:#eee');
        }
    }

    private toggleDebugModal:EventListener = (e:Event)=>{
        if(this.el.classList.contains('is-open')){
            this.el.classList.remove('is-open');
            this._debugButton.classList.remove('is-open');
            this._debugButton.querySelector('.js-tip').innerHTML = 'Settings';
        }else{
            this.el.classList.add('is-open');
            this._debugButton.classList.add('is-open');
            this._debugButton.querySelector('.js-tip').innerHTML = 'Close';
        }
    }
}
