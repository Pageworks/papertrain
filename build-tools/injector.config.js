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
            const timestamp = await this.getTimestamp();
            await this.injectComponents(newFiles, timestamp);
        }
        catch (error)
        {
            console.log(error);
        }
    }

    getFiles()
    {
        return new Promise((resolve, reject)=>{
            glob('_compiled/es6/**/*.js', (error, files)=>{
                if (error)
                {
                    reject(error);
                }

                resolve(files);
            });
        });
    }

    getTimestamp()
    {
        return new Promise((resolve, reject)=>{
            fs.readFile('config/papertrain/automation.php', (error, buffer)=>{
                if (error)
                {
                    reject(error);
                }

                const data = buffer.toString();
                const timestamp = data.match(/\d+/g)[0];

                resolve(timestamp);
            });
        });
    }

    injectComponents(files, timestamp)
    {
        return new Promise((resolve, reject)=>{
            let count = 0;

            for (let i = 0; i < files.length; i++)
            {
                let filename = files[i].replace(/.*[\/]/, '').trim();
                fs.copyFile(files[i], `public/automation/components-${ timestamp }/${ filename }`, (error)=>{
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