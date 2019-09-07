interface Window
{
    stylesheets : Array<string>
    packages : Array<string>
    components : Array<string>
    modules : Array<string>
    criticalCss : Array<string>
    libraries : Array<string>
    twig : Function
}

declare class Env
{
    public startLoading() : void
    public stopLoading() : void
    public isDebug : boolean
    public getState() : string
}

declare var env:Env

interface TwigOptions
{
    data?: string
    id?: string
    href?: string
    async?: boolean
    load?: (template:TwigTemplate)=>void
}

interface TwigTemplate
{
    render: (data:object)=>string
}

declare function twig(options:TwigOptions) : TwigTemplate

declare class TemplateManager
{
    /**
     * Fetches and prepares a Twig template object.
     * @see https://github.com/twigjs/twig.js/#browser-usage
     * @param filePath The path of `.twig` file relative to the `public/twig/` directory.
     * @returns A Promise that resolves with a Twig template object.
     * @example templateManager.loadTemplate('sample-template.twig').then(template => { this.sampleTemplate = template; });
     */
    public load(filePath:string) : Promise<TwigTemplate>;

    /**
     * Fetches and renders a Twig template object.
     * @param filePath The path of `.twig` file relative to the `public/twig/` directory.
     * @param data The JSON object that will be used to render the template.
     * @returns A Promise that resolves with the rendered template HTML as a string.
     * @example templateManager.ajax('sample-template.twig', { headline: "Hello world!" }).then(newHTML => { htmlElement.innerHTML = newHTML; });
     */
    public ajax(filePath:string, data:object) : Promise<string>;
}

declare var templateManager: TemplateManager;
