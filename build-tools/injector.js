const fs = require('fs');
const glob = require("glob");

class InjectionManager
{
    constructor()
    {
        this.run();
    }

    async run()
    {
        try
        {
            const newFiles = await this.getFiles();
            await this.injectComponents(newFiles);
        }
        catch (error)
        {
            console.log(error);
        }
    }

    getFiles()
    {
        return new Promise((resolve, reject)=>{
            glob('_watcher/**/*.js', (error, files)=>{
                if (error)
                {
                    reject(error);
                }

                resolve(files);
            });
        });
    }

    injectComponents(files)
    {
        return new Promise((resolve, reject)=>{
            let count = 0;
            for (let i = 0; i < files.length; i++)
            {
                let filename = files[i].replace(/.*[\/]/, '').trim();
                fs.rename(files[i], `public/automation/${ filename }`, (error) => {
                    if (error)
                    {
                        reject(error);
                    }

                    count++;
                    if (count === files.length)
                    {
                        resolve();
                    }
                });
            }
        });
    }
}

new InjectionManager();