class Env
{
    private _domState = 'loading';
    private _debugState = false;

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
        if (window.location.hostname.match(/.local/gi))
        {
            this._debugState = true;
        }
        else if (document.documentElement.getAttribute('debug') !== null)
        {
            this._debugState = true;
        }
    }

    public isDebug = ()=>{
        return this._debugState;
    }
}

new Env();