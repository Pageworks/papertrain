import { isDebug } from '../env';
import AbstractModule from './AbstractModule';
import anime from 'animejs';
import { getParent } from '../utils/getParent';

const MODULE_NAME = 'BasicGallery';

export default class extends AbstractModule{
    style:      string
    timing:     number
    slides:     NodeList
    actionsEls: NodeList
    counter:    number
    transition: number
    baseTime:   number
    time:       number
    slideID:    number
    isDirty:    boolean

    constructor(el: Element){
        super(el);
        if(isDebug) console.log('%c[module] '+`%cBuilding: ${MODULE_NAME} - ${this.uuid}`,'color:#4688f2','color:#eee');

        // CMS Input Data
        this.style      = this.el.getAttribute('data-style');
        this.timing     = parseInt(this.el.getAttribute('data-timing'));
        
        // NodeLists
        this.slides     = this.el.querySelectorAll('.js-slide');
        this.actionsEls = this.el.querySelectorAll('.js-button');

        // Gallery Data
        this.transition = 0.3;
        this.counter    = this.timing;
        this.time       = null;
        this.isDirty    = false;
        this.slideID    = 0;
    }

    /**
     * Called when the module is created
     * Used to call any initial methods or to
     * register any initial event listeners
     */
    init(){
        this.actionsEls.forEach((el)=>{ el.addEventListener('click', e => this.handleActionButton(e) ); });

        // Only start our loop if the gallery IS NOT set to manual transition
        if(this.timing !== -1){
            this.time = Date.now();
            window.requestAnimationFrame(() => this.callbackLoop());
        }
    }

    /**
     * Resets the counter and the galleries `isDirty` status.
     */
    cleanGallery(){
        this.counter = this.timing;
        this.isDirty = false;
    }

    /**
     * This is the basic slide transition for the gallery.
     * Transitions are handled using animejs.
     * @see http://animejs.com/documentation/
     * @param { number } newSlideID What is the new slide ID
     * @param { number } currSlideID What is the current active slide ID
     * @param { number } direction What direction is the gallery going
     */
    handleSlideTransition(newSlideID:number, currSlideID:number, direction:number){
        const currSlide = this.slides[currSlideID];
        const newSlide  = this.slides[newSlideID];

        // Hide slide
        anime({
            targets: currSlide,
            duration: (this.transition * 1000),
            easing: [0.4, 0.0, 0.2, 1],
            translateX: [0, `${100 * -direction}%`]
        });

        // Show slide
        anime({
            targets: newSlide,
            duration: (this.transition * 1000),
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
    handleFadeTransition(newSlideID:number, currSlideID:number){
        const currSlide = this.slides[currSlideID];
        const newSlide  = this.slides[newSlideID];

        // Hide slide
        anime({
            targets: currSlide,
            duration: (this.transition * 1000),
            easing: [0.4, 0.0, 0.2, 1],
            opacity: [1,0],
            zIndex: 1
        });

        // Show slide
        anime({
            targets: newSlide,
            duration: (this.transition * 1000),
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
    handleStackTransition(newSlideID:number, currSlideID:number, direction:number){
        const currSlide = this.slides[currSlideID];
        const newSlide  = this.slides[newSlideID];

        const slideEl = <HTMLElement>currSlide;
        slideEl.style.zIndex = '1';

        const newEl = <HTMLElement>newSlide;
        newEl.style.zIndex = '5';

        // Show slide
        anime({
            targets: newSlide,
            duration: (this.transition * 1000),
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
    handleParallaxTransition(newSlideID:number, currSlideID:number, direction:number){
        const currSlide = <HTMLElement>this.slides[currSlideID];
        const newSlide  = <HTMLElement>this.slides[newSlideID];

        const currSlideImg = currSlide.querySelector('.js-img');
        const newSlideImg = newSlide.querySelector('.js-img');

        // Show slide
        anime({
            targets: newSlide,
            duration: (this.transition * 2000),
            easing: [0.4, 0.0, 0.2, 1],
            translateX: [`${100 * direction}%`, 0],
        });

        // New Image
        anime({
            targets: newSlideImg,
            duration: (this.transition * 2000),
            easing: [0.4, 0.0, 0.2, 1],
            translateX: [`${50 * -direction}%`, 0],
        });

        // Hide slide
        anime({
            targets: currSlide,
            duration: (this.transition * 2000),
            easing: [0.4, 0.0, 0.2, 1],
            translateX: [0, `${100 * -direction}%`],
            complete: ()=>{
                this.cleanGallery();
            }
        });

        // Old Image
        anime({
            targets: currSlideImg,
            duration: (this.transition * 2000),
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
    switchSlides(direction:number = 1){
        const currSlideID = this.slideID;
        let newSlideID = this.slideID + direction;
        if(newSlideID < 0) newSlideID = this.slides.length - 1;
        else if(newSlideID >= this.slides.length) newSlideID = 0;
        
        this.isDirty = true;

        switch(this.style){
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

        this.slideID = newSlideID;
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
    callbackLoop(){
        const timeNew   = Date.now();
        const deltaTime = (timeNew - this.time) / 1000;
        this.time       = timeNew;

        if(!this.isDirty) this.counter -= deltaTime;

        if(document.hasFocus()){
            if(this.counter <= 0 && !this.isDirty) this.switchSlides(1);
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
    handleActionButton(e:Event){
        if(e.target instanceof Element){
            const button = getParent(e.target, 'js-button');
            const direction = parseInt(button.getAttribute('data-direction'));
            if(!this.isDirty) this.switchSlides(direction);
        }
    }

    /**
     * Called when the module is destroyed
     * Remove all event listners before calling super.destory()
     */
    destroy(){
        this.actionsEls.forEach((el)=>{ el.removeEventListener('click', e => this.handleActionButton(e) ); });
        this.callbackLoop = ()=>{};
        super.destroy(isDebug, MODULE_NAME);
    }
}