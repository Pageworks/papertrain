const chalk = require('chalk');
const glob = require("glob");
const fs = require("fs");

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
        }
        catch (error)
        {
            console.log(chalk.hex('#ff6426').bold(error));
            await this.fail();
        }
    }

    getTimestamp()
    {
        return new Promise((resolve, reject)=>{
            fs.readFile('config/papertrain/automation.tmp', (error, buffer)=>{
                if (error)
                {
                    reject(error);
                }

                const data = buffer.toString();

                if (!data.match('continue'))
                {
                    reject('Skipping module bundler due to previous failure, see error above');
                }

                const timestamp = data.match(/\d+/g)[0];
                resolve(timestamp);

            });
        });
    }

    fail()
    {
        return new Promise((resolve, reject)=>{
            fs.readFile('config/papertrain/automation.tmp', (error, buffer)=>{
                if (error)
                {
                    reject(error);
                }

                let data = buffer.toString();
                data = data.replace('continue', 'failed');

                fs.writeFile('config/papertrain/automation.tmp', data, (error)=>{
                    if (error)
                    {
                        reject(error);
                    }

                    resolve();
                });
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

                    let variableName = fileData.match(/(?<=class).*(?=\{)/)[0].trim();
                    let globalVariableName = this.generateCamelCase(variableName);

                    let newData = fileData;
                    newData += `\nvar ${ globalVariableName } = new ${ variableName }();\n`;

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

    generateCamelCase(name)
    {
        return name.replace(/(?:^\w|[A-Z]|\b\w)/g, (word, index)=>{
            return index == 0 ? word.toLowerCase() : word.toUpperCase();
        }).replace(/\s+/g, '');
    }
}

new WebModuleBundler();
