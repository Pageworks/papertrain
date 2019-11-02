self.onmessage = (e:MessageEvent) => {
    parseCSS(e.data);
}

async function parseCSS(body:string)
{
    try
    {
        const eagerCssFiles = await parseEagerLoadedCSS(body);
        respondWithFiles('eager', eagerCssFiles);
        const lazyCssFiles = await parseLazyLoadedCSS(body);
        respondWithFiles('lazy', lazyCssFiles);
    }
    catch (error)
    {
        console.error(error);
    }
}

function respondWithFiles(responseType:'eager'|'lazy', fileNames:Array<string>)
{
    // @ts-ignore
    self.postMessage({
        type: responseType,
        files: fileNames
    });
}

function parseLazyLoadedCSS(body:string) : Promise<Array<string>>
{
    return new Promise((resolve) => {
        const matches = body.match(/(?<=lazy-load-css\=[\'\"]).*?(?=[\'\"])/gi);
        const files:Array<string> = [];
        if (matches)
        {
            matches.map((match:string) => {
                const filenames = match.trim().split(' ');
                if (filenames)
                {
                    filenames.map((filename) => {
                        const cleanFilename = filename.trim().toLowerCase().replace(/(\.css)$|(\.scss)$/g, '');
                        if (cleanFilename !== '')
                        {
                            files.push(cleanFilename);
                        }
                    });
                }
            });
        }
        resolve(files);
    });
}

function parseEagerLoadedCSS(body:string) : Promise<Array<string>>
{
    return new Promise((resolve) => {
        const matches = body.match(/(?<=eager-load-css\=[\'\"]).*?(?=[\'\"])/gi);
        const files:Array<string> = [];
        if (matches)
        {
            matches.map((match:string) => {
                const filenames = match.trim().split(' ');
                if (filenames)
                {
                    filenames.map((filename) => {
                        const cleanFilename = filename.trim().toLowerCase().replace(/(\.css)$|(\.scss)$/g, '');
                        if (cleanFilename !== '')
                        {
                            files.push(cleanFilename);
                        }
                    });
                }
            });
        }
        resolve(files);
    });
}