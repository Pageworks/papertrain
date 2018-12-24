export default class BaseTransition{

    constructor(){ }

    /**
     * Called by the TransitionManager when Pjax is switching pages
     * Used to start any custom page transition animaitons
     */
    public launch(): void{
        // Handle custom transition effects

        // Call when transition is finished
        this.launchFinished();
    }

    /**
     * Called when the base transition is finished hiding the page/content
     * Sends a `pjax:continue` event
     * This is used when Pjax is listening for a custom transition
     * @see https://github.com/Pageworks/fuel-pjax#pjax-options
     */
    public launchFinished(): void{
        const e = new Event('pjax:continue');
        document.dispatchEvent(e);
    }

    /**
     * Call by the TransitionManager when Pjax has switched pages
     * Used to stop any custom page transition animations
     */
    public hide(): void{
        // Handle custom transition effects

    }
}
