class Env
{
    public isDebug : boolean = false;

    constructor()
    {
        this.setDefaultDebug();
        this.stopLoading();
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