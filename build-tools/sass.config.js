const watch = require('watch');
const sass = require('node-sass');
const glob = require("glob");
const fs = require('fs');
const rimraf = require("rimraf");
const chalk = require('chalk');

if(process.env.NODE_ENV === 'watch'){
    console.log('Watching for SASS changes');
    let initial = true
    watch.watchTree('../', (file, curr, prev)=>{

        if(!initial){
            const fileName = file.match(/\.([^.]*?)(?=\?|#|$)/gi)[0];
            if(fileName.toLowerCase() === '.scss'){
                compileSASS();
            }
        }

        if(initial){
            initial = false;
        }
    });
}else{
    compileSASS();
}

function compileSASS(){
    console.log(chalk.white('Compiling SASS'));

    // Get all the base SCSS files from the base global scss directory
    const globalFiles = glob.sync('./utils/styles/*.scss');

    // Get all the SCSS files from the templates lib directory
    const libFiles = glob.sync('./templates/_lib/**/*.scss');

    // Get all the SCSS files from the templates singles directory
    const singlesFiles = glob.sync('./templates/_singles/**/*.scss');

    // Concat the arrays
    const files = [...globalFiles, ...libFiles, ...singlesFiles];

    if(fs.existsSync('./public/assets/styles')){
        rimraf.sync('./public/assets/styles');
    }

    fs.mkdirSync('./public/assets/styles');

    // Create a timestamp for cache busting
    const timestamp = Date.now().toString().match(/.{8}$/g)[0];

    // Write the timestamp to Crafts general config file
    var data = fs.readFileSync('./config/general.php', 'utf-8');
    var newValue = data.replace(/'cssCacheBustTimestamp'.*/g, "'cssCacheBustTimestamp' => '"+ timestamp +"',");
    fs.writeFileSync('./config/general.php', newValue, 'utf-8');

    // Generate the files
    files.forEach((file)=>{
        sass.render(
            {
                file: file,
                outputStyle: 'compressed',
                includePaths: ['utils/styles/settings', 'utils/styles/tools']
            },
            function(error, result){
                if (error) {
                    console.log(chalk.hex('#f57b7b').bold(`SASS Compile Error:`), chalk.white(`${ error.message } at line`), chalk.yellow.bold(error.line), chalk.hex('#ffffff').bold(error.file));
                }else{
                    const fileName = result.stats.entry.match(/[ \w-]+?(?=\.)/gi)[0];
                    if(fileName){
                        const newFile = './public/assets/styles/' + fileName + '.' + timestamp + '.css';
                        console.log(chalk.hex('#ffffff').bold(file), chalk.hex('#8cf57b').bold(' [compiled]'));
                        fs.writeFile(newFile, result.css.toString(), function (err) {
                            if(err){ throw err };
                        });
                    }else{
                        console.log('Something went wrong with the file name of ' + result.stats.entry);
                    }
                }
            }
        );
    });
}
