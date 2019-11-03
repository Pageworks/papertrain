/** TODO: Refactor using async/await once we drop support for IE 11 */

onmessage = (e:MessageEvent) => {
    switch (e.data.type)
    {
        case 'eager':
            parseEagerLoadedCSS(e.data.body);
            break;
        case 'lazy':
            parseLazyLoadedCSS(e.data.body);
            break;
    }
}

function respondWithFiles(responseType:'eager'|'lazy', fileNames:Array<string>)
{
    // @ts-ignore
    postMessage({
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
    const uniqueFiles:Array<string> = [];
    for (let i = 0; i < files.length; i++)
    {
        let isUnique = true;
        for (let k = 0; k < uniqueFiles.length; k++)
        {
            if (files[i] === uniqueFiles[k])
            {
                isUnique = false;
            }
        }
        if (isUnique)
        {
            uniqueFiles.push(files[i]);
        }
    }
    respondWithFiles('lazy', uniqueFiles);
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
    const uniqueFiles:Array<string> = [];
    for (let i = 0; i < files.length; i++)
    {
        let isUnique = true;
        for (let k = 0; k < uniqueFiles.length; k++)
        {
            if (files[i] === uniqueFiles[k])
            {
                isUnique = false;
            }
        }
        if (isUnique)
        {
            uniqueFiles.push(files[i]);
        }
    }
    respondWithFiles('eager', uniqueFiles);
}