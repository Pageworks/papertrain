const chalk = require('chalk');
const glob = require("glob");
const fs = require("fs");

class LegacyBundler
{
    constructor()
    {
        console.log(chalk.white('Bundling for legacy browsers'));
        this.run();
    }

    async run()
    {
        try
        {
            const files = await this.getFiles();
            await this.createBloatedBundle(files);
        }
        catch (error)
        {
            console.log(chalk.hex('#ff6426').bold(error));
        }
    }

    getFiles()
    {
        return new Promise((resolve, reject)=>{
            glob('_compiled/es5/**/*.js', (error, files)=>{
                if (error)
                {
                    reject(error);
                }

                resolve(files);
            });
        });
    }

    createBloatedBundle(files)
    {
        return new Promise((resolve, reject)=>{
            let data = '';
            let count = 0;

            for (let i = 0; i < files.length; i++)
            {
                fs.readFile(files[i], (error, buffer)=>{
                    if (error)
                    {
                        reject(error);
                    }

                    const globalName = buffer.toString().match(/(?<=var).*(?=\=.*\*)/)[0].trim();
                    data += `// Source: ${ files[i] }\n`;
                    data += buffer;
                    data += `var ${ globalName.toLowerCase() } = new ${ globalName }();\n`;
                    count++;

                    if (count === files.length)
                    {
                        fs.readFile('_compiled/legacy/main.js', (error, buffer)=>{
                            if (error)
                            {
                                reject(error);
                            }

                            data += buffer;
            
                            fs.writeFile('public/assets/main.js', data, (error)=>{
                                if (error)
                                {
                                    reject(error);
                                }
                
                                resolve();
                            });
                        });
                    }
                });
            }
        });
    }
}

new LegacyBundler();
