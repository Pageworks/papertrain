const chalk = require('chalk');
const ora = require('ora');
const clear = require('clear');
const fs = require('fs');
require('dotenv').config({path: `.env`});

const files = require('./lib/files');
const questions = require('./lib/questions');
const spinner = ora();

// =====================[ BEGIN CONFIG ]=====================

const HTMLFileType = 'twig';
const basePath = 'templates';


// ======================[ END CONFIG ]======================

let createdHTML = false;
let createdScss = false;
let createdScript = false;

clear();
console.log(chalk.cyan('Starting the generator'));
getUserInput();

/**
 * Questions to ask:
 * Name - Text input
 * Do you need custom SCSS? - Y/N
 * Do you need HTML?  - Y/N
 * Do you need a custom script? - [X] No, [] TypeScript, [] JavaScript
 *
 * If HTML + SCSS + SCRIPT: What are you creating? [] Template, [] Macro, [] Component
 * If HTML + SCSS: What are you creating? [] Template, [] Macro, [] Object
 *
 * Where should the files be generated? - Text input
 */

let name = null;
let className = null;
let kebabName = null;
let camelName = null;

let needsScss = false;
let needsHTML = false;
let needsScript = false;
let scriptType = null;

let generationType = null;

let fileLocation = null;

let hasScss = false;
let hasHTML = false;
let hasScript = false;

function getUserInput(){
    (async ()=>{
        const question1 = await questions.getName();
        name = question1.name.toLowerCase();
        kebabName = name.replace(/\s/g, '-');
        className = toPascalCase(name);
        camelName = camelize(name);

        const question2 = await questions.getDetails();
        needsScss = question2.needsScss;
        needsHTML = question2.needsHTML;
        needsScript = question2.needsScript;

        if(needsScript){
            const scriptQuestion = await questions.scriptType();
            scriptType = scriptQuestion.scriptType;
        }

        if(needsHTML && needsScss && needsScript){
            const question3 = await questions.getType1();
            generationType = question3.generationType;
        }
        else if(needsHTML && needsScss && !needsScript){
            const question3 = await questions.getType2();
            generationType = question3.generationType;
        }
        else if(!needsHTML && needsScss && !needsScript){
            generationType = 'Global';
        }
        else if(needsHTML && !needsScss){
            generationType = 'Template';
        }
        else{
            generationType = 'Unknown Type';
        }

        let defaultPath = null;

        switch(generationType){
            case 'Global':
                defaultPath = `${ basePath }/_lib/globals`
                break;
            case 'Object':
                defaultPath = `${ basePath }/_lib/objects`
                break;
            case 'Component':
                defaultPath = `${ basePath }/_lib/components`
                break;
            case 'Template':
                defaultPath = `${ basePath }/`
                break;
            case 'Macro':
                defaultPath = `${ basePath }/_macros`
                break;
            default:
                defaultPath = `${ basePath }/`
                break;
        }

        const question4 = await questions.getLocation(defaultPath);
        fileLocation = question4.fileLocation;
        fileLocation = fileLocation.replace(/^\//, '');
        fileLocation = fileLocation.replace(/\/$/, '');

        if(generationType === 'Unknown Type'){
            console.log('');
            console.log(chalk.hex('#f7e031').bold('Note: you\'re trying to generate an unknown type, please refer to the documentation to learn about valid types.'));
            console.log(chalk.hex('#2890ff').underline('https://github.com/Pageworks/papertrain#creating-elements'));
        }
        console.log('');
        console.log(chalk.white('Creating a'), chalk.hex('#8cf57b').bold(`${ generationType }`), chalk.white('named'), chalk.hex('#8cf57b').bold(`${ name }`), chalk.white('at'), chalk.hex('#f5f47b').bold(`${ fileLocation }`));
        console.log('');
        const question5 = await questions.confirmGeneration();
        if(question5.confirm){
            console.log('Generating files, please wait.');
            generate();
        }else{
            console.log(chalk.red('Generator canceled'));
            return;
        }
    })();
}

function generate(){
    spinner.start();
    spinner.text = 'Checking if the path is valid';

    if(files.directoryExists(fileLocation)){
        makeDirectory();
    }else{
        spinner.fail();
        console.log(chalk.red(`${ fileLocation } is an invalid path`));
    }
}

function makeDirectory(){
    spinner.text = 'Creating new directory';
    fs.mkdir(`${ fileLocation }/${ kebabName }`, (err)=>{
        if(err){
            spinner.fail();
            console.log(chalk.red(`Failed to make the directory at ${ fileLocation }/${ kebabName }`));
            return;
        }

        cloneFiles();
    });
}

function cloneFiles(){
    if(needsScss){
        makeStyleFile();
    }

    if(needsScript){
        makeScriptFile();
    }

    if(needsHTML){
        if(generationType === 'Template'){
            makeTemplate();
        }
        else{
            makeIncludable();
        }
    }
}

function makeIncludable(){
    const sassClassName = getClassName();
    fs.copyFile(`${ __dirname }/files/includable`, `${ fileLocation }/${ kebabName }/index.${ HTMLFileType }`, (err)=>{
        if(err){
            spinner.fail();
            console.log(chalk.red(`Failed to make the ${ generationType } file at ${ fileLocation }/${ kebabName }`));
            return;
        }

        fs.readFile(`${ fileLocation }/${ kebabName }/index.${ HTMLFileType }`, 'utf-8', (err, file)=>{
            if (err){
                spinner.fail();
                console.log(chalk.red(`Failed to make the ${ generationType } file at ${ fileLocation }/${ kebabName }`));
                return;
            }

            let modifiedFile = file;
            if(needsScript || needsScss){
                modifiedFile = modifiedFile.replace(/REPLACE_WITH_CLASS/g, className);
            }else{
                modifiedFile = modifiedFile.replace(`{% set REPLACE_WITH_CLASSAssets = craft.papertrain.getAssetPaths(['REPLACE_WITH_KEBAB']) %}`, '');
            }

            if(needsScss){
                modifiedFile = modifiedFile.replace(/REPLACE_WITH_KEBAB/g, kebabName);
                modifiedFile = modifiedFile.replace(/REPLACE_WITH_SCSS_CLASS/g, sassClassName);
            }else{
                modifiedFile = modifiedFile.replace(`{% do view.registerCssFile(REPLACE_WITH_CLASSAssets['REPLACE_WITH_KEBAB'].css) %}`, '');
                modifiedFile = modifiedFile.replace(`class="REPLACE_WITH_SCSS_CLASS"`, '');
            }

            if(needsScript){
                modifiedFile = modifiedFile.replace(/SCRIPT_PLACEHOLDER/g, `{% do view.registerJsFile(${ className }Assets['${ kebabName }'].module, { "defer":"defer" }) %}`);
                modifiedFile = modifiedFile.replace(/MODULE_PLACEHOLDER/g, `data-module="${ className }"`);
            }else{
                modifiedFile = modifiedFile.replace(/SCRIPT_PLACEHOLDER/g, '');
                modifiedFile = modifiedFile.replace(/MODULE_PLACEHOLDER/g, '');
            }

            fs.writeFile(`${ fileLocation }/${ kebabName }/index.${ HTMLFileType }`, modifiedFile, 'utf-8', (err)=>{
                if (err){
                    spinner.fail();
                    console.log(chalk.red(`Failed to make the ${ generationType } file at ${ fileLocation }/${ kebabName }`));
                    return;
                }

                hasHTML = true;
                checkForComplete();
            });
        });
    });
}

function makeTemplate(){
    const sassClassName = getClassName();
    fs.copyFile(`${ __dirname }/files/template`, `${ fileLocation }/${ kebabName }/index.${ HTMLFileType }`, (err)=>{
        if(err){
            spinner.fail();
            console.log(chalk.red(`Failed to make the template file at ${ fileLocation }/${ kebabName }`));
            return;
        }

        fs.readFile(`${ fileLocation }/${ kebabName }/index.${ HTMLFileType }`, 'utf-8', (err, file)=>{
            if (err){
                spinner.fail();
                console.log(chalk.red(`Failed to make the template file at ${ fileLocation }/${ kebabName }`));
                return;
            }

            let modifiedFile = file;

            if(needsScss){
                modifiedFile = modifiedFile.replace(/REPLACE_WITH_SCSS_CLASS/g, sassClassName);
            }else{
                modifiedFile = modifiedFile.replace(`{% do view.registerCssFile(REPLACE_WITH_CLASSAssets['REPLACE_WITH_KEBAB'].css) %}`, '');
                modifiedFile = modifiedFile.replace(`REPLACE_WITH_SCSS_CLASS`, '');
            }

            if(needsScript || needsScss){
                modifiedFile = modifiedFile.replace(/REPLACE_WITH_CLASS/g, className);
            }else{
                modifiedFile = modifiedFile.replace(`{% set REPLACE_WITH_CLASSAssets = craft.papertrain.getAssetPaths(['REPLACE_WITH_KEBAB']) %}`, '');
            }

            modifiedFile = modifiedFile.replace(/REPLACE_WITH_KEBAB/g, kebabName);

            if(needsScript){
                modifiedFile = modifiedFile.replace(/SCRIPT_PLACEHOLDER/g, `{% do view.registerJsFile(${ className }Assets['${ kebabName }'].module, { "defer":"defer" }) %}`);
                modifiedFile = modifiedFile.replace(/MODULE_PLACEHOLDER/g, `data-module="${ className }"`);
            }else{
                modifiedFile = modifiedFile.replace(/SCRIPT_PLACEHOLDER/g, '');
                modifiedFile = modifiedFile.replace(/MODULE_PLACEHOLDER/g, '');
            }

            fs.writeFile(`${ fileLocation }/${ kebabName }/index.${ HTMLFileType }`, modifiedFile, 'utf-8', (err)=>{
                if (err){
                    spinner.fail();
                    console.log(chalk.red(`Failed to make the template file at ${ fileLocation }/${ kebabName }`));
                    return;
                }

                hasHTML = true;
                checkForComplete();
            });
        });
    });
}

function makeScriptFile(){
    const fileType = (scriptType === 'TypeScript') ? 'ts' : 'js';
    fs.copyFile(`${ __dirname }/files/script.${ fileType }`, `${ fileLocation }/${ kebabName }/${ kebabName }.${ fileType }`, (err)=>{
        if(err){
            spinner.fail();
            console.log(chalk.red(`Failed to make the ${ scriptType } file at ${ fileLocation }/${ kebabName }`));
            return;
        }

        fs.readFile(`${ fileLocation }/${ kebabName }/${ kebabName }.${ fileType }`, 'utf-8', (err, file)=>{
            if (err){
                spinner.fail();
                console.log(chalk.red(`Failed to make the ${ scriptType } file at ${ fileLocation }/${ kebabName }`));
                return;
            }

            let modifiedFile = file.replace(/REPLACE_ME/g, className);
            modifiedFile = modifiedFile.replace(/AUTHOR_NAME/g, process.env.DEV_NAME);
            modifiedFile = modifiedFile.replace(/REPLACE_NAME/g, name);
            modifiedFile = modifiedFile.replace(/REPLACE_TYPE/g, generationType.toLowerCase());

            fs.writeFile(`${ fileLocation }/${ kebabName }/${ kebabName }.${ fileType }`, modifiedFile, 'utf-8', (err)=>{
                if (err){
                    spinner.fail();
                    console.log(chalk.red(`Failed to make the ${ scriptType } file at ${ fileLocation }/${ kebabName }`));
                    return;
                }

                hasScript = true;
                checkForComplete();
            });
        });
    });
}

function makeStyleFile(){
    const sassClassName = getClassName();
    fs.copyFile(`${ __dirname }/files/style`, `${ fileLocation }/${ kebabName }/${ kebabName }.scss`, (err)=>{
        if(err){
            spinner.fail();
            console.log(chalk.red(`Failed to make the SCSS file at ${ fileLocation }/${ kebabName }`));
            return;
        }

        fs.readFile(`${ fileLocation }/${ kebabName }/${ kebabName }.scss`, 'utf-8', (err, file)=>{
            if (err){
                spinner.fail();
                console.log(chalk.red(`Failed to open the SCSS file at ${ fileLocation }/${ kebabName }`));
                return;
            }

            const modifiedFile = file.replace(/REPLACE_ME/g, sassClassName);
            fs.writeFile(`${ fileLocation }/${ kebabName }/${ kebabName }.scss`, modifiedFile, 'utf-8', (err)=>{
                if (err){
                    spinner.fail();
                    console.log(chalk.red(`Failed to save the updated SCSS file at ${ fileLocation }/${ kebabName }`));
                    return;
                }

                hasScss = true;
                checkForComplete();
            });
        });
    });
}

function getClassName(){
    let className = kebabName;

    switch(generationType){
        case 'Global':
            className = `g-${ className }`;
            break;
        case 'Object':
            className = `o-${ className }`;
            break;
        case 'Component':
            className = `c-${ className }`;
            break;
        case 'Template':
            className = `t-${ className }`;
            break;
    }

    return className;
}

function checkForComplete(){
    let finished = true;

    if(needsHTML && !hasHTML){
        finished = false;
    }

    if(needsScript && !hasScript){
        finished = false;
    }

    if (needsScss && !hasScss){
        finished = false;
    }

    if(finished){
        spinner.text = 'Finished generating files';
        spinner.succeed();
        console.log(chalk.white('Successfully generated a new'), chalk.hex('#8cf57b').bold(`${ generationType }`), chalk.white('at'), chalk.hex('#f5f47b').bold(`${ fileLocation }/${ kebabName }`));
    }
}

function toPascalCase(string) {
    return `${string}`
        .replace(new RegExp(/[-_]+/, 'g'), ' ')
        .replace(new RegExp(/[^\w\s]/, 'g'), '')
        .replace(
        new RegExp(/\s+(.)(\w+)/, 'g'),
        ($1, $2, $3) => `${$2.toUpperCase() + $3.toLowerCase()}`
        )
        .replace(new RegExp(/\s/, 'g'), '')
        .replace(new RegExp(/\w/), s => s.toUpperCase());
}

function camelize(str) {
    return str.replace(/(?:^\w|[A-Z]|\b\w)/g, function(word, index) {
      return index == 0 ? word.toLowerCase() : word.toUpperCase();
    }).replace(/\s+/g, '');
  }
