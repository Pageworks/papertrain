const sass = require('node-sass');
const fs = require('fs');
const chalk = require('chalk');
const automationRoot = './public/automation';

// Filename argument passed via CLI
const args     = process.argv.slice(2);
const filepath = args[0];

replaceFile(filepath);

function replaceFile(filepath)
{
	// Find the File Name
	let filearray = filepath.split('/');
	let	filename = filearray[filearray.length - 1].replace('.scss', '.css');
	sass.render(
		 {
            file: filepath,
            outputStyle: 'compressed',
            includePaths: ['utils/styles/settings', 'utils/styles/tools']
        },
        function(error, result){
        	if (error) {
                console.log(chalk.hex('#f57b7b').bold(`SASS Compile Error:`), chalk.white(`${ error.message } at line`), chalk.yellow.bold(error.line), chalk.hex('#ffffff').bold(error.file));
            }else{

            	// Current CSS Directory
            	fs.readdirSync(automationRoot).forEach(file => {
					if (file.indexOf('styles-') !== -1) {
						let rewriteFile = automationRoot + '/' + file + '/' + filename;
						fs.writeFile(rewriteFile, result.css.toString(), function (err) {
                            if(err){
                                success = false;
                            };
                        });
					}
				})
            }
        }
	);
	
}

