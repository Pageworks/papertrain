const inquirer   = require('inquirer');

module.exports = {
    getName: ()=>{
        const questions = [
            {
                name: 'name',
                type: 'input',
                message: 'Name',
                validate: (input)=>{
                    if (/[\-\_\t]/g.test(input)){
                        return 'Tabs, hyphens, and underscores are not allowed. They will be generated for you.';
                    }
                    else if(input === ''){
                        return 'A name is required.';
                    }
                    else{
                        return true;
                    }
                }
            },
        ];

        return inquirer.prompt(questions);
    },
    getDetails: ()=>{
        const questions = [
            {
                name: 'needsScss',
                type: 'confirm',
                message: 'Do you need SCSS?',
                default: true
            },
            {
                name: 'needsHTML',
                type: 'confirm',
                message: 'Do you need HTML?',
                default: true
            },
            {
                name: 'needsScript',
                type: 'confirm',
                message: 'Do you need a script?',
                default: true
            },
        ];

        return inquirer.prompt(questions);
    },
    scriptType: ()=>{
        const questions = [
            {
                name: 'scriptType',
                type: 'list',
                message: 'What type of script do you want?',
                choices: [
                    'TypeScript',
                    'JavaScript'
                ]
            },
        ];

        return inquirer.prompt(questions);
    },
    getType1: ()=>{
        const questions = [
            {
                name: 'generationType',
                type: 'list',
                message: 'What are you creating?',
                choices: [
                    'Component',
                    'Template'
                ]
            },
        ];

        return inquirer.prompt(questions);
    },
    getType2: ()=>{
        const questions = [
            {
                name: 'generationType',
                type: 'list',
                message: 'What are you creating?',
                choices: [
                    'Object',
                    'Template'
                ]
            },
        ];

        return inquirer.prompt(questions);
    },
    getLocation: (defaultPath)=>{
        const questions = [
            {
                name: 'fileLocation',
                type: 'input',
                message: 'Where should the files be generated?',
                default: defaultPath,
                validate: (input)=>{
                    if (/\s/g.test(input)){
                        return 'You should not have spaces in your path.';
                    }
                    else{
                        return true;
                    }
                }
            },
        ];

        return inquirer.prompt(questions);
    },
    confirmGeneration: ()=>{
        const questions = [
            {
                name: 'confirm',
                type: 'confirm',
                message: 'Is this information correct?',
                default: true
            },
        ];

        return inquirer.prompt(questions);
    },
}
