import Env from '../env';
import { isInView } from '../utils/isInView';

export default class BasicBlock{
    public el:  HTMLElement;

    private _showingTypeDetails:        boolean;
    private _showingIdDetails:          boolean;
    private _showingSizeDetails:        boolean;
    private _showingBlockBorder:        boolean;
    private _listeningForEvents:        boolean;
    private _hasInfoBlock:              boolean;
    private _infoBlock:                 HTMLElement;
    private _hasBorder:                 boolean;

    constructor(el:Element){
        this.el = <HTMLElement>el;

        this._showingIdDetails          = false;
        this._showingSizeDetails        = false;
        this._showingTypeDetails        = false;
        this._showingBlockBorder        = false;

        this._listeningForEvents    = false;
        this._hasInfoBlock          = false;
        this._hasBorder             = false;
    }

    private displayBlockInformation(bounds:DOMRect, blockType:string, blockId:number):void{
        if(!this._hasInfoBlock){
            this._infoBlock = document.createElement('div');
            this._infoBlock.style.cssText = 'position:absolute;top:8px;left:8px;padding:16px;border-radius:4px;background-color:#fff;box-shadow:0 2px 4px rgba(0,0,0,0.15);z-index:1500;transition:opacity 150ms ease;';
        }else{
            this._infoBlock.style.opacity = '1';
        }

        let innerHTML = '<ul>';

        if(this._showingIdDetails){
            innerHTML += `<li style="display:block;line-height:32px;"><strong>Block ID:</strong> ${ blockId }</li>`;
        }
        if(this._showingTypeDetails){
            innerHTML += `<li style="display:block;line-height:32px;"><strong>Block Type:</strong> ${ blockType }</li>`;
        }
        if(this._showingSizeDetails){
            innerHTML += `<li style="display:block;line-height:32px;"><strong>Width:</strong> ${ bounds.width }</li>`;
            innerHTML += `<li style="display:block;line-height:32px;"><strong>Height:</strong> ${ bounds.height }</li>`;
        }

        innerHTML += '</ul>';
        this._infoBlock.innerHTML = innerHTML;

        if(!this._hasInfoBlock){
            this.el.appendChild(this._infoBlock);
            this._hasInfoBlock = true;
        }
    }

    private displayBlockBorder():void{
        this.el.style.transition = 'all 150ms ease';
        if(this._hasBorder){
            this.el.style.boxShadow = 'inset 0 0 0 2px transparent';
            this._hasBorder = false;
        }else{
            this.el.style.boxShadow = 'inset 0 0 0 2px #3b83f9';
            this._hasBorder = true;
        }
    }

    private handleMouseEnter:EventListener = (e:Event)=>{
        if(this._showingIdDetails || this._showingSizeDetails || this._showingTypeDetails){
            const bounds    = <DOMRect>this.el.getBoundingClientRect();
            const blockType = this.el.getAttribute('data-block-type');
            const blockId   = parseInt(this.el.getAttribute('data-block-id'));
            this.displayBlockInformation(bounds, blockType, blockId);
        }

        if(this._showingBlockBorder){
            this.displayBlockBorder();
        }
    }

    private handleMouseLeave:EventListener = (e:Event)=>{
        if(this._hasInfoBlock){
            this._infoBlock.style.opacity = '0';
        }

        if(this._showingBlockBorder){
            this.displayBlockBorder();
        }
    }

    private checkForRemove():boolean{
        let canRemove = true;
        
        if(this._showingBlockBorder || this._showingIdDetails || this._showingSizeDetails || this._showingSizeDetails || this._showingTypeDetails){
            canRemove = false;
        }
        
        return canRemove;
    }

    private manageDetailsEventListener():void{
        if(!this._listeningForEvents){
            this._listeningForEvents = true;
            this.el.addEventListener('mouseenter', this.handleMouseEnter);
            this.el.addEventListener('mouseleave', this.handleMouseLeave);
        }else{
            if(this.checkForRemove()){
                this._listeningForEvents = false;
                this.el.removeEventListener('mouseenter', this.handleMouseEnter);
                this.el.removeEventListener('mouseleave', this.handleMouseLeave);
            }
        }
    }

    public toggleBlockBorder():void{
        if(this._showingBlockBorder){
            this._showingBlockBorder = false;
        }else{
            this._showingBlockBorder = true;
        }

        this.manageDetailsEventListener();
    }

    public toggleTypeDetails():void{
        if(this._showingTypeDetails){
            this._showingTypeDetails = false;
        }else{
            this._showingTypeDetails = true;
        }

        this.manageDetailsEventListener();
    }

    public toggleIdDetails():void{
        if(this._showingIdDetails){
            this._showingIdDetails = false;
        }else{
            this._showingIdDetails = true;
        }

        this.manageDetailsEventListener();
    }

    public toggleSizeDetails():void{
        if(this._showingSizeDetails){
            this._showingSizeDetails = false;
        }else{
            this._showingSizeDetails = true;
        }

        this.manageDetailsEventListener();
    }
}
