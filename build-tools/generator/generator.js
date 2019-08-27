const chalk = require('chalk');
const ora = require('ora');
const clear = require('clear');
const fs = require('fs');
require('dotenv').config({path: `.env`});

const questions = require('./questions');
const spinner = ora();

// =====================[ BEGIN CONFIG ]=====================

const HTMLFileType = 'twig';
const StylesheetFileType = 'scss';
const basePath = 'templates';

// ======================[ END CONFIG ]======================

class PapertrainGenerator
{
    constructor()
    {
        clear();
        console.log('');
        console.log(chalk.cyan('Papertrain CLI generator'));

        this.cssName;
        this.kebabName;
        this.camelName;
        this.pascalName;
        this.scriptFileType = null;

        this.run();
    }

    async run()
    {
        try
        {
            let baseName = await questions.getName();
            let type = await questions.getType();
            type = type.type;
            baseName = await this.sanitizeName(baseName.name, type);

            this.cssName = await this.generateCssName(baseName, type);
            this.kebabName = this.generateKebabCase(baseName, type);
            this.camelName = this.generateCamelCase(baseName);
            this.pascalName = this.generatePascalCase(baseName);

            if (type === 'Web Component')
            {
                const scriptFileType = await questions.scriptType();

                switch(scriptFileType.type)
                {
                    case 'TypeScript':
                        this.scriptFileType = 'ts';
                        break;
                    case 'JavaScript':
                        this.scriptFileType = 'js';
                        break;
                    default:
                        this.scriptFileType = 'ts';
                        break;
                }
            }

            let path = null;

            if (type !== 'Global Stylesheet')
            {
                while (path === null)
                {
                    let newPath = await questions.getPath(type, basePath);
                    newPath = newPath.path.trim().replace(/[\/]$/, '');

                    await fs.promises.access(`${ basePath }/${ newPath }`)
                    .then(()=>{
                        path = `${ basePath }/${ newPath }`;
                    })
                    .catch(()=>{
                        console.log(chalk.hex('#f5f47b').bold(`${ basePath }/${ newPath }`), chalk.white('is not a valid path'));
                    });
                }

                console.log('');
                console.log(chalk.white('Creating a'), chalk.hex('#8cf57b').bold(`${ type }`), chalk.white('named'), chalk.hex('#8cf57b').bold(`${ this.kebabName }`), chalk.white('at'), chalk.hex('#f5f47b').bold(`${ path }`));
                console.log('');
                const confirmed = await questions.confirmGeneration();
                await new Promise((resolve, reject) => {
                    if (!confirmed.confirm)
                    {
                        reject('Generator canceled by the user');
                    }

                    resolve();
                });

                spinner.start();
                spinner.text = 'Creating directory';
                await this.generateDirectory(path, type);
            }
            else
            {
                path = `${ basePath }/_global-stylesheets`;
                spinner.start();
            }

            spinner.text = 'Creating files';
            await this.generateFiles(path, type);
            spinner.succeed();
            console.log(chalk.hex('#8cf57b').bold('Success!'));
        }
        catch (error)
        {
            console.log(chalk.hex('#ff6426').bold(error));
        }
    }

    sanitizeName(name, type)
    {
        let newName = name.trim().replace(/[\s\-\_]/g, ' ').trim();

        if (type === 'Web Component')
        {
            if (!newName.match(/(component)$/))
            {
                newName += ' component';
            }
        }

        return newName;
    }

    generateCssName(name, type)
    {
        return new Promise((resolve, reject)=>{
            let newName = name.replace(/[\s]/g, '-');
            switch(type)
            {
                case 'Web Component':
                    resolve(newName);
                case 'Template':
                    resolve(`.t-${ newName }`);
                case 'Global Stylesheet':
                    resolve(`.g-${ newName }`);
                default:
                    reject(`${ type } does not exist within the generate CSS name switch statement`);
            }
        });
    }

    generateKebabCase(name)
    {
        return name.trim().replace(/\s/g, '-').toLowerCase();
    }

    generateCamelCase(name)
    {
        return name.replace(/(?:^\w|[A-Z]|\b\w)/g, (word, index)=>{
            return index == 0 ? word.toLowerCase() : word.toUpperCase();
        }).replace(/\s+/g, '');
    }

    generatePascalCase(name)
    {
        return `${ name }`
            .replace(new RegExp(/[-_]+/, 'g'), ' ')
            .replace(new RegExp(/[^\w\s]/, 'g'), '')
            .replace(
                new RegExp(/\s+(.)(\w+)/, 'g'),
                ($1, $2, $3) => `${$2.toUpperCase() + $3.toLowerCase()}`
            )
            .replace(new RegExp(/\s/, 'g'), '')
            .replace(new RegExp(/\w/), s => s.toUpperCase());
    }

    generateDirectory(path, type)
    {
        return new Promise((resolve, reject)=>{
            fs.mkdir(`${ path }/${ (type === 'Web Component') ? '_' : '' }${ this.kebabName }`, (err)=>{
                if (err)
                {
                    spinner.fail();
                    reject(`Failed to make the directory at ${ path }`);
                }

                resolve();
            });
        });
    }

    generateFiles(path, type)
    {
        return new Promise((resolve, reject)=>{
            (async ()=>{
                if (type === 'Template')
                {
                    try
                    {
                        await this.generateTemplate(path);
                        await this.generateStylesheet(path);
                        resolve();
                    }
                    catch (error)
                    {
                        spinner.fail();
                        reject(error);
                    }
                }
                else if (type === 'Web Component')
                {
                    try
                    {
                        await this.generateComponent(path, type);
                        await this.generateStylesheet(path, type);
                        await this.generateScript(path, type);
                        resolve();
                    }
                    catch (error)
                    {
                        spinner.fail();
                        reject(error);
                    }
                }
                else if (type === 'Global Stylesheet')
                {
                    try
                    {
                        await this.generateGlobalStylesheet(path);
                        resolve();
                    }
                    catch (error)
                    {
                        spinner.fail();
                        reject(error);
                    }
                }
                else
                {
                    spinner.fail();
                    reject(`Attempted to generate undefined type ${ type }`);
                }
            })();
        });
    }

    generateTemplate(path)
    {
        return new Promise((resolve, reject)=>{
            fs.copyFile(`${ __dirname }/files/template`, `${ path }/${ this.kebabName }/index.${ HTMLFileType }`, (error)=>{
                if (error)
                {
                    reject(error);
                }

                fs.readFile(`${ path }/${ this.kebabName }/index.${ HTMLFileType }`, 'utf-8', (error, data)=>{
                    if (error)
                    {
                        reject(error);
                    }

                    let modifiedFile = data;
                    modifiedFile = modifiedFile.replace(/REPLACE_WITH_KEBAB/g, this.kebabName);

                    let fixedCssName = this.cssName.replace(/[\.]/g, '');

                    modifiedFile = modifiedFile.replace(/REPLACE_WITH_CSS/g, fixedCssName);

                    fs.writeFile(`${ path }/${ this.kebabName }/index.${ HTMLFileType }`, modifiedFile, 'utf-8', (err)=>{
                        if (err)
                        {
                            spinner.fail();
                            reject(`Failed to make the template file at ${ path }/${ this.kebabName }/`);
                        }

                        resolve();
                    });
                });
            });
        });
    }

    generateStylesheet(path, type)
    {
        return new Promise((resolve, reject)=>{
            fs.copyFile(`${ __dirname }/files/stylesheet`, `${ path }/${ (type === 'Web Component') ? '_' : '' }${ this.kebabName }/${ this.kebabName }.${ StylesheetFileType }`, (error)=>{
                if (error)
                {
                    reject(error);
                }

                fs.readFile(`${ path }/${ (type === 'Web Component') ? '_' : '' }${ this.kebabName }/${ this.kebabName }.${ StylesheetFileType }`, 'utf-8', (error, data)=>{
                    if (error)
                    {
                        reject(error);
                    }

                    let modifiedFile = data;
                    modifiedFile = modifiedFile.replace(/REPLACE_WITH_CSS/g, this.cssName);

                    fs.writeFile(`${ path }/${ (type === 'Web Component') ? '_' : '' }${ this.kebabName }/${ this.kebabName }.${ StylesheetFileType }`, modifiedFile, 'utf-8', (err)=>{
                        if (err)
                        {
                            spinner.fail();
                            reject(`Failed to make the stylesheet file at ${ path }/${ this.kebabName }/${ this.kebabName }.${ StylesheetFileType }`);
                        }

                        resolve();
                    });
                });
            });
        });
    }

    generateComponent(path)
    {
        return new Promise((resolve, reject)=>{
            fs.copyFile(`${ __dirname }/files/component`, `${ path }/_${ this.kebabName }/index.${ HTMLFileType }`, (error)=>{
                if (error)
                {
                    reject(error);
                }

                fs.readFile(`${ path }/_${ this.kebabName }/index.${ HTMLFileType }`, 'utf-8', (error, data)=>{
                    if (error)
                    {
                        reject(error);
                    }

                    let modifiedFile = data;
                    modifiedFile = modifiedFile.replace(/REPLACE_WITH_KEBAB/g, this.kebabName);

                    fs.writeFile(`${ path }/_${ this.kebabName }/index.${ HTMLFileType }`, modifiedFile, 'utf-8', (err)=>{
                        if (err)
                        {
                            spinner.fail();
                            reject(`Failed to make the component ${ HTMLFileType } file at ${ path }/${ this.kebabName }/index.${ HTMLFileType }`);
                        }

                        resolve();
                    });
                });
            });
        });
    }

    generateScript(path)
    {
        return new Promise((resolve, reject)=>{
            fs.copyFile(`${ __dirname }/files/script`, `${ path }/_${ this.kebabName }/${ this.kebabName }.${ this.scriptFileType }`, (error)=>{
                if (error)
                {
                    reject(error);
                }

                fs.readFile(`${ path }/_${ this.kebabName }/${ this.kebabName }.${ this.scriptFileType }`, 'utf-8', (error, data)=>{
                    if (error)
                    {
                        reject(error);
                    }

                    let modifiedFile = data;
                    modifiedFile = modifiedFile.replace(/REPLACE_WITH_KEBAB/g, this.kebabName);
                    modifiedFile = modifiedFile.replace(/REPLACE_WITH_PASCAL/g, this.pascalName);
                    const devName = (process.env.DEV_NAME) ? process.env.DEV_NAME : 'Anonymous';
                    modifiedFile = modifiedFile.replace(/AUTHOR_NAME/g, devName);

                    fs.writeFile(`${ path }/_${ this.kebabName }/${ this.kebabName }.${ this.scriptFileType }`, modifiedFile, 'utf-8', (err)=>{
                        if (err)
                        {
                            spinner.fail();
                            reject(`Failed to make the component script file at ${ path }/${ this.kebabName }/${ this.kebabName }.${ this.scriptFileType }`);
                        }

                        resolve();
                    });
                });
            });
        });
    }

    generateGlobalStylesheet(path)
    {
        return new Promise((resolve, reject)=>{
            fs.copyFile(`${ __dirname }/files/stylesheet`, `${ path }/${ this.kebabName }.${ StylesheetFileType }`, (error)=>{
                if (error)
                {
                    reject(error);
                }

                fs.readFile(`${ path }/${ this.kebabName }.${ StylesheetFileType }`, 'utf-8', (error, data)=>{
                    if (error)
                    {
                        reject(error);
                    }

                    let modifiedFile = data;
                    modifiedFile = modifiedFile.replace(/REPLACE_WITH_CSS/g, this.cssName);

                    fs.writeFile(`${ path }/${ this.kebabName }.${ StylesheetFileType }`, modifiedFile, 'utf-8', (err)=>{
                        if (err)
                        {
                            spinner.fail();
                            reject(`Failed to make the stylesheet file at ${ path }/${ this.kebabName }.${ StylesheetFileType }`);
                        }

                        resolve();
                    });
                });
            });
        });
    }
}

new PapertrainGenerator();
