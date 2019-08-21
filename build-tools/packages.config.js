const fs = require('fs');
const chalk = require('chalk');
const rollup = require('rollup');
const rollupPluginNodeResolve = require('rollup-plugin-node-resolve');
const rollupPluginCommonjs = require('rollup-plugin-commonjs');
const rimraf = require('rimraf');

const projectPackage = require('../package.json');

class NodeModuleBundler
{
    constructor()
    {
        console.log(chalk.white('Bundling node modules'));
        this.run();
    }

    async run()
    {
        try
        {
            const timestamp = await this.getTimestamp();
            await this.removeBundleDirectory();
            await this.makeBundleDirectory();
            await this.makePackageDirectory(timestamp);
            const dependencies = await this.getWebDependencies();
            const serverSafeBundleNames = await this.writeBundles(dependencies);
            await this.buildPackages(serverSafeBundleNames, timestamp);
            // await this.cleanup(timestamp);
        }
        catch (error)
        {
            console.log(chalk.hex('#ff6426').bold(error));
            await this.fail();
        }
    }

    getTimestamp()
    {
        return new Promise((resolve, reject)=>{
            fs.readFile('config/papertrain/automation.tmp', (error, buffer)=>{
                if (error)
                {
                    reject(error);
                }

                const data = buffer.toString();

                if (!data.match('continue'))
                {
                    reject('Skipping npm package bundler due to previous failure, see error above');
                }

                const timestamp = data.match(/\d+/g)[0];
                resolve(timestamp);

            });
        });
    }

    fail()
    {
        return new Promise((resolve, reject)=>{
            fs.readFile('config/papertrain/automation.tmp', (error, buffer)=>{
                if (error)
                {
                    reject(error);
                }

                let data = buffer.toString();
                data = data.replace('continue', 'failed');

                fs.writeFile('config/papertrain/automation.tmp', data, (error)=>{
                    if (error)
                    {
                        reject(error);
                    }

                    resolve();
                });
            });
        });
    }

    removeBundleDirectory()
    {
        return new Promise((resolve, reject)=>{
            if (fs.existsSync('./_packages'))
            {
                rimraf('./_packages', (error)=>{
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

    makeBundleDirectory()
    {
        return new Promise((resolve, reject)=>{
            fs.mkdir('./_packages', (err)=>{
                if (err)
                {
                    reject(err);
                }
        
                resolve();
            });
        });
    }

    makePackageDirectory(timestamp)
    {
        return new Promise((resolve, reject)=>{
            fs.mkdir(`public/automation/packages-${ timestamp }`, (err)=>{
                if (err)
                {
                    reject(err);
                }
    
                resolve();
            });
        });
    }

    getWebDependencies()
    {
        return new Promise((resolve)=>{
            let dependencies = [];
    
            if (projectPackage.webDependencies.length)
            {
                dependencies = projectPackage.webDependencies;
            }
            
            resolve(dependencies);
        });
    }

    writeBundles(dependencies)
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
                let packageName = fullPackageName.replace(/(.*?\/)/, '');

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
                
                fs.writeFile(`./_packages/${ serverSafeName }.js`, data, (err)=>{
                    if (err)
                    {
                        reject(err);
                    }

                    writtenBundles.push(serverSafeName);

                    if (writtenBundles.length === dependencies.length)
                    {
                        resolve(writtenBundles);
                    }
                });
            }
        });
    }

    buildPackages(serverSafeBundleNames, timestamp)
    {
        const built = [];
        return new Promise((resolve, reject)=>{
            for (let i = 0; i < serverSafeBundleNames.length; i++)
            {
                const inputOptions = {
                    input: `./_packages/${ serverSafeBundleNames[i] }.js`,
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
                    file: `./public/automation/packages-${ timestamp }/${ serverSafeBundleNames[i] }.js`,
                    format: 'iife'
                };
                this.build(inputOptions, outputOptions)
                .then(()=>{
                    built.push(serverSafeBundleNames[i]);

                    if (built.length === serverSafeBundleNames.length)
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

    build(inputOptions, outputOptions)
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
}

new NodeModuleBundler();
