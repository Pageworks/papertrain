const glob = require('glob');
const fs = require('fs');

class ScriptScrubber
{
    constructor()
    {
        this.run();
    }

    async run()
    {
        try
        {
            const files = await this.getFiles();
            await this.createScrubbedDirectory();
            await this.scrubFiles(files);
        }
        catch (error)
        {
            console.log(error);
        }
    }

    createScrubbedDirectory()
    {
        return new Promise((resolve, reject) => {
            fs.mkdir('_ie', (error) => {
                if (error)
                {
                    reject(error);
                }

                resolve();
            });
        });
    }

    async scrubFiles(files)
    {
        let scrubbed = 0;
        for (let i = 0; i < files.length; i++)
        {
            const file = files[i];
            const filename = file.replace(/.*\//g, '');
            fs.readFile(file, (error, buffer) => {
                if (error)
                {
                    throw error;
                }

                /** Removes export keyword and import statements */
                let data = buffer.toString().replace(/(export\s+)/g, '').replace(/(import.*?\;)/g, '');

                fs.writeFile(`_ie/${ filename }`, data, (error) => {
                    if (error)
                    {
                        throw error;
                    }

                    scrubbed++;
                    if (scrubbed === files.length)
                    {
                        return;
                    }
                });
            });
        }
    }

    getFiles()
    {
        return new Promise((resolve, reject) => {
            glob('_compiled/**/*.js', (error, files) => {
                if (error)
                {
                    reject(error);
                }

                const validFiles = [];
                for (let i = 0; i < files.length; i++)
                {
                    const filePath = files[i];
                    if (!filePath.match('/web-workers/'))
                    {
                        validFiles.push(filePath);
                    }
                }

                resolve(validFiles);
            });
        });
    }
}
new ScriptScrubber();