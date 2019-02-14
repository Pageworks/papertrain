import Env from '../env';
import AbstractModule from '../AbstractModule';
import anime from 'animejs';

export default class BasicAccordion extends AbstractModule{

    public static MODULE_NAME:string = 'BasicAccordion';

    private _rows:       Array<Element>;
    private _headlines:  Array<HTMLAnchorElement>;
    private _multiRow:   boolean;

    constructor(el:HTMLElement, uuid:string, app:App){
        super(el, uuid, app);
        if(this.isDebug){
            console.log('%c[module] '+`%cBuilding: ${BasicAccordion.MODULE_NAME} - ${this.uuid}`,'color:#4688f2','color:#eee');
        }

        this._rows       = Array.from(this.el.querySelectorAll('.js-row'));
        this._headlines  = [];
        this._multiRow   = (this.el.getAttribute('data-single-open') === 'true') ? true : false;
    }

    /**
     * Called when the module is created
     * Used to call any initial methods or to
     * register any initial event listeners
     */
    public init(): void{
        this._rows.map((el)=>{
            const headline = <HTMLAnchorElement>el.querySelector('.js-headline');

            headline.addEventListener('click', e => this.handleToggle(e) );

            this._headlines.push(headline);
        });
    }

    private closeRows(rowToClose:Element): void{
        if(rowToClose === null) return;
        rowToClose.classList.remove('is-open');
        const body      = rowToClose.querySelector('.js-body');
        const bodyEls   = Array.from(body.querySelectorAll('*'));

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

    private handleToggle(e:Event): void{
        e.preventDefault();
        const target    = <HTMLAnchorElement>e.currentTarget;
        const row       = target.parentElement;
        const body      = row.querySelector('.js-body');
        const bodyEls   = Array.from(body.querySelectorAll('*'));

        if(row.classList.contains('is-open')){
            row.classList.remove('is-open');

            // Close row
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
        }else{
            if(!this._multiRow){
                const oldRow = this.el.querySelector('.js-row.is-open');
                this.closeRows(oldRow);
            }

            row.classList.add('is-open');

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
                delay: (el:HTMLElement, i:number)=>{
                    return i * 75 + 150;
                },
                opacity: [0, 1]
            });
        }
    }

    /**
     * Called when the module is destroyed
     * Remove all event listners before calling super.destory()
     */
    public destroy(): void{
        super.destroy(BasicAccordion.MODULE_NAME);
    }
}
