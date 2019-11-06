import { DeviceManager } from '../packages/device-manager.js';
import { env } from './env';

interface WorkerResponse
{
    type: 'eager'|'lazy',
    files: Array<string>,
}

type WebComponentLoad = null|'lazy'|'eager';

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
        window.addEventListener('DOMContentLoaded', this.handleLoadEvent);
    }

    private intersectionCallback:IntersectionObserverCallback = this.handleIntersection.bind(this);
    private handleLoadEvent:EventListener = this.init.bind(this);

    private init() : void
    {
        this._bodyParserWorker.postMessage({
            type: 'eager',
            body: document.body.innerHTML
        });
        this._bodyParserWorker.onmessage = this.handleWorkerMessage.bind(this);
        this._io = new IntersectionObserver(this.intersectionCallback);
        new DeviceManager(env.isDebug, true);
    }

    private upgradeToWebComponent(customElementTagName:string, customElement:Element) : void
    {
        /** TODO: drop IE 11 support when Edge becomes Chromium and switch to the dynamic import syntax */
        let el = document.head.querySelector(`script[file="${ customElementTagName }.js"]`);
        if (!el)
        {
            customElement.setAttribute('state', 'loading');
            el = document.createElement('script');
            el.setAttribute('file', `${ customElementTagName }.js`);
            document.head.append(el);
            if (!env.isIE)
            {
                el.addEventListener('load', () => {
                    customElement.setAttribute('state', 'loaded');
                });
            }
            else
            {
                customElement.setAttribute('state', 'loaded');
            }
            this.fetchFile(el, customElementTagName, 'js');
        }
        else
        {
            customElement.setAttribute('state', 'loaded');
        }
    }

    private handleIntersection(entries:Array<IntersectionObserverEntry>)
    {
        if (env.isIE)
        {
            return;
        }
        
        for (let i = 0; i < entries.length; i++)
        {
            if (entries[i].isIntersecting)
            {
                this._io.unobserve(entries[i].target);
                const customElement = entries[i].target.tagName.toLowerCase().trim();
                this.upgradeToWebComponent(customElement, entries[i].target);
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
                this._bodyParserWorker.postMessage({
                    type: 'lazy',
                    body: document.body.innerHTML
                });
                this.handleWebComponents();
            });
        }
        else if (response.type === 'lazy')
        {
            const ticket = env.startLoading();
            this.fetchResources(response.files, 'link', 'css').then(() => {
                env.stopLoading(ticket);
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
                    if (!env.isIE)
                    {
                        el.addEventListener('load', () => {
                            loaded++;
                            if (loaded === fileList.length)
                            {
                                resolve();
                            }
                        });
                    }
                    else
                    {
                        setTimeout(() => {
                            loaded++;
                            if (loaded === fileList.length)
                            {
                                resolve();
                            }
                        }, 250);
                    }
                    
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
            const element = customElements[i];
            const loadType = element.getAttribute('loading') as WebComponentLoad;

            if (loadType === 'eager')
            {
                const customElement = element.tagName.toLowerCase().trim();
                this.upgradeToWebComponent(customElement, element);
            }
            else
            {
                element.setAttribute('state', 'unseen');
                this._io.observe(customElements[i]);
            }
        }
    }
}
new Runtime();