import { isDebug } from '../env';
import AbstractModule from './AbstractModule';
import anime from 'animejs';
import { getParent } from '../utils/getParent';

export default class BasicGallery extends AbstractModule{

    public static MODULE_NAME:string = 'BasicGallery';

    private _style:      string;
    private _timing:     number;
    private _slides:     Array<Element>;
    private _actionsEls: Array<Element>;
    private _counter:    number;
    private _transition: number;
    private _time:       number;
    private _slideID:    number;
    private _isDirty:    boolean;

    constructor(el:Element, uuid:string, app:App){
        super(el, uuid, app);
        if(isDebug) console.log('%c[module] '+`%cBuilding: ${BasicGallery.MODULE_NAME} - ${this.uuid}`,'color:#4688f2','color:#eee');

        // CMS Input Data
        this._style      = this.el.getAttribute('data-style');
        this._timing     = parseInt(this.el.getAttribute('data-timing'));

        // NodeLists
        this._slides     = Array.from(this.el.querySelectorAll('.js-slide'));
        this._actionsEls = Array.from(this.el.querySelectorAll('.js-button'));

        // Gallery Data
        this._transition = 0.3;
        this._counter    = this._timing;
        this._time       = null;
        this._isDirty    = false;
        this._slideID    = 0;
    }

    /**
     * Called when the module is created
     * Used to call any initial methods or to
     * register any initial event listeners
     */
    public init(): void{
        this._actionsEls.forEach((el)=>{ el.addEventListener('click', e => this.handleActionButton(e) ); });

        // Only start our loop if the gallery IS NOT set to manual transition
        if(this._timing !== -1){
            this._time = Date.now();
            window.requestAnimationFrame(() => this.callbackLoop());
        }
    }

    /**
     * Resets the counter and the galleries `isDirty` status.
     */
    private cleanGallery(): void{
        this._counter = this._timing;
        this._isDirty = false;
    }

    /**
     * This is the basic slide transition for the gallery.
     * Transitions are handled using animejs.
     * @see http://animejs.com/documentation/
     * @param { number } newSlideID What is the new slide ID
     * @param { number } currSlideID What is the current active slide ID
     * @param { number } direction What direction is the gallery going
     */
    private handleSlideTransition(newSlideID:number, currSlideID:number, direction:number): void{
        const currSlide = this._slides[currSlideID];
        const newSlide  = this._slides[newSlideID];

        // Hide slide
        anime({
            targets: currSlide,
            duration: (this._transition * 1000),
            easing: [0.4, 0.0, 0.2, 1],
            translateX: [0, `${100 * -direction}%`]
        });

        // Show slide
        anime({
            targets: newSlide,
            duration: (this._transition * 1000),
            easing: [0.4, 0.0, 0.2, 1],
            translateX: [`${100 * direction}%`, 0],
            complete: ()=>{
                this.cleanGallery();
            }
        });
    }

    /**
     * This is the basic fade transition for the gallery.
     * Transitions are handled using animejs.
     * @see http://animejs.com/documentation/
     * @param { number } newSlideID What is the new slide ID
     * @param { number } currSlideID What is the current active slide ID
     */
    private handleFadeTransition(newSlideID:number, currSlideID:number): void{
        const currSlide = this._slides[currSlideID];
        const newSlide  = this._slides[newSlideID];

        // Hide slide
        anime({
            targets: currSlide,
            duration: (this._transition * 1000),
            easing: [0.4, 0.0, 0.2, 1],
            opacity: [1,0],
            zIndex: 1
        });

        // Show slide
        anime({
            targets: newSlide,
            duration: (this._transition * 1000),
            easing: [0.4, 0.0, 0.2, 1],
            opacity: [0,1],
            zIndex: 2,
            complete: ()=>{
                this.cleanGallery();
            }
        });
    }

    /**
     * This is the basic stack transition for the gallery.
     * Transitions are handled using animejs.
     * @see http://animejs.com/documentation/
     * @param { number } newSlideID The array index value of our new slide
     * @param { number } currSlideID The array index value of the current slide
     * @param { number } direction What direciton we should transition
     */
    private handleStackTransition(newSlideID:number, currSlideID:number, direction:number): void{
        const currSlide = this._slides[currSlideID];
        const newSlide  = this._slides[newSlideID];

        const slideEl = <HTMLElement>currSlide;
        slideEl.style.zIndex = '1';

        const newEl = <HTMLElement>newSlide;
        newEl.style.zIndex = '5';

        // Show slide
        anime({
            targets: newSlide,
            duration: (this._transition * 1000),
            easing: [0.4, 0.0, 0.2, 1],
            translateX: [`${100 * direction}%`, 0],
            complete: ()=>{
                // Hide slide
                anime({
                    targets: currSlide,
                    duration: 100,
                    translateX: `100%`,
                    complete: ()=>{
                        this.cleanGallery();
                    }
                });
            }
        });
    }

    /**
     * This is the basic parallax transition for the gallery.
     * Transitions are handled using animejs.
     * @see http://animejs.com/documentation/
     * @param { number } newSlideID The array index value of our new slide
     * @param { number } currSlideID The array index value of the current slide
     * @param { number } direction What direciton we should transition
     */
    private handleParallaxTransition(newSlideID:number, currSlideID:number, direction:number): void{
        const currSlide = <HTMLElement>this._slides[currSlideID];
        const newSlide  = <HTMLElement>this._slides[newSlideID];

        const currSlideImg = currSlide.querySelector('.js-img');
        const newSlideImg = newSlide.querySelector('.js-img');

        // Show slide
        anime({
            targets: newSlide,
            duration: (this._transition * 2000),
            easing: [0.4, 0.0, 0.2, 1],
            translateX: [`${100 * direction}%`, 0],
        });

        // New Image
        anime({
            targets: newSlideImg,
            duration: (this._transition * 2000),
            easing: [0.4, 0.0, 0.2, 1],
            translateX: [`${50 * -direction}%`, 0],
        });

        // Hide slide
        anime({
            targets: currSlide,
            duration: (this._transition * 2000),
            easing: [0.4, 0.0, 0.2, 1],
            translateX: [0, `${100 * -direction}%`],
            complete: ()=>{
                this.cleanGallery();
            }
        });

        // Old Image
        anime({
            targets: currSlideImg,
            duration: (this._transition * 2000),
            easing: [0.4, 0.0, 0.2, 1],
            translateX: [0, `${50 * direction}%`],
        });
    }

    /**
     * Handles switching slides.
     * First we get our current slide ID.
     * Then we set our new slide ID based on the current slide ID and the direction we're heading.
     * Then we handle the edges of the array to loop our new slide ID.
     * We set `isDirty` to true to prevent additional transitions from triggering along with user input.
     * Use the switch to handle the different gallery transition types.
     * Finally we set our `slideID` variable to the value of our `newSlideID`.
     * @param { number } direction Decides what direction in the slides array is the gallery going. Default value is `1`.
     */
    private switchSlides(direction:number = 1): void{
        const currSlideID = this._slideID;
        let newSlideID = this._slideID + direction;
        if(newSlideID < 0) newSlideID = this._slides.length - 1;
        else if(newSlideID >= this._slides.length) newSlideID = 0;

        this._isDirty = true;

        switch(this._style){
            case 'fade':
                this.handleFadeTransition(newSlideID, currSlideID);
                break;
            case 'slide':
                this.handleSlideTransition(newSlideID, currSlideID, direction);
                break;
            case 'stack':
                this.handleStackTransition(newSlideID, currSlideID, direction);
                break;
            case 'parallax':
                this.handleParallaxTransition(newSlideID, currSlideID, direction);
                break;
        }

        this._slideID = newSlideID;
    }

    /**
     * This is the callback loop for the `requestAnimationFrame`.
     * It is called along with the DOM's repaint call.
     * We calculate `deltaTime` by comparing the differences inbetween the callbacks.
     * If the gallery is not dirty subtract `deltaTime` from `this.counter`.
     * If the DOM has the users focus and they gallery is out of time and it's not already dirty
     * handle the slide switch.
     * Finally we pass our callback method back into `reqeustAnimationFrame` to be called again.
     * @see https://developer.mozilla.org/en-US/docs/Web/API/window/requestAnimationFrame
     */
    private callbackLoop(): void{
        const timeNew   = Date.now();
        const deltaTime = (timeNew - this._time) / 1000;
        this._time       = timeNew;

        if(!this._isDirty) this._counter -= deltaTime;

        if(document.hasFocus()){
            if(this._counter <= 0 && !this._isDirty) this.switchSlides(1);
        }

        window.requestAnimationFrame(() => this.callbackLoop());
    }

    /**
     * This method handles our aciton buttons click events.
     * When a user clicks on a button we find our actual button using `getParent`.
     * Once we have our button element we grab the direciton of the button.
     * Then we call the switch slides method and pass along the desired direciton.
     * @param { Event } e Event fired when a user clicks our galleries action buttons
     */
    private handleActionButton(e:Event): void{
        if(e.target instanceof Element){
            const button = getParent(e.target, 'js-button');
            const direction = parseInt(button.getAttribute('data-direction'));
            if(!this._isDirty) this.switchSlides(direction);
        }
    }

    /**
     * Called when the module is destroyed
     * Remove all event listners before calling super.destory()
     */
    public destroy(): void{
        this._actionsEls.forEach((el)=>{ el.removeEventListener('click', e => this.handleActionButton(e) ); });
        this.callbackLoop = ()=>{};
        super.destroy(isDebug, BasicGallery.MODULE_NAME);
    }
}
