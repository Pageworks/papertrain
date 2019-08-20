const chalk = require('chalk');
const glob = require("glob");
const fs = require("fs");
const rimraf = require('rimraf');

class ComponentBundler
{
    constructor()
    {
        console.log(chalk.white('Bundling web components'));
        this.run();
    }

    async run()
    {
        try
        {
            const timestamp = await this.getTimestamp();
            await this.makeDirectory(timestamp);
            const files = await this.getCompiledFiles();
            await this.moveFiles(files, timestamp);
            await this.cleanup(timestamp);
        }
        catch (error)
        {
            console.log(chalk.hex('#ff6426').bold(error));
        }
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

    makeDirectory(timestamp)
    {
        return new Promise((resolve, reject)=>{
            fs.mkdir(`public/automation/components-${ timestamp }`, (err)=>{
                if (err)
                {
                    reject(err);
                }
    
                resolve();
            });
        });
    }

    getCompiledFiles()
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

    moveFiles(files, timestamp)
    {
        return new Promise((resolve, reject)=>{
            let count = 0;

            for (let i = 0; i < files.length; i++)
            {
                let filename = files[i].replace(/.*[\/]/, '').trim();
                fs.rename(files[i], `public/automation/components-${ timestamp }/${ filename }`, (error)=>{
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

    cleanup(timestamp)
    {
        console.log(chalk.white('Removing stale web component bundles'));

        const path = `public/automation`;
        const allDirs = fs.readdirSync(path);
        const styleDirs = [];
        for (let i = 0; i < allDirs.length; i++)
        {
            if (allDirs[i].match(/components-.*/))
            {
                styleDirs.push(allDirs[i]);
            }
        }

        for (let i = 0; i < styleDirs.length; i++)
        {
            const directoryTimestamp = styleDirs[i].match(/[^components-].*/)[0];

            if (parseInt(directoryTimestamp) < parseInt(timestamp)) 
            {
                rimraf(`public/automation/${ styleDirs[i] }`, (err)=>{
                    if (err)
                    {
                        console.log(`Failed to remove ${ styleDirs[i] }`);
                        throw err;
                    }
                });
            }
        }
    }
}

new ComponentBundler();