import Env from '../env';
import AbstractModule from '../AbstractModule';
import anime from 'animejs';

export default class BasicAccordion extends AbstractModule{

    private static MODULE_NAME = 'BasicAccordion';

    private rows:       Array<Element>;
    private headlines:  Array<HTMLAnchorElement>;
    private multiRow:   boolean;

    private _style:     string;

    constructor(el:HTMLElement, uuid:string, app:App){
        super(el, uuid, app);
        if(this.isDebug){
            console.log('%c[module] '+`%cBuilding: ${BasicAccordion.MODULE_NAME} - ${this.uuid}`,'color:#4688f2','color:#eee');
        }

        this.rows       = Array.from(this.el.querySelectorAll('.js-row'));
        this.headlines  = [];
        this.multiRow   = (this.el.getAttribute('data-single-open') === 'true') ? false : true;

        this._style     = (this.el.getAttribute('data-style') === null) ? 'default' : this.el.getAttribute('data-style');
    }

    /**
     * Called when the module is created.
     */
    public init(): void{
        this.rows.map((el)=>{
            const headline = <HTMLAnchorElement>el.querySelector('.js-headline');

            headline.addEventListener('click', this.handleToggle );

            this.headlines.push(headline);
        });
    }

    /**
     * This is the default/fallback row closing style.
     * @param body - the `js-body` tagged element to close
     */
    private closeRowDefault(body:Element):void{
        const bodyEls   = body.querySelectorAll('*');

        anime({
            targets: body,
            duration: 300,
            easing: Env.EASING.out,
            height: [`${body.scrollHeight}px`, 0]
        });

        // Hide children
        anime({
            targets: bodyEls,
            duration: 75,
            easing: Env.EASING.out,
            opacity: [1, 0]
        });
    }

    /**
     * This is the `-grounded` row closing style.
     * @param body - the `js-body` tagged element to close
     */
    private closeRowGrounded(body:Element):void{
        anime({
            targets: body,
            duration: 300,
            easing: Env.EASING.out,
            height: [`${body.scrollHeight}px`, 0],
            paddingTop: ['16px', 0]
        });
    }

    /**
     * This method manages the row closing style and status classes.
     * Add additional styles to the switch statement.
     * @param rowToClose - the row element that needs to close
     */
    private closeRow(rowToClose:Element): void{
        if(rowToClose === null) return;
        rowToClose.classList.remove('is-open');
        const body      = rowToClose.querySelector('.js-body');

        switch(this._style){
            case 'grounded':
                this.closeRowGrounded(body);
                break;
            default:
                this.closeRowDefault(body);
                break;
        }
    }

    /**
     * This is the default/fallback row opening style.
     * @param body - the `js-body` tagged element to close
     */
    private openRowDefault(body:Element):void{
        const bodyEls   = body.querySelectorAll('*');

        // Open row
        anime({
            targets: body,
            duration: 300,
            easing: Env.EASING.in,
            height: [0, `${body.scrollHeight}px`],
        });

        // Show children
        anime({
            targets: bodyEls,
            duration: 150,
            easing: Env.EASING.out,
            delay: (el:Element, i:number)=>{
                return i * 75 + 150;
            },
            opacity: [0, 1]
        });
    }

    /**
     * This is the `-grounded` row opening style.
     * @param body - the `js-body` tagged element to close
     */
    private openRowGrounded(body:Element):void{
        // Open row
        anime({
            targets: body,
            duration: 300,
            easing: Env.EASING.in,
            height: [0, `${body.scrollHeight + 16}px`],
            paddingTop: [0, '16px']
        });
    }

    /**
     * This method manages the row opening style and status classes.
     * Add additional styles to the switch statement.
     * @param rowToOpen - the row element that needs to close
     */
    private openRow(rowToOpen:Element):void{
        if(rowToOpen.classList.contains('is-open')){
            this.closeRow(rowToOpen);
        }else{
            if(!this.multiRow){
                const oldRow = this.el.querySelector('.js-row.is-open');
                this.closeRow(oldRow);
            }

            rowToOpen.classList.add('is-open');
            const body = rowToOpen.querySelector('.js-body');
            switch(this._style){
                case 'grounded':
                    this.openRowGrounded(body);
                    break;
                default:
                    this.openRowDefault(body);
                    break;
            }
        }
    }

    /**
     * Called when the user clicks on a an element tagged with `js-headline`.
     */
    private handleToggle:EventListener = (e:Event)=>{
        e.preventDefault();
        const target    = <HTMLAnchorElement>e.currentTarget;
        const row       = target.parentElement;
        this.openRow(row);
    }

    /**
     * Called when the module is destroyed
     * Remove all event listners before calling super.destory()
     */
    public destroy(): void{
        super.destroy(BasicAccordion.MODULE_NAME);
    }
}
