interface Window
{
    stylesheets : Array<string>
    packages : Array<string>
    components : Array<string>
    modules : Array<string>
    criticalCss : Array<string>
    libraries : Array<string>
}

class Runtime
{
    private _initialFetch : boolean;

    constructor()
    {
        this._initialFetch = true;
        this.init();
    }

    private handleStylesheetsFetchEvent:EventListener = this.getStylesheets.bind(this);
    private handleScriptFetchEvent:EventListener = this.getScripts.bind(this);

    private async fetchFile(element:Element, filename:string, filetype:string, directory:string)
    {
        switch (filetype)
        {
            case 'css':
                element.setAttribute('rel', 'stylesheet');
                element.setAttribute('href', `${ window.location.origin }/automation/${ directory }-${ document.documentElement.dataset.cachebust }/${ filename }.${ filetype }`);
                break;
            case 'js':
                element.setAttribute('type', 'text/javascript');
                element.setAttribute('src', `${ window.location.origin }/automation/${ directory }-${ document.documentElement.dataset.cachebust }/${ filename }.${ filetype }`);
                break;
        }
    }

    private fetchResources(fileListArray:Array<string>, element:string, filetype:string, directory:string) : Promise<any>
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
                    this.fetchFile(el, filename, filetype, directory);
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
        const pageLoadingElement = document.body.querySelector('page-loading');
        setTimeout(() => {
            pageLoadingElement.classList.remove('is-loading');
        }, 250);
    }

    private loadingCompleteCallback() : void
    {
        if (this._initialFetch)
        {
            this._initialFetch = false;

            /** Do something on initial load */
        }

        /** Do something every time the app loads or reloads */
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
            await this.fetchResources(window.packages, 'script', 'js', 'packages');
            await this.fetchResources(window.libraries, 'script', 'js', 'libraries');
            this.librariesLoadCallback();
            await this.fetchResources(window.modules, 'script', 'js', 'modules');
            this.modulesLoadCallback();
            await this.fetchResources(window.components, 'script', 'js', 'components');
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
            await this.fetchResources(window.criticalCss, 'link', 'css', 'styles');
            this.criticalCssLoadCallback();
            await this.fetchResources(window.stylesheets, 'link', 'css', 'styles');
        }
        catch (error)
        {
            console.error(error);
        }
    }

    private init() : void
    {
        document.addEventListener('load', () => {
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
                console.warn('Idle callback prototype not available in this browser, fetching stylesheets');
                this.getStylesheets();
                this.getScripts();
            }
        });

        document.addEventListener('fetch:stylesheets', this.handleStylesheetsFetchEvent);
        document.addEventListener('fetch:scripts', this.handleScriptFetchEvent);
    }
}
