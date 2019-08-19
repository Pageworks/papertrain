const chalk = require('chalk');
const glob = require("glob");
const fs = require("fs");
const rimraf = require('rimraf');
const rollup = require('rollup');

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
            throw error;
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

                    let globalVariableName = fileData.match(/(?<=var\s).*?(?=\=[\s]\(function)/)[0].trim();

                    let newData = '(function(){\n';
                    newData += fileData;
                    newData += `\nwindow.${ globalVariableName } = new ${ globalVariableName }();\n`;
                    newData += '})();\n';

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
