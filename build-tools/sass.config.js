const sass = require('node-sass');
const glob = require("glob");
const fs = require('fs');
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
            const globalFiles = await this.getFiles('./sass/*.scss');
            const templateFiles = await this.getFiles('./templates/**/*.scss');
            const files = [...globalFiles, ...templateFiles];
            await this.compile(files);
        }
        catch (error)
        {
            console.log(error);
        }
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

    compile(files)
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
                            let fileName = result.stats.entry.replace(/.*\//g, '').toLowerCase();
                            fileName = fileName.replace(/(.scss)|(.sass)/g, '').trim();
                            if (fileName)
                            {
                                const newFile = `public/automation_INCOMING/${ fileName }.css`;
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
