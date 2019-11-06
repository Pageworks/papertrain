import { uuid } from '../packages/uuid';

class Env
{
    // @ts-ignore
    public isIE : boolean = !!window.MSInputMethodContext && !!document.documentMode;
    public isDebug : boolean = false;

    private _tickets : Array<string>;

    constructor()
    {
        this._tickets = [];
        this.setDefaultDebug();
    }

    /**
     * Attempts to set the DOM to the `idling` state. The DOM will only idle when all `startLoading()` methods have been resolved.
     * @param ticket - the `string` the was provided by the `startLoading()` method.
     */
    public stopLoading(ticket:string) : void
    {
        if (!ticket && typeof ticket !== 'string')
        {
            console.error(`A ticket with the typeof 'string' is required to end the loading state.`);
            return;
        }

        for (let i = 0; i < this._tickets.length; i++)
        {
            if (this._tickets[i] === ticket)
            {
                this._tickets.splice(i, 1);
                break;
            }
        }

        if (this._tickets.length === 0)
        {
            document.documentElement.setAttribute('state', 'idling');
        }
    }

    /**
     * Sets the DOM to the `soft-loading` state.
     * @returns a ticket `string` that is required to stop the loading state.
     */
    public startLoading() : string
    {
        document.documentElement.setAttribute('state', 'soft-loading');
        const ticket = uuid();
        this._tickets.push(ticket);
        return ticket;
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