import { isDebug } from '../env';
import AbstractModule from './AbstractModule';
import anime from 'animejs';

const MODULE_NAME = 'BasicAccordion';

export default class extends AbstractModule{
    rows:       Array<Element>
    headlines:  Array<HTMLAnchorElement>
    multiRow:   boolean

    constructor(el:Element, app:App){
        super(el, app);
        if(isDebug) console.log('%c[module] '+`%cBuilding: ${MODULE_NAME} - ${this.uuid}`,'color:#4688f2','color:#eee');

        this.rows       = Array.from(this.el.querySelectorAll('.js-row'));
        this.headlines  = [];
        this.multiRow   = (this.el.getAttribute('data-single-open') === 'true') ? true : false;
    }

    /**
     * Called when the module is created
     * Used to call any initial methods or to
     * register any initial event listeners
     */
    init(){
        this.rows.map((el)=>{
            const headline = <HTMLAnchorElement>el.querySelector('.js-headline');

            headline.addEventListener('click', e => this.handleToggle(e) );

            this.headlines.push(headline);
        });
    }
    
    closeRows(rowToClose:Element){
        if(rowToClose === null) return;
        rowToClose.classList.remove('is-open');
        const body      = rowToClose.querySelector('.js-body');
        const bodyEls   = body.querySelectorAll('*');
        
        anime({
            targets: body,
            duration: 300,
            easing: [0.4, 0.0, 1, 1],
            height: [`${body.scrollHeight}px`, 0]
        });

        // Hide children
        anime({
            targets: bodyEls,
            duration: 75,
            easing: [0.4, 0.0, 1, 1],
            opacity: [1, 0]
        });
    }

    handleToggle(e:Event){
        e.preventDefault();
        const target    = <HTMLAnchorElement>e.currentTarget;
        const row       = target.parentElement;
        const body      = row.querySelector('.js-body');
        const bodyEls   = body.querySelectorAll('*');
        
        if(row.classList.contains('is-open')){
            row.classList.remove('is-open');
            
            // Close row
            anime({
                targets: body,
                duration: 300,
                easing: [0.4, 0.0, 1, 1],
                height: [`${body.scrollHeight}px`, 0]
            });

            // Hide children
            anime({
                targets: bodyEls,
                duration: 75,
                easing: [0.4, 0.0, 1, 1],
                opacity: [1, 0]
            });
        }else{
            if(!this.multiRow){
                const oldRow = this.el.querySelector('.js-row.is-open');
                this.closeRows(oldRow);
            }

            row.classList.add('is-open');

            // Open row
            anime({
                targets: body,
                duration: 300,
                easing: [0.0, 0.0, 0.2, 1],
                height: [0, `${body.scrollHeight}px`],
            });

            // Show children
            anime({
                targets: bodyEls,
                duration: 150,
                easing: [0.4, 0.0, 1, 1],
                delay: (el:Element, i:number)=>{
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
    destroy(){
        super.destroy(isDebug, MODULE_NAME);
    }
}