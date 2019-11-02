self.onmessage = (e:MessageEvent) => {
    parseEagerLoadedCSS(e.data);
}

function respondWithFiles(responseType:'eager'|'lazy', fileNames:Array<string>)
{
    // @ts-ignore
    self.postMessage({
        type: responseType,
        files: fileNames
    });
}

function parseLazyLoadedCSS(body:string)
{
    const matches = body.match(/(lazy-load-css\=[\'\"].*?[\'\"])/gi);
    const files:Array<string> = [];
    if (matches)
    {
        matches.map((match:string) => {
            const clean = match.replace(/(lazy-load-css\=[\'\"])|[\'\"]$/g, '');
            const filenames = clean.trim().split(' ');
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
    respondWithFiles('lazy', files);
}

function parseEagerLoadedCSS(body:string)
{
    const matches = body.match(/(eager-load-css\=[\'\"].*?[\'\"])/gi);
    const files:Array<string> = [];
    if (matches)
    {
        matches.map((match:string) => {
            const clean = match.replace(/(eager-load-css\=[\'\"])|[\'\"]$/g, '');
            const filenames = clean.trim().split(' ');
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
    respondWithFiles('eager', files);
    parseLazyLoadedCSS(body);
}