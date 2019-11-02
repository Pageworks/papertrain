import { DeviceManager } from '../packages/device-manager.js';

declare var stylesheets : Array<string>;
declare var packages : Array<string>;
declare var components : Array<string>;
declare var modules : Array<string>;
declare var criticalCss : Array<string>;
declare var libraries : Array<string>;

class Runtime
{
    private _initialFetch : boolean;

    constructor()
    {
        this._initialFetch = true;
        this.init();
    }

    private async fetchFile(element:Element, filename:string, filetype:string)
    {
        const url = `${ window.location.origin }/automation/${ filename }.${ filetype }`;
        switch (filetype)
        {
            case 'css':
                element.setAttribute('rel', 'stylesheet');
                element.setAttribute('href', url);
                break;
            case 'js':
                element.setAttribute('type', 'text/javascript');
                element.setAttribute('src', url);
                break;
        }
    }

    private fetchResources(fileListArray:Array<string>, element:string, filetype:string) : Promise<any>
    {
        return new Promise((resolve) => {
            if (fileListArray.length === 0)
            {
                resolve();
            }

            let count = 0;
            const required = fileListArray.length;

            while (fileListArray.length > 0)
            {
                const filename = fileListArray[0].replace(/(\.js)$|(\.css)$/gi, '');
                let el = document.head.querySelector(`${ element }[file="${ filename }.${ filetype }"]`);
                if (!el)
                {
                    el = document.createElement(element);
                    el.setAttribute('file', `${ filename }.${ filetype }`);
                    document.head.appendChild(el);
                    el.addEventListener('load', () => {
                        count++;
                        if (count === required)
                        {
                            resolve();
                        }
                    });
                    this.fetchFile(el, filename, filetype);
                }
                else
                {
                    count++;
                    if (count === required)
                    {
                        resolve();
                    }
                }

                fileListArray.splice(0, 1);
            }
        });
    }

    private criticalCssLoadCallback() : void
    {
        // Do something after the stylesheets finish loading
        document.documentElement.setAttribute('state', 'soft-loading');
    }

    private loadingCompleteCallback() : void
    {
        if (this._initialFetch)
        {
            this._initialFetch = false;

            /** Do something on initial load */
            new DeviceManager(false, true);
        }

        /** Do something every time the app loads or reloads */
        document.documentElement.setAttribute('state', 'idling');
    }

    private librariesLoadCallback() : void
    {
        /** Do something with 3rd party libraries */
    }

    private modulesLoadCallback() : void
    {
        const modulesLoadedEvent = new CustomEvent('runtime:modulesLoaded');
        document.dispatchEvent(modulesLoadedEvent);
    }

    private async getScripts()
    {
        try
        {
            await this.fetchResources(packages, 'script', 'js',);
            await this.fetchResources(libraries, 'script', 'js');
            this.librariesLoadCallback();
            await this.fetchResources(modules, 'script', 'js');
            this.modulesLoadCallback();
            await this.fetchResources(components, 'script', 'js');
            this.loadingCompleteCallback();
        }
        catch (error)
        {
            console.error(error);
        }
    }

    private async getStylesheets()
    {
        try
        {
            await this.fetchResources(criticalCss, 'link', 'css');
            this.criticalCssLoadCallback();
            await this.fetchResources(stylesheets, 'link', 'css');
        }
        catch (error)
        {
            console.error(error);
        }
    }

    private init() : void
    {
        window.addEventListener('load', () => {
            if ('requestIdleCallback' in window)
            {
                // @ts-ignore
                window.requestIdleCallback(()=>{
                    this.getStylesheets();
                    this.getScripts();
                });
            }
            else
            {
                this.getStylesheets();
                this.getScripts();
            }
        });
    }
}
new Runtime();