const sass = require('node-sass');
const glob = require("glob");
const fs = require('fs');
const rimraf = require("rimraf");
const chalk = require('chalk');

class SassCompiler
{
    constructor()
    {
        console.log(chalk.white('Compiling SASS'));
        this.run();
    }

    async run()
    {
        try
        {
            const timestamp = await this.getTimestamp();
            const globalFiles = await this.getFiles('./sass/*.scss');
            const templateFiles = await this.getFiles('./templates/**/*.scss');
            const files = [...globalFiles, ...templateFiles];
            await this.makeDirectory(timestamp);
            await this.compile(files, timestamp);
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
                    reject('Skipping SASS compiler due to previous failure, see error above');
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

    getFiles(path)
    {
        return new Promise((resolve, reject)=>{
            glob(path, (error, files)=>{
                if (error)
                {
                    reject(error);
                }

                resolve(files);
            });
        });
    }

    makeDirectory(timestamp)
    {
        return new Promise((resolve, reject)=>{
            fs.mkdir(`./public/automation/styles-${ timestamp }`, (error)=>{
                if (error)
                {
                    reject(error);
                }

                resolve();
            });
        });
    }

    compile(files, timestamp)
    {
        return new Promise((resolve, reject)=>{
            let count = 0;

            for (let i = 0; i < files.length; i++)
            {
                const file = files[i];
                sass.render(
                    {
                        file: file,
                        outputStyle: 'compressed',
                        includePaths: ['sass/settings', 'sass/tools']
                    },
                    (error, result)=>{
                        if (error)
                        {
                            reject(`${ error.message } at line ${ error.line } ${ error.file }`);
                        }
                        else
                        {
                            const fileName = result.stats.entry.match(/[\w-]+?(?=\.)/gi)[0].toLowerCase();
                            if (fileName)
                            {
                                const newFile = `./public/automation/styles-${ timestamp }/${ fileName }.css`;
                                fs.writeFile(newFile, result.css.toString(), (error)=>{
                                    if (error)
                                    {
                                        reject('Something went wrong saving the file' + error);
                                    }

                                    console.log(chalk.hex('#ffffff').bold(file), chalk.hex('#8cf57b').bold(' [compiled]'));
                                    count++;

                                    if (count === files.length)
                                    {
                                        resolve();
                                    }
                                });
                            }
                            else
                            {
                                reject('Something went wrong with the file name of ' + result.stats.entry);
                            }
                        }
                    }
                );
            }
        });
    }
}

new SassCompiler();
