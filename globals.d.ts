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
