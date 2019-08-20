const chalk = require('chalk');
const glob = require("glob");
const fs = require("fs");
const rimraf = require('rimraf');

class WebModuleBundler
{
    constructor()
    {
        console.log(chalk.white('Bundling web modules'));
        this.run();
    }

    async run()
    {
        try
        {
            const timestamp = await this.getTimestamp();
            await this.makeDirectory(timestamp);
            const modules = await this.getWebModules();
            await this.bundle(modules, timestamp);
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
            fs.mkdir(`public/automation/modules-${ timestamp }`, (err)=>{
                if (err)
                {
                    reject(err);
                }
    
                resolve();
            });
        });
    }

    getWebModules()
    {
        return new Promise((resolve, reject)=>{
            glob('_modules/**/*.js', (err, files)=>{
                if (err)
                {
                    reject(err);
                }
    
                resolve(files);
            });
        });
    }

    bundle(modules, timestamp)
    {
        return new Promise((resolve, reject)=>{
            let count = 0;

            for (let i = 0; i < modules.length; i++)
            {
                fs.readFile(modules[i], (err, data)=>{
                    if (err)
                    {
                        reject(err);
                    }

                    let fileData = data.toString();

                    let globalVariableName = fileData.match(/(?<=class).*(?=\{)/)[0].trim();

                    let newData = fileData;
                    newData += `\nvar ${ globalVariableName.toLowerCase() } = new ${ globalVariableName }();\n`;

                    let serverSafeName = modules[i].replace(/^.*[\\\/]/, '').toLowerCase();
                    // let importName = serverSafeName.replace(/\.js/, '');
                    // let exportName = data.toString().match(/(?<=exports\.).*\=/)[0].replace(/(\=.*)/, '').trim();

                    // let newData = `import { ${ exportName } } from '${ importName }'\n`;
                    // newData += `\nwindow.${ importName } = ${ exportName };`;

                    fs.writeFile(`public/automation/modules-${ timestamp }/${ serverSafeName }`, newData, (err)=>{
                        if (err)
                        {
                            reject(err);
                        }

                        console.log(chalk.hex('#ffffff').bold(serverSafeName), chalk.hex('#8cf57b').bold(' [bundled]'));

                        count++;
                        if (count === modules.length)
                        {
                            resolve();
                        }
                    });
                });
            }
        });
    }

    cleanup(timestamp)
    {
        console.log(chalk.white('Removing stale web module bundles'));

        const path = `public/automation`;
        const allDirs = fs.readdirSync(path);
        const styleDirs = [];
        for (let i = 0; i < allDirs.length; i++)
        {
            if (allDirs[i].match(/modules-.*/))
            {
                styleDirs.push(allDirs[i]);
            }
        }

        for (let i = 0; i < styleDirs.length; i++)
        {
            const directoryTimestamp = styleDirs[i].match(/[^modules-].*/)[0];

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

new WebModuleBundler();
