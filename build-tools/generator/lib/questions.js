const inquirer   = require('inquirer');

module.exports = {
    askType: ()=>{
        const questions = [
            {
                name: 'type',
                type: 'list',
                message: 'Select what you would like to generate:',
                choices: [
                    'global',
                    'object',
                    'component',
                    'single'
                ]
            },
            {
                name: 'handle',
                type: 'input',
                message: 'Name:',
                validate: (input)=>{
                    if (/[\-\_\t]/g.test(input)){
                        return 'Tabs, hyphens, and underscores are not allowed. They will be generated for you.';
                    }
                    else{
                        return true;
                    }
                }
            }
        ];

        return inquirer.prompt(questions);
    }
}
