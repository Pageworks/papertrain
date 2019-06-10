const chalk = require('chalk');
const ora = require('ora');
const clear = require('clear');
const fs = require('fs');

const files = require('./lib/files');
const questions = require('./lib/questions');
const spinner = ora();

// =====================[ BEGIN CONFIG ]=====================

const HTMLFileType = 'twig';

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
                defaultPath = 'templates/_lib/globals'
                break;
            case 'Object':
                defaultPath = 'templates/_lib/objects'
                break;
            case 'Component':
                defaultPath = 'templates/_lib/components'
                break;
            case 'Template':
                defaultPath = 'templates/'
                break;
            case 'Macro':
                defaultPath = 'templates/_macros'
                break;
            default:
                defaultPath = 'templates/'
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
        console.log(chalk.white('Creating a'), chalk.hex('#8cf57b').bold(`${ generationType }`), chalk.white('named'), chalk.hex('#8cf57b').bold(`${ name }`), chalk.white('at'), chalk.hex('#8cf57b').bold(`${ fileLocation }`));
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
        else if(generationType === 'Macro'){
            makeMarco();
        }
        else{
            makeIncludable();
        }
    }
}

function makeIncludable(){

}

function makeMacro(){

}

function makeTemplate(){
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

            let modifiedFile = file.replace(/REPLACE_WITH_CLASS/g, className);
            modifiedFile = modifiedFile.replace(/REPLACE_WITH_KEBAB/g, kebabName);

            if(needsScript){
                modifiedFile = modifiedFile.replace(/SCRIPT_PLACEHOLDER/g, `{% do view.registerJsFile(${ className }Assets['${ kebabName }'].js) %}`);
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

                hasScript = true;
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

            const modifiedFile = file.replace(/REPLACE_ME/g, className);
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
        case 'Macro':
            className = `m-${ className }`;
            break;
    }

    return className;
}

function checkForComplete(){
    if(needsHTML && !hasHTML || needsScript && !hasScript || needsScss && !hasScss){
        return;
    }

    console.log('Finished');
}

// function generateObject(handle){
//     console.log(chalk.gray('=========================================='));
//     console.log(`Generating new object: `, chalk.cyan(handle));

//     handle = handle.replace(/\s/g, '-').toLowerCase();

//     spinner.start();
//     spinner.text = 'Checking if object already exists';
//     if(files.directoryExists(`templates/_lib/object/${ handle }`)){
//         spinner.text = `The object already exists`;
//         spinner.fail();
//     }else{
//         spinner.text = 'No namespace conflicts found';
//         spinner.succeed();

//         spinner.start();
//         spinner.text = 'Creating object';
//         fs.mkdir(`templates/_lib/objects/${ handle }`, (err)=>{
//             if(err){
//                 spinner.fail();
//                 spinner.text = 'Something went wrong';
//                 throw (err);
//             }

//             fs.copyFile(`${ __dirname }/base/object/object.twig`, `templates/_lib/objects/${ handle }/${ handle }.twig`, (err) => {
//                 if (err){
//                     spinner.fail();
//                     spinner.text = 'Failed to create the twig file';
//                     throw err;
//                 }

//                 fs.readFile(`templates/_lib/objects/${ handle }/${ handle }.twig`, 'utf-8', (err, file)=>{
//                     if (err){
//                         spinner.fail();
//                         spinner.text = 'Failed to create the twig file';
//                         throw err;
//                     }

//                     const modifiedFile = file.replace(/REPLACE_ME/g, handle);
//                     fs.writeFile(`templates/_lib/objects/${ handle }/${ handle }.twig`, modifiedFile, 'utf-8', (err)=>{
//                         if (err){
//                             spinner.fail();
//                             spinner.text = 'Failed to create the twig file';
//                             throw err;
//                         }

//                         createdTwig = true;
//                         complete();
//                     });
//                 });
//             });

//             fs.copyFile(`${ __dirname }/base/object/object.scss`, `templates/_lib/objects/${ handle }/${ handle }.scss`, (err) => {
//                 if (err){
//                     spinner.fail();
//                     spinner.text = 'Failed to create the scss file';
//                     throw err;
//                 }

//                 fs.readFile(`templates/_lib/objects/${ handle }/${ handle }.scss`, 'utf-8', (err, file)=>{
//                     if (err){
//                         spinner.fail();
//                         spinner.text = 'Failed to create the scss file';
//                         throw err;
//                     }

//                     const modifiedFile = file.replace(/REPLACE_ME/g, handle);
//                     fs.writeFile(`templates/_lib/objects/${ handle }/${ handle }.scss`, modifiedFile, 'utf-8', (err)=>{
//                         if (err){
//                             spinner.fail();
//                             spinner.text = 'Failed to create the scss file';
//                             throw err;
//                         }

//                         createdScss = true;
//                         complete();
//                     });
//                 });
//             });
//         });
//     }
// }

// function generateComponent(handle){
//     console.log(chalk.gray('=========================================='));
//     console.log(`Generating new component: `, chalk.cyan(handle));

//     handle = handle.replace(/\s/g, '-').toLowerCase();

//     const className = toPascalCase(handle);

//     spinner.start();
//     spinner.text = 'Checking if component already exists';
//     if(files.directoryExists(`templates/_lib/components/${ handle }`)){
//         spinner.text = `The component already exists`;
//         spinner.fail();
//     }else{
//         spinner.text = 'No namespace conflicts found';
//         spinner.succeed();

//         spinner.start();
//         spinner.text = 'Creating component';
//         fs.mkdir(`templates/_lib/components/${ handle }`, (err)=>{
//             if(err){
//                 spinner.fail();
//                 spinner.text = 'Something went wrong';
//                 throw (err);
//             }

//             fs.copyFile(`${ __dirname }/base/component/component.twig`, `templates/_lib/components/${ handle }/${ handle }.twig`, (err) => {
//                 if (err){
//                     spinner.fail();
//                     spinner.text = 'Failed to create the twig file';
//                     throw err;
//                 }

//                 fs.readFile(`templates/_lib/components/${ handle }/${ handle }.twig`, 'utf-8', (err, file)=>{
//                     if (err){
//                         spinner.fail();
//                         spinner.text = 'Failed to create the twig file';
//                         throw err;
//                     }

//                     let modifiedFile = file.replace(/REPLACE_ME/g, handle);
//                     modifiedFile = modifiedFile.replace(/CLASS_INDEX/g, className);
//                     fs.writeFile(`templates/_lib/components/${ handle }/${ handle }.twig`, modifiedFile, 'utf-8', (err)=>{
//                         if (err){
//                             spinner.fail();
//                             spinner.text = 'Failed to create the twig file';
//                             throw err;
//                         }

//                         createdTwig = true;
//                         complete();
//                     });
//                 });
//             });

//             fs.copyFile(`${ __dirname }/base/component/component.ts`, `templates/_lib/components/${ handle }/${ handle }.ts`, (err) => {
//                 if (err){
//                     spinner.fail();
//                     spinner.text = 'Failed to create the TypeScript file';
//                     throw err;
//                 }

//                 fs.readFile(`templates/_lib/components/${ handle }/${ handle }.ts`, 'utf-8', (err, file)=>{
//                     if (err){
//                         spinner.fail();
//                         spinner.text = 'Failed to create the TypeScript file';
//                         throw err;
//                     }

//                     const modifiedFile = file.replace(/REPLACE_ME/g, className);
//                     fs.writeFile(`templates/_lib/components/${ handle }/${ handle }.ts`, modifiedFile, 'utf-8', (err)=>{
//                         if (err){
//                             spinner.fail();
//                             spinner.text = 'Failed to create the TypeScirpt file';
//                             throw err;
//                         }

//                         createdTs = true;
//                         complete();
//                     });
//                 });
//             });

//             fs.copyFile(`${ __dirname }/base/component/component.scss`, `templates/_lib/components/${ handle }/${ handle }.scss`, (err) => {
//                 if (err){
//                     spinner.fail();
//                     spinner.text = 'Failed to create the scss file';
//                     throw err;
//                 }

//                 fs.readFile(`templates/_lib/components/${ handle }/${ handle }.scss`, 'utf-8', (err, file)=>{
//                     if (err){
//                         spinner.fail();
//                         spinner.text = 'Failed to create the scss file';
//                         throw err;
//                     }

//                     const modifiedFile = file.replace(/REPLACE_ME/g, handle);
//                     fs.writeFile(`templates/_lib/components/${ handle }/${ handle }.scss`, modifiedFile, 'utf-8', (err)=>{
//                         if (err){
//                             spinner.fail();
//                             spinner.text = 'Failed to create the scss file';
//                             throw err;
//                         }

//                         createdScss = true;
//                         complete();
//                     });
//                 });
//             });
//         });
//     }
// }

// function generateGlobal(handle){
//     console.log(chalk.gray('=========================================='));
//     console.log(`Generating new global object: `, chalk.cyan(handle));

//     handle = handle.replace(/\s/g, '-').toLowerCase();

//     spinner.start();
//     spinner.text = 'Checking if global object already exists';
//     if(fs.existsSync(`templates/_lib/globals/${ handle }`)){
//         spinner.text = `The global class already exists`;
//         spinner.fail();
//     }else{
//         spinner.text = 'No namespace conflicts found';
//         spinner.succeed();

//         spinner.start();
//         spinner.text = 'Creating object';
//         fs.copyFile(`${ __dirname }/base/global/global.scss`, `templates/_lib/globals/${ handle }.scss`, (err) => {
//             if (err){
//                 spinner.fail();
//                 spinner.text = 'Failed to create the global scss file';
//                 throw err;
//             }

//             fs.readFile(`templates/_lib/globals/${ handle }.scss`, 'utf-8', (err, file)=>{
//                 if (err){
//                     spinner.fail();
//                     spinner.text = 'Failed to create the scss file';
//                     throw err;
//                 }

//                 const modifiedFile = file.replace(/REPLACE_ME/g, handle);
//                 fs.writeFile(`templates/_lib/globals/${ handle }.scss`, modifiedFile, 'utf-8', (err)=>{
//                     if (err){
//                         spinner.fail();
//                         spinner.text = 'Failed to create the scss file';
//                         throw err;
//                     }

//                     createdScss = true;
//                     complete();
//                 });
//             });
//         });
//     }
// }

// function generateSingle(handle, generateScript){
//     console.log(chalk.gray('=========================================='));
//     console.log(`Generating new template: `, chalk.cyan(handle));

//     handle = handle.replace(/\s/g, '-').toLowerCase();

//     const className = toPascalCase(handle);

//     spinner.start();
//     spinner.text = 'Checking if object already exists';
//     if(files.directoryExists(`templates/${ handle }`)){
//         spinner.text = `The object already exists`;
//         spinner.fail();
//     }else{
//         spinner.text = 'No namespace conflicts found';
//         spinner.succeed();

//         spinner.start();
//         spinner.text = 'Creating template';
//         fs.mkdir(`templates/${ handle }`, (err)=>{
//             if(err){
//                 spinner.fail();
//                 spinner.text = 'Something went wrong';
//                 throw (err);
//             }

//             fs.copyFile(`${ __dirname }/base/single/single.twig`, `templates/${ handle }/index.twig`, (err) => {
//                 if (err){
//                     spinner.fail();
//                     spinner.text = 'Failed to create the twig file';
//                     throw err;
//                 }

//                 fs.readFile(`templates/${ handle }/index.twig`, 'utf-8', (err, file)=>{
//                     if (err){
//                         spinner.fail();
//                         spinner.text = 'Failed to create the twig file';
//                         throw err;
//                     }

//                     let modifiedFile = file.replace(/REPLACE_ME/g, handle);

//                     if(generateScript){
//                         let scriptInclude = `{% do view.registerJsFile(siteUrl|trim('/') ~ '/assets/scripts/${ handle }.' ~ craft.app.config.general.jsCacheBustTimestamp ~ '.js', { "async":"async" }) %}`;
//                         modifiedFile = modifiedFile.replace(/SCRIPT_PLACEHOLDER/g, scriptInclude);
//                         modifiedFile = modifiedFile.replace(/MODULE_PLACEHOLDER/g, `data-module="${ className }"`);
//                     }else{
//                         modifiedFile = modifiedFile.replace(/SCRIPT_PLACEHOLDER/g, '');
//                         modifiedFile = modifiedFile.replace(/MODULE_PLACEHOLDER/g, '');
//                     }

//                     fs.writeFile(`templates/${ handle }/index.twig`, modifiedFile, 'utf-8', (err)=>{
//                         if (err){
//                             spinner.fail();
//                             spinner.text = 'Failed to create the twig file';
//                             throw err;
//                         }

//                         createdTwig = true;
//                         complete();
//                     });
//                 });
//             });

//             fs.copyFile(`${ __dirname }/base/single/single.scss`, `templates/${ handle }/${ handle }.scss`, (err) => {
//                 if (err){
//                     spinner.fail();
//                     spinner.text = 'Failed to create the scss file';
//                     throw err;
//                 }

//                 fs.readFile(`templates/${ handle }/${ handle }.scss`, 'utf-8', (err, file)=>{
//                     if (err){
//                         spinner.fail();
//                         spinner.text = 'Failed to create the scss file';
//                         throw err;
//                     }

//                     let modifiedFile = file.replace(/REPLACE_ME/g, handle);

//                     fs.writeFile(`templates/${ handle }/${ handle }.scss`, modifiedFile, 'utf-8', (err)=>{
//                         if (err){
//                             spinner.fail();
//                             spinner.text = 'Failed to create the scss file';
//                             throw err;
//                         }

//                         createdScss = true;
//                         complete();
//                     });
//                 });
//             });

//             if(generateScript){
//                 fs.copyFile(`${ __dirname }/base/single/single.ts`, `templates/${ handle }/${ handle }.ts`, (err) => {
//                     if (err){
//                         spinner.fail();
//                         spinner.text = 'Failed to create the typescript file';
//                         throw err;
//                     }

//                     fs.readFile(`templates/${ handle }/${ handle }.ts`, 'utf-8', (err, file)=>{
//                         if (err){
//                             spinner.fail();
//                             spinner.text = 'Failed to create the typescript file';
//                             throw err;
//                         }

//                         const modifiedFile = file.replace(/REPLACE_ME/g, className);
//                         fs.writeFile(`templates/${ handle }/${ handle }.ts`, modifiedFile, 'utf-8', (err)=>{
//                             if (err){
//                                 spinner.fail();
//                                 spinner.text = 'Failed to create the typescript file';
//                                 throw err;
//                             }

//                             createdTs = true;
//                         });
//                     });
//                 });
//             }
//         });
//     }
// }

// function complete(){
//     switch(generationType){
//         case 'object':
//             if(createdScss && createdTwig){
//                 spinner.text = 'Object successfully created';
//                 spinner.succeed();
//             }
//             break;
//         case 'component':
//             if(createdScss && createdTwig && createdTs){
//                 spinner.text = 'Component successfully created';
//                 spinner.succeed();
//             }
//             break;
//         case 'global':
//             if(createdScss){
//                 spinner.text = 'Global successfully created';
//                 spinner.succeed();
//             }
//             break;
//         case 'template':
//             if(createdScss && createdTwig){
//                 spinner.text = 'New template successfully created';
//                 spinner.succeed();
//             }
//             break;
//     }
// }

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
