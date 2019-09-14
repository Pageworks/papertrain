declare var uuid:Function;

class Env
{
    private _domState = 'loading';

    public isDebug : boolean = false;

    constructor()
    {
        this.setDefaultDebug();
        this.stopLoading();
    }

    public stopLoading() : void
    {
        document.documentElement.classList.remove('dom-is-loading');
        this._domState = 'idling';
    }

    public startLoading() : void
    {
        document.documentElement.classList.add('dom-is-loading');
        this._domState = 'loading';
    }

    public getState() : string
    {
        return this._domState;
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