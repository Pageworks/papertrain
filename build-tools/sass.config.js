const sass = require('node-sass');
const glob = require("glob");
const fs = require('fs');
const rimraf = require("rimraf");
const chalk = require('chalk');

// Create a timestamp for cache busting
const timestamp = Date.now().toString();

// Get all the base SCSS files from the base global scss directory
const globalFiles = glob.sync('./scss-settings/*.scss');

// Get all the SCSS files from the templates lib directory
const templateFiles = glob.sync('./templates/**/*.scss');

// Concat the arrays
const files = [...globalFiles, ...templateFiles];

let success = true;

compileSASS();

function compileSASS(){
    console.log(chalk.white('Compiling SASS'));

    // Make the new CSS directory
    fs.mkdirSync(`./public/automation/styles-${ timestamp }`);

    // Generate the files
    for(let i = 0; i < files.length; i++){
        const file = files[i];
        sass.render(
            {
                file: file,
                outputStyle: 'compressed',
                includePaths: ['scss-settings/settings', 'scss-settings/tools']
            },
            function(error, result){
                if (error) {
                    console.log(chalk.hex('#f57b7b').bold(`SASS Compile Error:`), chalk.white(`${ error.message } at line`), chalk.yellow.bold(error.line), chalk.hex('#ffffff').bold(error.file));
                }else{
                    const fileName = result.stats.entry.match(/[ \w-]+?(?=\.)/gi)[0].toLowerCase();
                    if(fileName){
                        const newFile = `./public/automation/styles-${ timestamp }/` + fileName + '.css';
                        console.log(chalk.hex('#ffffff').bold(file), chalk.hex('#8cf57b').bold(' [compiled]'));
                        cleanup(files.indexOf(file));
                        fs.writeFile(newFile, result.css.toString(), function (err) {
                            if(err){
                                success = false;
                            };
                        });
                    }else{
                        console.log('Something went wrong with the file name of ' + result.stats.entry);
                        success = false;
                    }
                }
            }
        );
    }
}

function cleanup(index){
    if(index !== files.length - 1){
        return;
    }

    if(!success){
        console.log(chalk.white('Something went wrong, the previous CSS will not be removed'));
        return;
    }

    console.log(chalk.white('Removing stale CSS'));

    const path = `public/automation`;
    const allDirs = fs.readdirSync(path);
    const styleDirs = [];
    for(let i = 0; i < allDirs.length; i++){
        if(allDirs[i].match(/styles-.*/)){
            styleDirs.push(allDirs[i]);
        }
    }

    for(i = 0; i < styleDirs.length; i++){
        const directoryTimestamp = styleDirs[i].match(/[^styles-].*/)[0];

        if(parseInt(directoryTimestamp) < parseInt(timestamp)){
            rimraf(`public/automation/${ styleDirs[i] }`, (err)=>{
                if(err){
                    console.log(`Failed to remove ${ styleDirs[i] }`);
                    throw err;
                }
            });
        }
    }

    // Write the timestamp to Crafts general config file
    var data = fs.readFileSync('./config/papertrain/automation.php', 'utf-8');
    var newValue = data.replace(/'cssCacheBustTimestamp'.*/g, "'cssCacheBustTimestamp' => '"+ timestamp +"',");
    fs.writeFileSync('./config/papertrain/automation.php', newValue, 'utf-8');
}
