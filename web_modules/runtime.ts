interface Window
{
    stylesheets : Array<string>
    packages : Array<string>
    components : Array<string>
    modules : Array<string>
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

    private getStylesheets() : void
    {
        new Promise((resolve)=>{
            if (window.stylesheets.length === 0)
            {
                resolve();
            }

            let fetched = 0;
            const requestedStylesheets = [...window.stylesheets];
            const numberOfRequiredFiles = requestedStylesheets.length;

            while (window.stylesheets.length)
            {
                const stylesheetFile = window.stylesheets[0];
                let styleElement:HTMLElement = document.head.querySelector(`style[file="${ stylesheetFile }"]`);
                if (!styleElement)
                {
                    styleElement = document.createElement('style');
                    styleElement.setAttribute('file', stylesheetFile);
                    document.head.appendChild(styleElement);
                    const stylesheetUrl = `${ window.location.origin }/automation/styles-${ document.documentElement.dataset.cachebust }/${ stylesheetFile }`;
                    this.fetchFile(stylesheetUrl)
                    .then(response => {
                        styleElement.innerHTML = response;
                    })
                    .catch(error => {
                        console.error(error);
                    })
                    .then(()=>{
                        fetched++;
                        if (fetched === numberOfRequiredFiles)
                        {
                            resolve();
                        }
                    });
                }
                else
                {
                    fetched++;
                    if (fetched === numberOfRequiredFiles)
                    {
                        resolve();
                    }
                }

                requestedStylesheets.splice(0, 1);
                window.stylesheets.splice(0, 1);
            }
        })
        .then(()=>{
            // Do something after the stylesheets finish loading
        });
    }

    private fetchFile(url:string) : Promise<string>
    {
        return new Promise((resolve, reject)=>{
            fetch(url, {
                method: 'GET',
                credentials: 'include',
                headers: new Headers({
                    'X-Requested-With': 'XMLHttpRequest'
                })
            })
            .then(request => request.text())
            .then(response => {
                resolve(response);
            })
            .catch(error => {   
                reject(error);
            });
        });
    }

    private getPackages() : Promise<string|null>
    {
        return new Promise((resolve, reject) => {
            if (window.packages.length === 0)
            {
                resolve();
            }
            
            let fetched = 0;
            const requestedPackages = [...window.packages];
            const numberOfRequiredFiles = requestedPackages.length;

            while (requestedPackages.length)
            {
                const file = requestedPackages[0];
                let element:HTMLElement = document.head.querySelector(`script[file="${ file }"]`);
                if (!element)
                {
                    element = document.createElement('script');
                    element.setAttribute('file', file);
                    document.head.appendChild(element);
                    const url = `${ window.location.origin }/automation/packages-${ document.documentElement.dataset.cachebust }/${ file }`;
                    this.fetchFile(url)
                    .then(response => {
                        element.innerHTML = response;
                        
                        fetched++;
                        if (fetched === numberOfRequiredFiles)
                        {
                            resolve();
                        }
                    })
                    .catch(error => {
                        reject(error);
                    });
                }
                else
                {
                    fetched++;
                    if (fetched === numberOfRequiredFiles)
                    {
                        resolve();
                    }
                }

                requestedPackages.splice(0, 1);
                window.packages.splice(0, 1);
            }
        });
    }

    private getModules() : Promise<string|null>
    {
        return new Promise((resolve, reject) => {
            if (window.modules.length === 0)
            {
                resolve();
            }

            let fetched = 0;
            const requestedModules = [...window.modules];
            const numberOfRequiredFiles = requestedModules.length;

            while (requestedModules.length)
            {
                const file = requestedModules[0];
                let element:HTMLElement = document.head.querySelector(`script[file="${ file }"]`);
                if (!element)
                {
                    element = document.createElement('script');
                    element.setAttribute('file', file);
                    document.head.appendChild(element); 
                    const url = `${ window.location.origin }/automation/modules-${ document.documentElement.dataset.cachebust }/${ file }`;
                    this.fetchFile(url)
                    .then(response => {
                        element.innerHTML = response;
                        
                        fetched++;
                        if (fetched === numberOfRequiredFiles)
                        {
                            resolve();
                        }
                    })
                    .catch(error => {
                        reject(error);
                    });
                }
                else
                {
                    fetched++;
                    if (fetched === numberOfRequiredFiles)
                    {
                        resolve();
                    }
                }

                requestedModules.splice(0, 1);
                window.modules.splice(0, 1);
            }
        });
    }

    private getComponents() : Promise<string|null>
    {
        return new Promise((resolve, reject) => {
            if (window.components.length === 0)
            {
                resolve();
            }

            let fetched = 0;
            const requestedComponents = [...window.components];
            const numberOfRequiredFiles = requestedComponents.length;

            while (requestedComponents.length)
            {
                const file = requestedComponents[0];
                let element:HTMLElement = document.head.querySelector(`script[file="${ file }"]`);
                if (!element)
                {
                    element = document.createElement('script');
                    element.setAttribute('file', file);
                    document.head.appendChild(element); 
                    const url = `${ window.location.origin }/automation/components-${ document.documentElement.dataset.cachebust }/${ file }`;
                    this.fetchFile(url)
                    .then(response => {
                        element.innerHTML = response;
                        
                        fetched++;
                        if (fetched === numberOfRequiredFiles)
                        {
                            resolve();
                        }
                    })
                    .catch(error => {
                        reject(error);
                    });
                }
                else
                {
                    fetched++;
                    if (fetched === numberOfRequiredFiles)
                    {
                        resolve();
                    }
                }

                requestedComponents.splice(0, 1);
                window.components.splice(0, 1);
            }
        });
    }

    private scriptsCallback() : void
    {
        if (this._initialFetch)
        {
            this._initialFetch = false;
            console.log('Initial scripts have finished loading');
        }
    }

    private async getScripts()
    {
        try
        {
            await this.getPackages();
            await this.getModules();
            await this.getComponents();
            this.scriptsCallback();
        }
        catch (error)
        {
            console.error(error);
        }
    }

    private init() : void
    {
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

        document.addEventListener('fetch:stylesheets', this.handleStylesheetsFetchEvent);
        document.addEventListener('fetch:scripts', this.handleScriptFetchEvent);
    }
}
