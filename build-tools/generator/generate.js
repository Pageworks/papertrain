const chalk = require('chalk');
const ora = require('ora');
const clear = require('clear');
const fs = require('fs');

const files = require('./lib/files');
const questions = require('./lib/questions');
const spinner = ora();

let createdTwig = false;
let createdTs = false;
let createdScss = false;

let generationType = null

clear();
console.log(chalk.cyan('Starting the generator'));
startGenerator();

function startGenerator(){
    if(files.directoryExists(`templates/_lib/Components`) && files.directoryExists(`templates/_lib/Globals`) && files.directoryExists(`templates/_lib/Objects`) && files.directoryExists(`templates/_singles`)){
        console.log(chalk.gray('=========================================='));
        (async ()=>{
            const genType = await questions.askType();
            generationType = genType.type;
            switch(genType.type){
                case 'object':
                    generateObject(genType.handle);
                    break;
                case 'component':
                    generateComponent(genType.handle);
                    break;
                case 'global':
                    generateGlobal(genType.handle);
                    break;
                case 'single':
                    generateSingle(genType.handle);
                    break;
                default:
                    console.log(chalk.red('Something went wrong, sorry.'));
                    break;
            }
        })();
    }else{
        console.log(chalk.red('Missing required directories'));
    }
}


function generateObject(handle){
    console.log(chalk.gray('=========================================='));
    console.log(`Generating new object: `, chalk.cyan(handle));

    handle = handle.replace(' ', '-').toLowerCase();

    spinner.start();
    spinner.text = 'Checking if object already exists';
    if(files.directoryExists(`templates/_lib/object/${ handle }`)){
        spinner.text = `The object already exists`;
        spinner.fail();
    }else{
        spinner.text = 'No namespace conflicts found';
        spinner.succeed();

        spinner.start();
        spinner.text = 'Creating object';
        fs.mkdir(`templates/_lib/objects/${ handle }`, (err)=>{
            if(err){
                spinner.fail();
                spinner.text = 'Something went wrong';
                throw (err);
            }

            fs.copyFile(`${ __dirname }/base/object/object.twig`, `templates/_lib/objects/${ handle }/${ handle }.twig`, (err) => {
                if (err){
                    spinner.fail();
                    spinner.text = 'Failed to create the twig file';
                    throw err;
                }

                fs.readFile(`templates/_lib/objects/${ handle }/${ handle }.twig`, 'utf-8', (err, file)=>{
                    if (err){
                        spinner.fail();
                        spinner.text = 'Failed to create the twig file';
                        throw err;
                    }

                    const modifiedFile = file.replace(/REPLACE_ME/g, handle);
                    fs.writeFile(`templates/_lib/objects/${ handle }/${ handle }.twig`, modifiedFile, 'utf-8', (err)=>{
                        if (err){
                            spinner.fail();
                            spinner.text = 'Failed to create the twig file';
                            throw err;
                        }

                        createdTwig = true;
                        complete();
                    });
                });
            });

            fs.copyFile(`${ __dirname }/base/object/object.scss`, `templates/_lib/objects/${ handle }/${ handle }.scss`, (err) => {
                if (err){
                    spinner.fail();
                    spinner.text = 'Failed to create the scss file';
                    throw err;
                }

                fs.readFile(`templates/_lib/objects/${ handle }/${ handle }.scss`, 'utf-8', (err, file)=>{
                    if (err){
                        spinner.fail();
                        spinner.text = 'Failed to create the scss file';
                        throw err;
                    }

                    const modifiedFile = file.replace(/REPLACE_ME/g, handle);
                    fs.writeFile(`templates/_lib/objects/${ handle }/${ handle }.scss`, modifiedFile, 'utf-8', (err)=>{
                        if (err){
                            spinner.fail();
                            spinner.text = 'Failed to create the scss file';
                            throw err;
                        }

                        createdScss = true;
                        complete();
                    });
                });
            });
        });
    }
}

function generateComponent(handle){
    console.log(chalk.gray('=========================================='));
    console.log(`Generating new component: `, chalk.cyan(handle));

    handle = handle.replace(' ', '-').toLowerCase();

    const className = toPascalCase(handle);

    spinner.start();
    spinner.text = 'Checking if component already exists';
    if(files.directoryExists(`templates/_lib/components/${ handle }`)){
        spinner.text = `The component already exists`;
        spinner.fail();
    }else{
        spinner.text = 'No namespace conflicts found';
        spinner.succeed();

        spinner.start();
        spinner.text = 'Creating component';
        fs.mkdir(`templates/_lib/components/${ handle }`, (err)=>{
            if(err){
                spinner.fail();
                spinner.text = 'Something went wrong';
                throw (err);
            }

            fs.copyFile(`${ __dirname }/base/component/component.twig`, `templates/_lib/components/${ handle }/${ handle }.twig`, (err) => {
                if (err){
                    spinner.fail();
                    spinner.text = 'Failed to create the twig file';
                    throw err;
                }

                fs.readFile(`templates/_lib/components/${ handle }/${ handle }.twig`, 'utf-8', (err, file)=>{
                    if (err){
                        spinner.fail();
                        spinner.text = 'Failed to create the twig file';
                        throw err;
                    }

                    let modifiedFile = file.replace(/REPLACE_ME/g, handle);
                    modifiedFile = modifiedFile.replace(/CLASS_INDEX/g, className);
                    fs.writeFile(`templates/_lib/components/${ handle }/${ handle }.twig`, modifiedFile, 'utf-8', (err)=>{
                        if (err){
                            spinner.fail();
                            spinner.text = 'Failed to create the twig file';
                            throw err;
                        }

                        createdTwig = true;
                        complete();
                    });
                });
            });

            fs.copyFile(`${ __dirname }/base/component/component.ts`, `templates/_lib/components/${ handle }/${ handle }.ts`, (err) => {
                if (err){
                    spinner.fail();
                    spinner.text = 'Failed to create the TypeScript file';
                    throw err;
                }

                fs.readFile(`templates/_lib/components/${ handle }/${ handle }.ts`, 'utf-8', (err, file)=>{
                    if (err){
                        spinner.fail();
                        spinner.text = 'Failed to create the TypeScript file';
                        throw err;
                    }

                    const modifiedFile = file.replace(/REPLACE_ME/g, className);
                    fs.writeFile(`templates/_lib/components/${ handle }/${ handle }.ts`, modifiedFile, 'utf-8', (err)=>{
                        if (err){
                            spinner.fail();
                            spinner.text = 'Failed to create the TypeScirpt file';
                            throw err;
                        }

                        createdTs = true;
                        complete();
                    });
                });
            });

            fs.copyFile(`${ __dirname }/base/component/component.scss`, `templates/_lib/components/${ handle }/${ handle }.scss`, (err) => {
                if (err){
                    spinner.fail();
                    spinner.text = 'Failed to create the scss file';
                    throw err;
                }

                fs.readFile(`templates/_lib/components/${ handle }/${ handle }.scss`, 'utf-8', (err, file)=>{
                    if (err){
                        spinner.fail();
                        spinner.text = 'Failed to create the scss file';
                        throw err;
                    }

                    const modifiedFile = file.replace(/REPLACE_ME/g, handle);
                    fs.writeFile(`templates/_lib/components/${ handle }/${ handle }.scss`, modifiedFile, 'utf-8', (err)=>{
                        if (err){
                            spinner.fail();
                            spinner.text = 'Failed to create the scss file';
                            throw err;
                        }

                        createdScss = true;
                        complete();
                    });
                });
            });
        });
    }
}

function generateGlobal(handle){
    console.log(chalk.gray('=========================================='));
    console.log(`Generating new global object: `, chalk.cyan(handle));

    handle = handle.replace(' ', '-').toLowerCase();

    spinner.start();
    spinner.text = 'Checking if global object already exists';
    if(fs.existsSync(`templates/_lib/globals/${ handle }`)){
        spinner.text = `The global class already exists`;
        spinner.fail();
    }else{
        spinner.text = 'No namespace conflicts found';
        spinner.succeed();

        spinner.start();
        spinner.text = 'Creating object';
        fs.copyFile(`${ __dirname }/base/global/global.scss`, `templates/_lib/globals/${ handle }.scss`, (err) => {
            if (err){
                spinner.fail();
                spinner.text = 'Failed to create the global scss file';
                throw err;
            }

            fs.readFile(`templates/_lib/globals/${ handle }.scss`, 'utf-8', (err, file)=>{
                if (err){
                    spinner.fail();
                    spinner.text = 'Failed to create the scss file';
                    throw err;
                }

                const modifiedFile = file.replace(/REPLACE_ME/g, handle);
                fs.writeFile(`templates/_lib/globals/${ handle }.scss`, modifiedFile, 'utf-8', (err)=>{
                    if (err){
                        spinner.fail();
                        spinner.text = 'Failed to create the scss file';
                        throw err;
                    }

                    createdScss = true;
                    complete();
                });
            });
        });
    }
}

function generateSingle(handle){
    console.log(chalk.gray('=========================================='));
    console.log(`Generating new single: `, chalk.cyan(handle));

    handle = handle.replace(' ', '-').toLowerCase();

    spinner.start();
    spinner.text = 'Checking if object already exists';
    if(files.directoryExists(`templates/_singles/${ handle }`)){
        spinner.text = `The object already exists`;
        spinner.fail();
    }else{
        spinner.text = 'No namespace conflicts found';
        spinner.succeed();

        spinner.start();
        spinner.text = 'Creating object';
        fs.mkdir(`templates/_singles/${ handle }`, (err)=>{
            if(err){
                spinner.fail();
                spinner.text = 'Something went wrong';
                throw (err);
            }

            fs.copyFile(`${ __dirname }/base/single/single.twig`, `templates/_singles/${ handle }/${ handle }.twig`, (err) => {
                if (err){
                    spinner.fail();
                    spinner.text = 'Failed to create the twig file';
                    throw err;
                }

                fs.readFile(`templates/_singles/${ handle }/${ handle }.twig`, 'utf-8', (err, file)=>{
                    if (err){
                        spinner.fail();
                        spinner.text = 'Failed to create the twig file';
                        throw err;
                    }

                    const modifiedFile = file.replace(/REPLACE_ME/g, handle);
                    fs.writeFile(`templates/_singles/${ handle }/${ handle }.twig`, modifiedFile, 'utf-8', (err)=>{
                        if (err){
                            spinner.fail();
                            spinner.text = 'Failed to create the twig file';
                            throw err;
                        }

                        createdTwig = true;
                        complete();
                    });
                });
            });

            fs.copyFile(`${ __dirname }/base/single/single.scss`, `templates/_singles/${ handle }/${ handle }.scss`, (err) => {
                if (err){
                    spinner.fail();
                    spinner.text = 'Failed to create the scss file';
                    throw err;
                }

                fs.readFile(`templates/_singles/${ handle }/${ handle }.scss`, 'utf-8', (err, file)=>{
                    if (err){
                        spinner.fail();
                        spinner.text = 'Failed to create the scss file';
                        throw err;
                    }

                    const modifiedFile = file.replace(/REPLACE_ME/g, handle);
                    fs.writeFile(`templates/_singles/${ handle }/${ handle }.scss`, modifiedFile, 'utf-8', (err)=>{
                        if (err){
                            spinner.fail();
                            spinner.text = 'Failed to create the scss file';
                            throw err;
                        }

                        createdScss = true;
                        complete();
                    });
                });
            });
        });
    }
}

function complete(){
    switch(generationType){
        case 'object':
            if(createdScss && createdTwig){
                spinner.text = 'Object successfully created';
                spinner.succeed();
            }
            break;
        case 'component':
            if(createdScss && createdTwig && createdTs){
                spinner.text = 'Component successfully created';
                spinner.succeed();
            }
            break;
        case 'global':
            if(createdScss){
                spinner.text = 'Global successfully created';
                spinner.succeed();
            }
            break;
        case 'single':
            if(createdScss && createdTwig){
                spinner.text = 'Single successfully created';
                spinner.succeed();
            }
            break;
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
