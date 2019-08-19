interface Window
{
    stylesheets: Array<string>
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
            let stylesheetUrl = window.stylesheets[0];

            let styleElement = document.head.querySelector(`style[component="${ stylesheetUrl }"]`);
            if (!styleElement)
            {
                styleElement = document.createElement('style');
                styleElement.setAttribute('component', stylesheetUrl);
                document.head.appendChild(styleElement);

                stylesheetUrl = `${ window.location.origin }/automation/styles-${ document.documentElement.dataset.cssTimestamp }/${ stylesheetUrl }`;
                fetch(stylesheetUrl)
                .then(request => request.text())
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

    private getScripts() : void
    {
        console.warn('Lazy script fetching is not implemented yet');
    }

    private init() : void
    {
        if ('requestIdleCallback' in window)
        {
            // @ts-ignore
            window.requestIdleCallback(this.getStylesheets);
        }
        else
        {
            console.warn('Idle callback prototype not available in this browser, fetching stylesheets');
            this.getStylesheets();
        }

        document.addEventListener('fetch:stylesheets', this.handleStylesheetsFetchEvent);
    }
}
