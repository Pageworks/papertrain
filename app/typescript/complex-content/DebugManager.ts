import Env from '../env';
import { isInView } from '../utils/isInView';
import BasicBlock from './BasicBlock';
import ContainerBlock from './ContainerBlock';
import SectionBlock from './SectionBlock';

export default class DebugManager{
    public el:      HTMLElement;
    public cc:      Element;

    private _debugButton:   Element;
    private _debugBackdrop: Element;

    private _blocks:        Array<Element>;
    private _basicBlocks:   Array<BasicBlock>;

    private _containers:        Array<Element>;
    private _containerBlocks:   Array<ContainerBlock>;

    private _sections:        Array<Element>;
    private _sectionBlocks:   Array<SectionBlock>;

    private _switches:      Array<HTMLInputElement>;

    constructor(el:HTMLElement, complexContent:Element){
        console.log('%c[Debug Manager] '+`%cEntry is in debug mode. To disable debug mode uncheck the lightswitch in the Admin tab for the entry.`,'color:#edc035','color:#eee');

        this.el = el;
        this.cc = complexContent;

        this._debugButton = document.body.querySelector('.js-debug-button');
        this._debugButton.addEventListener('click', this.toggleDebugModal);

        this._debugBackdrop = this.el.querySelector('.js-backdrop');
        this._debugBackdrop.addEventListener('click', this.toggleDebugModal);

        this._blocks        = Array.from(this.cc.querySelectorAll('.js-complex-content-block'));
        this._basicBlocks   = [];

        this._containers        = Array.from(this.cc.querySelectorAll('.js-complex-content-container'));
        this._containerBlocks   = [];

        this._sections        = Array.from(this.cc.querySelectorAll('.js-complex-content-section'));
        this._sectionBlocks   = [];

        this._switches  = Array.from(this.el.querySelectorAll('.js-switch input'));

        this.init();
    }

    public init(): void{
        console.log('%c[Debug Manager] '+`%cBuilding basic block modules.`,'color:#edc035','color:#eee');

        if(this._blocks.length){
            this.buildBasicModules();
        }

        if(this._containers.length){
            this.buildContainerModules();
        }

        if(this._sections.length){
            this.buildSectionModules();
        }

        for(let i = 0; i < this._switches.length; i++){
            this._switches[i].addEventListener('change', this.handleToggleInput);
        }
    }

    private shiftBlockBackgrounds():void{
        for(let i = 0; i < this._containerBlocks.length; i++){
            this._containerBlocks[i].toggleBackgroundColor();
        }
    }

    private highlightEmptyContainers():void{
        for(let i = 0; i < this._containerBlocks.length; i++){
            this._containerBlocks[i].toggleEmptyContainerHighlight();
        }
    }

    private highlightEmptySections():void{
        for(let i = 0; i < this._sectionBlocks.length; i++){
            this._sectionBlocks[i].toggleEmptySectionHighlight();
        }
    }

    private showBlockType():void{
        for(let i = 0; i < this._basicBlocks.length; i++){
            this._basicBlocks[i].toggleTypeDetails();
        }
    }

    private showBlockId():void{
        for(let i = 0; i < this._basicBlocks.length; i++){
            this._basicBlocks[i].toggleIdDetails();
        }
    }

    private showBlockSize():void{
        for(let i = 0; i < this._basicBlocks.length; i++){
            this._basicBlocks[i].toggleSizeDetails();
        }
    }

    private showBlockBorder():void{
        for(let i = 0; i < this._basicBlocks.length; i++){
            this._basicBlocks[i].toggleBlockBorder();
        }
    }

    private handleToggleInput:EventListener = (e:Event)=>{
        const target = <HTMLInputElement>e.currentTarget;

        console.log(target.name);

        switch(target.name){
            case 'shiftBlockBackground':
                this.shiftBlockBackgrounds();
                break;
            case 'highlightEmptySections':
                this.highlightEmptySections();
                break;
            case 'highlightEmptyContainers':
                this.highlightEmptyContainers();
                break;
            case 'showBlockType':
                this.showBlockType();
                break;
            case 'showBlockId':
                this.showBlockId();
                break;
            case 'showBlockSize':
                this.showBlockSize();
                break;
            case 'showBlockBorders':
                this.showBlockBorder();
                break;
        }
    }

    private buildBasicModules():void{
        for(let i = 0; i < this._blocks.length; i++){
            const newBaiscBlock = new BasicBlock(this._blocks[i]);
            this._basicBlocks.push(newBaiscBlock);
        }
        console.log('%c[Debug Manager] '+`%cSuccessfully built %c${ this._basicBlocks.length } %cbasic block modules.`,'color:#edc035','color:#eee','color:#46d4f2','color:#eee');
    }

    private buildContainerModules():void{
        for(let i = 0; i < this._containers.length; i++){
            const newContainerBlock = new ContainerBlock(this._containers[i]);
            this._containerBlocks.push(newContainerBlock);
        }
        console.log('%c[Debug Manager] '+`%cSuccessfully built %c${ this._containerBlocks.length } %ccontainer block modules.`,'color:#edc035','color:#eee','color:#46d4f2','color:#eee');
    }

    private buildSectionModules():void{
        for(let i = 0; i < this._containers.length; i++){
            const newSectionBlock = new SectionBlock(this._sections[i]);
            this._sectionBlocks.push(newSectionBlock);
        }
        console.log('%c[Debug Manager] '+`%cSuccessfully built %c${ this._sectionBlocks.length } %ccontainer block modules.`,'color:#edc035','color:#eee','color:#46d4f2','color:#eee');
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
