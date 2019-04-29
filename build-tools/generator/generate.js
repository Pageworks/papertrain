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
    if(files.directoryExists(`templates/lib/Components`) && files.directoryExists(`templates/lib/Globals`) && files.directoryExists(`templates/lib/Objects`) && files.directoryExists(`templates/_singles`)){
        console.log(chalk.gray('=========================================='));
        (async ()=>{
            const genType = await questions.askType();
            generationType = genType.handle;
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
    if(files.directoryExists(`templates/lib/object/${ handle }`)){
        spinner.text = `The object already exists`;
        spinner.fail();
    }else{
        spinner.text = 'No namespace conflicts found';
        spinner.succeed();

        spinner.start();
        spinner.text = 'Creating object';
        fs.mkdir(`templates/lib/objects/${ handle }`, (err)=>{
            if(err){
                spinner.fail();
                spinner.text = 'Something went wrong';
                throw (err);
            }

            fs.copyFile(`./base/object/object.twig`, `templates/lib/objects/${ handle }/${ handle }.twig`, (err) => {
                if (err){
                    spinner.fail();
                    spinner.text = 'Failed to create the twig file';
                    throw err;
                }

                fs.readFile(`templates/lib/objects/${ handle }/${ handle }.twig`, 'utf-8', (err, file)=>{
                    if (err){
                        spinner.fail();
                        spinner.text = 'Failed to create the twig file';
                        throw err;
                    }

                    const modifiedFile = file.replace(/REPLACE_ME/g, handle);
                    fs.writeFile(`templates/lib/objects/${ handle }/${ handle }.twig`, modifiedFile, 'utf-8', (err)=>{
                        if (err){
                            spinner.fail();
                            spinner.text = 'Failed to create the twig file';
                            throw err;
                        }

                        createdTwig = true;
                        completeObject();
                    });
                });
            });

            fs.copyFile(`./base/object/object.scss`, `templates/lib/objects/${ handle }/${ handle }.scss`, (err) => {
                if (err){
                    spinner.fail();
                    spinner.text = 'Failed to create the scss file';
                    throw err;
                }

                fs.readFile(`templates/lib/objects/${ handle }/${ handle }.scss`, 'utf-8', (err, file)=>{
                    if (err){
                        spinner.fail();
                        spinner.text = 'Failed to create the scss file';
                        throw err;
                    }

                    const modifiedFile = file.replace(/REPLACE_ME/g, handle);
                    fs.writeFile(`templates/lib/objects/${ handle }/${ handle }.scss`, modifiedFile, 'utf-8', (err)=>{
                        if (err){
                            spinner.fail();
                            spinner.text = 'Failed to create the scss file';
                            throw err;
                        }

                        createdScss = true;
                        completeObject();
                    });
                });
            });
        });
    }
}

function completeObject(){
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
