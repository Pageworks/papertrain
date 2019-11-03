class Env
{
    public isDebug : boolean = false;

    // @ts-ignore
    public isIE : boolean = !!window.MSInputMethodContext && !!document.documentMode;

    constructor()
    {
        this.setDefaultDebug();
    }

    public stopLoading() : void
    {
        document.documentElement.setAttribute('state', 'idling');
    }

    public startLoading() : void
    {
        document.documentElement.setAttribute('state', 'soft-loading');
    }

    private setDefaultDebug() : void
    {
        if (window.location.origin.match(/\.local/gi))
        {
            this.isDebug = true;
        }
        else if (document.documentElement.getAttribute('debug') !== null)
        {
            this.isDebug = true;
        }
    }
}
export const env:Env = new Env();