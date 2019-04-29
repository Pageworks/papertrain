const path = require('path');
const glob = require("glob");
const fs = require('fs');
const rimraf = require("rimraf");
const TerserPlugin = require('terser-webpack-plugin');

// Create a timestamp for cache busting
const timestamp = Date.now().toString().match(/.{8}$/g)[0];

// Remove old scripts
if(fs.existsSync('./public/assets/scripts')){
    rimraf.sync('./public/assets/scripts');
}

fs.mkdirSync('./public/assets/scripts');

// Write the timestamp to Crafts general config file
var data = fs.readFileSync('./config/general.php', 'utf-8');
var newValue = data.replace(/'jsCacheBustTimestamp'.*/g, "'jsCacheBustTimestamp' => '"+ timestamp +"',");
fs.writeFileSync('./config/general.php', newValue, 'utf-8');

const entries = {};

// Get the utility classes
const utils = glob.sync('./_compiled/templates/utils/scripts/**/*.js');
if(utils.length){
    for(let i = 0; i < utils.length; i++){
        const name = utils[i].match(/[ \w-]+?(?=\.)/)[0];
        entries[name] = utils[i];
    }
}

// Get the components
const components = glob.sync('./_compiled/templates/lib/components/**/*.js');
if(components.length){
    for(let i = 0; i < components.length; i++){
        const name = components[i].match(/[ \w-]+?(?=\.)/)[0];
        entries[name] = components[i];
    }
}

// Bundle modules
module.exports = {
    mode: (process.env.NODE_ENV === 'production') ? 'production' : 'none',
    entry: entries,
    output: {
        filename: '[name].'+timestamp+'.js',
        path: path.resolve(__dirname, './public/assets/scripts')
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
                return `npm.${packageName.replace('@', '')}`;
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
    }
};
