import Env from '../env';
import { isInView } from '../utils/isInView';

export default class BasicBlock{
    public el:          Element;

    private _showingTypeDetails:    boolean;
    private _showingIdDetails:      boolean;
    private _showingSizeDetails:    boolean;
    private _listeningForEvents:    boolean;

    constructor(el:Element){
        this.el         = el;

        this._showingIdDetails      = false;
        this._showingSizeDetails    = false;
        this._showingTypeDetails    = false;

        this._listeningForEvents    = false;
    }

    private handleMouseEnter:EventListener = (e:Event)=>{
        const bounds = this.el.getBoundingClientRect();
        const blockType = this.el.getAttribute('data-type');
    }

    private manageDetailsEventListener():void{
        if(!this._listeningForEvents){
            this._listeningForEvents = true;
            this.el.addEventListener('mouseenter', this.handleMouseEnter);
        }else{
            if(!this._showingIdDetails && !this._showingSizeDetails && !this._showingTypeDetails){
                this._listeningForEvents = false;
                this.el.removeEventListener('mouseenter', this.handleMouseEnter);
            }
        }
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
