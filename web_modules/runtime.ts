interface Window
{
    stylesheets : Array<string>
    packages : Array<string>
    components : Array<string>
    modules : Array<string>
}

class Runtime
{
    constructor()
    {
        this.init();
    }

    private handleStylesheetsFetchEvent:EventListener = this.getStylesheets;
    private handleScriptFetchEvent:EventListener = this.getScripts;

    private getStylesheets() : void
    {
        while (window.stylesheets.length)
        {
            let stylesheetFile = window.stylesheets[0];
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
                });
            }

            window.stylesheets.splice(0, 1);
        }
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
            const requestedPackages = window.packages;
            const numberOfRequiredFiles = requestedPackages.length;

            while (requestedPackages.length)
            {
                let file = requestedPackages[0];
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
            const requestedModules = window.modules;
            const numberOfRequiredFiles = requestedModules.length;

            while (requestedModules.length)
            {
                let file = requestedModules[0];
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

                requestedModules.splice(0, 1);
                window.modules.splice(0, 1);
            }
        });
    }

    private async getScripts()
    {
        try
        {
            await this.getPackages();
            await this.getModules();
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
        }

        document.addEventListener('fetch:stylesheets', this.handleStylesheetsFetchEvent);
        document.addEventListener('fetch:scripts', this.handleScriptFetchEvent);
    }
}
