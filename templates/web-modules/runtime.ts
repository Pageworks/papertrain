import { DeviceManager } from '../packages/device-manager.js';
import { env } from './env';

interface WorkerResponse
{
    type: 'eager'|'lazy',
    files: Array<string>,
}

class Runtime
{
    private _bodyParserWorker : Worker;
    private _io : IntersectionObserver;

    constructor()
    {
        if (env.isIE)
        {
            this._bodyParserWorker = new Worker(`${ window.location.origin }/ie/body-parser.js`);
        }
        else
        {
            this._bodyParserWorker = new Worker(`${ window.location.origin }/automation/body-parser.js`);
        }
        window.addEventListener('load', this.handleLoadEvent);
    }

    private intersectionCallback:IntersectionObserverCallback = this.handleIntersection.bind(this);
    private handleLoadEvent:EventListener = this.init.bind(this);

    private init() : void
    {
        this._bodyParserWorker.postMessage(document.body.innerHTML);
        this._bodyParserWorker.onmessage = this.handleWorkerMessage.bind(this);
        this._io = new IntersectionObserver(this.intersectionCallback);
        new DeviceManager(env.isDebug, true);
    }

    private handleIntersection(entries:Array<IntersectionObserverEntry>)
    {
        for (let i = 0; i < entries.length; i++)
        {
            if (entries[i].isIntersecting)
            {
                /** TODO: drop IE 11 support when Edge becomes Chromium and switch to the dynamic import syntax */
                this._io.unobserve(entries[i].target);
                entries[i].target.setAttribute('state', 'loading');
                const customElement = entries[i].target.tagName.toLowerCase().trim();
                let el = document.head.querySelector(`script[file="${ customElement }.js"]`);
                if (!el)
                {
                    el = document.createElement('script');
                    el.setAttribute('file', `${ customElement }.js`);
                    document.head.append(el);
                    el.addEventListener('load', () => {
                        entries[i].target.setAttribute('state', 'loaded');
                    });
                    this.fetchFile(el, customElement, 'js');
                }
                else
                {
                    entries[i].target.setAttribute('state', 'loaded');
                }
            }
        }
    }

    private handleWorkerMessage(e:MessageEvent)
    {
        const response:WorkerResponse = e.data;
        if (response.type === 'eager')
        {
            this.fetchResources(response.files, 'link', 'css').then(() => {
                document.documentElement.setAttribute('state', 'idling');
                this.handleWebComponents();
            });
        }
        else if (response.type === 'lazy')
        {
            document.documentElement.setAttribute('state', 'soft-loading');
            this.fetchResources(response.files, 'link', 'css').then(() => {
                document.documentElement.setAttribute('state', 'idling');
            });
        }
    }

    private async fetchFile(element:Element, filename:string, filetype:'css'|'js')
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

    private fetchResources(fileList:Array<string>, element:'link'|'script', filetype:'css'|'js') : Promise<any>
    {
        return new Promise((resolve) => {
            if (fileList.length === 0)
            {
                resolve();
            }

            let loaded = 0;
            for (let i = 0; i < fileList.length; i++)
            {
                const filename = fileList[i];
                let el = document.head.querySelector(`${ element }[file="${ filename }.${ filetype }"]`);
                if (!el)
                {
                    el = document.createElement(element);
                    el.setAttribute('file', `${ filename }.${ filetype }`);
                    document.head.append(el);
                    el.addEventListener('load', () => {
                        loaded++;
                        if (loaded === fileList.length)
                        {
                            resolve();
                        }
                    });
                    this.fetchFile(el, filename, filetype);
                }
                else
                {
                    loaded++;
                    if (loaded === fileList.length)
                    {
                        resolve();
                    }
                }
            }
        });
    }

    private handleWebComponents() : void
    {
        const customElements = Array.from(document.body.querySelectorAll('[web-component]:not([state])'));
        for (let i = 0; i < customElements.length; i++)
        {
            customElements[i].setAttribute('state', 'unseen');
            this._io.observe(customElements[i]);
        }
    }
}
new Runtime();