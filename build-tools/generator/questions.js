const inquirer   = require('inquirer');
const fs = require('fs');

module.exports = {
    getName: ()=>{
        const questions = [
            {
                name: 'name',
                type: 'input',
                message: 'Name',
                validate: (input)=>{
                    if(input === ''){
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
    getType: ()=>{
        const questions = [
            {
                name: 'type',
                type: 'list',
                message: 'What are you creating?',
                choices: [
                    'Template',
                    'Web Component',
                    'Global Stylesheet'
                ]
            }
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
    getPath: (type)=>{
        const questions = [
            {
                name: 'path',
                type: 'input',
                message: `Where should the ${ type } be generated?`,
                default: (type === 'Template') ? 'templates/' : '',
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
