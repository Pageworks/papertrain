const inquirer = require('inquirer');

module.exports = {
    getProjectDetails: ()=>{
        const questions = [
            {
                name: 'projectName',
                type: 'input',
                message: 'Project Name:',
                validate: (input)=>{
                    if(input !== ''){
                        return true;
                    }
                    return 'Please enter a project name.';
                }
            }
        ];

        return inquirer.prompt(questions);
    },
    getProjectURL: (projectName)=>{
        const questions = [
            {
                name: 'defaultUrl',
                type: 'input',
                message: 'Site URL:',
                default: `${ projectName.replace(/\s/g, '-').toLowerCase() }.local`,
                validate: (input)=>{
                    if(input !== ''){
                        if(input.match(/http:\/\//)){
                            return 'Do not add the http:// part of your URL';
                        }else{
                            return true;
                        }
                    }
                    return 'Please enter a project URL.';
                }
            },
            {
                name: 'devEmailAddress',
                type: 'input',
                message: 'Your Email Address:',
                default: `web@page.works`,
                validate: (input)=>{
                    if(input !== ''){
                        if(input.match(/.+@.+\..+/)){
                            return true;
                        }else{
                            return 'Please provide a valid email address.';
                        }
                    }
                    return 'Please enter your email address.';
                }
            }
        ];

        return inquirer.prompt(questions);
    },
    getDatabaseDetails: (projectName)=>{
        const questions = [
            {
                name: 'driver',
                type: 'list',
                message: 'Select a database driver:',
                choices: [
                    'mysql',
                    'pgsql'
                ]
            },
            {
                name: 'serverIp',
                type: 'input',
                message: 'Database server name or IP:',
                default: `localhost`,
                validate: (input)=>{
                    if(input !== ''){
                        return true;
                    }
                    return 'Please enter the server name or IP.';
                }
            },
            {
                name: 'user',
                type: 'input',
                message: 'Database username:',
                default: `root`,
                validate: (input)=>{
                    if(input !== ''){
                        return true;
                    }
                    return 'Please a username.';
                }
            },
            {
                name: 'password',
                type: 'input',
                message: 'Database password:',
                default: `root`,
                validate: (input)=>{
                    if(input !== ''){
                        return true;
                    }
                    return 'Please the password.';
                }
            },
            {
                name: 'port',
                type: 'input',
                message: 'Database port (optional):',
            },
            {
                name: 'database',
                type: 'input',
                message: 'Database name:',
                default: `craft_${ projectName.replace(/\s/g, '-').toLowerCase() }`,
                validate: (input)=>{
                    if(input !== ''){
                        return true;
                    }
                    return 'Please a database name.';
                }
            },
        ];

        return inquirer.prompt(questions);
    }
}
