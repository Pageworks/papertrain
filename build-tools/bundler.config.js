const fs = require('fs');
const rollup = require('rollup');
const rollupPluginNodeResolve = require('rollup-plugin-node-resolve');
const rollupPluginCommonjs = require('rollup-plugin-commonjs');
const rimraf = require('rimraf');
const glob = require("glob").Glob;

const package = require('../package.json');

function run()
{
    (async ()=>{
        try
        {
            await removeBundles();
            await removePackages();
            await makeBundleDirectory();
            await makePackageDirectory();
            const dependencies = await getWebDependencies();
            const serverSafeBundleNames = await writeBundles(dependencies);
            await buildPackages(serverSafeBundleNames);
        }
        catch(error)
        {
            throw error;
        }
    })();
}

function removeBundles()
{
    return new Promise((resolve, reject)=>{
        if(fs.existsSync('_bundles'))
        {
            rimraf('_bundles', (error)=>{
                if(error)
                {
                    reject(error);
                }

                resolve();
            });
        }
        else
        {
            resolve();
        }
    });
}

function removePackages()
{
    return new Promise((resolve, reject)=>{
        if(fs.existsSync('public/automation/packages'))
        {
            rimraf('public/automation/packages', (error)=>{
                if(error)
                {
                    reject(error);
                }

                resolve();
            });
        }
        else
        {
            resolve();
        }
    });
}

function makeBundleDirectory()
{
    return new Promise((resolve, reject)=>{
        fs.mkdir('_bundles', (err)=>{
            if(err)
            {
                reject(err);
            }
    
            resolve();
        });
    });
}

function makePackageDirectory()
{
    return new Promise((resolve, reject)=>{
        fs.mkdir('public/automation/packages', (err)=>{
            if(err)
            {
                reject(err);
            }
    
            resolve();
        });
    });
}

function getWebDependencies()
{
    return new Promise((resolve)=>{
        let dependencies = [];

        if(package.webDependencies.length)
        {
            dependencies = package.webDependencies;
        }
        
        resolve(dependencies);
    });
}

function writeBundles(dependencies)
{
    return new Promise((resolve, reject)=>{
        
        const writtenBundles = [];
        
        for (let i = 0; i < dependencies.length; i++)
        {
            let serverSafeName = dependencies[i].package.toLowerCase();
            serverSafeName = serverSafeName.replace(/[\/]/g, '-');
            serverSafeName = serverSafeName.replace(/\@/g, '');

            /**
             * Example:
             * fullPackageName = @codewithkyle/demo-package
             * namespace = codewithkyle
             * package = demo-package
             * filename = codewithkyle-demo-package
             */
            let fullPackageName = dependencies[i].package.toLowerCase();
            let namespace = (fullPackageName.match(/.*[\/]/)) ? fullPackageName.match(/.*[\/]/)[0].replace(/[\/\@]/g, '') : '';
            let package = fullPackageName.replace(/(.*?\/)/, '');

            /** Write pre-bundled bundle file */
            let data = `import ${ dependencies[i].import } from '${ fullPackageName }'\n`;
            if(dependencies[i].import.match(/(\*\sas)/))
            {
                let importName = dependencies[i].import;
                importName = importName.replace(/(.*\sas\s)/, '');
                importName = importName.trim();
                data += `\nwindow.${ importName } = ${ importName }.default;`;
            }
            else
            {
                let importName = dependencies[i].import;
                importName = importName.replace(/[\{\}]/g, '');
                importName = importName.trim();
                data += `\nwindow.${ importName } = ${ importName };`;
            }
            
            fs.writeFile(`_bundles/${ serverSafeName }.js`, data, (err)=>{
                if(err)
                {
                    console.log(err);
                }

                writtenBundles.push(serverSafeName);

                if(writtenBundles.length === dependencies.length)
                {
                    resolve(writtenBundles);
                }
            });
        }
    });
}

function buildPackages(serverSafeBundleNames)
{
    const built = [];
    return new Promise((resolve, reject)=>{
        for (let i = 0; i < serverSafeBundleNames.length; i++)
        {
            const inputOptions = {
                input: `_bundles/${ serverSafeBundleNames[i] }.js`,
                plugins: [
                    rollupPluginNodeResolve({
                        mainFields: ['browser', 'module', 'jsnext:main'],
                        extensions: [ '.mjs', '.js', '.json'],
                        browser: true
                    }),
                    rollupPluginCommonjs({
                        include: /node_modules/,
                        extensions: ['.cjs', '.js']
                    })
                ]
            };
            const outputOptions = {
                file: `public/automation/packages/${ serverSafeBundleNames[i] }.js`,
                format: 'iife'
            };
            build(inputOptions, outputOptions)
            .then(()=>{
                built.push(serverSafeBundleNames[i]);

                if(built.length === serverSafeBundleNames.length)
                {
                    resolve();
                }
            })
            .catch(err => {
                reject(err);
            });
        }
    });
}

function build(inputOptions, outputOptions)
{
    return new Promise((resolve, reject)=>{
        (async ()=>{
            try
            {
                const bundle = await rollup.rollup(inputOptions);
                await bundle.write(outputOptions); 
                resolve();
            }
            catch (err)
            {
                reject(err)
            }
        })();
    });
}

run();