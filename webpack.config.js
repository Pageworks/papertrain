const path = require('path');
const glob = require("glob");
const fs = require('fs');
const rimraf = require("rimraf");
const chalk = require('chalk');
const TerserPlugin = require('terser-webpack-plugin');

// Create a timestamp for cache busting
const timestamp = Date.now().toString();

const entries = {};

// Get the entries
const entryFiles = glob.sync('./_compiled/**/*.js');
if(entryFiles.length){
    for(let i = 0; i < entryFiles.length; i++){
        const name = entryFiles[i].match(/[ \w-]+?(?=\.)/)[0].toLowerCase();
        entries[name] = entryFiles[i];
    }
}else{
    console.log('Missing JS files');
    return;
}

// Bundle modules
module.exports = {
    mode: (process.env.NODE_ENV === 'production') ? 'production' : 'none',
    entry: entries,
    output: {
        path: path.resolve(__dirname, './public/assets'),
        filename: `modules-${ timestamp }/[name].js`
    },
    resolve:{
        modules:[
            './utils/scripts',
            './node_modules'
        ]
    },
    optimization: {
        runtimeChunk: 'single',
        splitChunks: {
            chunks: 'all',
            name: 'globals',
            maxInitialRequests: Infinity,
            minSize: 0,
            cacheGroups: {
                vendor: {
                    test: /[\\/]node_modules[\\/]/,
                    name(module) {
                        // get the name. E.g. node_modules/packageName/not/this/part.js
                        // or node_modules/packageName
                        const packageName = module.context.match(/[\\/]node_modules[\\/](.*?)([\\/]|$)/)[1];

                        // npm package names are URL-safe, but some servers don't like @ symbols
                        return `../packages-${ timestamp }/npm.${packageName.replace('@', '')}`;
                    },
                },
            },
        },
        minimizer: [new TerserPlugin({
            terserOptions:{
                ecma: 5,
                mangle: false,
                output: {
                    beautify: false,
                    comments: false
                }
            }
        })]
    },
    plugins: [
        function(){
            this.plugin("done", function(stats){
                if (stats.compilation.errors && stats.compilation.errors.length){
                    console.log(stats.compilation.errors);
                    process.exit(1);
                }else{
                    cleanup();
                }
            });
        }
    ],
};

function cleanup(){
    console.log(chalk.white('Removing stale JavaScript builds'));

    const path = `public/assets`;
    const allDirs = fs.readdirSync(path);

    const moduleDirs = [];
    for(let i = 0; i < allDirs.length; i++){
        if(allDirs[i].match(/modules-.*/)){
            moduleDirs.push(allDirs[i]);
        }
    }

    for(i = 0; i < moduleDirs.length; i++){
        const modulesTimestamp = moduleDirs[i].match(/[^modules-].*/)[0];

        if(parseInt(modulesTimestamp) < parseInt(timestamp)){
            rimraf(`public/assets/${ moduleDirs[i] }`, (err)=>{
                if(err){
                    console.log(`Failed to remove ${ moduleDirs[i] }`);
                    throw err;
                }
            });
        }
    }

    const packageDirs = [];
    for(let i = 0; i < allDirs.length; i++){
        if(allDirs[i].match(/packages-.*/)){
            packageDirs.push(allDirs[i]);
        }
    }

    for(i = 0; i < packageDirs.length; i++){
        const packageTimestamp = packageDirs[i].match(/[^packages-].*/)[0];

        if(parseInt(packageTimestamp) < parseInt(timestamp)){
            rimraf(`public/assets/${ packageDirs[i] }`, (err)=>{
                if(err){
                    console.log(`Failed to remove ${ packageDirs[i] }`);
                    throw err;
                }
            });
        }
    }

    // Write the timestamp to local general config file
    var data = fs.readFileSync('./config/papertrain/automation.php', 'utf-8');
    var newValue = data.replace(/'jsCacheBustTimestamp'.*/g, "'jsCacheBustTimestamp' => '"+ timestamp +"',");
    fs.writeFileSync('./config/papertrain/automation.php', newValue, 'utf-8');
}
