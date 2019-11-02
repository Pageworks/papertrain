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

    constructor()
    {
        this._bodyParserWorker = new Worker(`${ window.location.origin }/automation/body-parser.js`);
        window.addEventListener('load', () => {
            this._bodyParserWorker.postMessage(document.body.innerHTML);
        });
        this._bodyParserWorker.onmessage = this.handleWorkerMessage.bind(this);
        
        new DeviceManager(env.isDebug, true);
    }

    private handleWorkerMessage(e:MessageEvent)
    {
        const response:WorkerResponse = e.data;
        if (response.type === 'eager')
        {
            this.fetchResources(response.files, 'link', 'css').then(() => {
                document.documentElement.setAttribute('state', 'idling');
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
}
new Runtime();