import Env from '../env';
import { isInView } from '../utils/isInView';

export default class BasicBlock{
    public el:          Element;
    private _isDebug:   boolean;

    constructor(el:Element, debug:boolean){
        this.el         = el;
        this._isDebug   = debug;
    }

    public init(): void{

    }
}
