import Env from '../env';
import { isInView } from '../utils/isInView';

export default class ContainerBlock{
    public el:  HTMLElement;

    private _showingBackgroundColor:    boolean;
    private _showingEmptyHighlight:     boolean;
    private _listeningForEvents:        boolean;
    private _hasBackground:             boolean;
    private _numberOfBlocks:            number;

    constructor(el:Element){
        this.el = <HTMLElement>el;

        this._showingBackgroundColor    = false;
        this._showingEmptyHighlight     = false;
        this._listeningForEvents        = false;
        this._hasBackground             = false;
        this._numberOfBlocks            = null;
    }

    private displayBackgroundColor():void{
        this.el.style.transition = 'all 150ms ease';
        if(this._hasBackground){
            this.el.style.backgroundColor = 'transparent';
            this._hasBackground = false;
        }else{
            this.el.style.backgroundColor = 'rgba(0,0,0,0.05)';
            this._hasBackground = true;
        }
    }

    private handleMouseEnter:EventListener = (e:Event)=>{
        if(this._showingBackgroundColor){
            this.displayBackgroundColor();
        }
    }

    private handleMouseLeave:EventListener = (e:Event)=>{
        if(this._showingBackgroundColor){
            this.displayBackgroundColor();
        }
    }

    private checkForRemove():boolean{
        let canRemove = true;
        
        if(this._showingBackgroundColor){
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

    public toggleBackgroundColor():void{
        if(this._showingBackgroundColor){
            this._showingBackgroundColor = false;
        }else{
            this._showingBackgroundColor = true;
        }

        this.manageDetailsEventListener();
    }

    public toggleEmptyContainerHighlight():void{
        if(this._numberOfBlocks === null){
            const numberOfBlocks = this.el.querySelectorAll('.js-complex-content-block');
            this._numberOfBlocks = numberOfBlocks.length;
        }

        if(this._showingEmptyHighlight){
            if(this._numberOfBlocks === 0){
                this.el.style.border = 'none';
                this.el.style.padding = '0';
                this.el.innerText = '';
            }
            this._showingEmptyHighlight = false;
        }else{
            this._showingEmptyHighlight = true;
            if(this._numberOfBlocks === 0){
                this.el.style.border = '2px dashed #ff715b';
                this.el.style.padding = '16px';
                this.el.innerText = 'Empty container';
            }
        }
        
    }
}
