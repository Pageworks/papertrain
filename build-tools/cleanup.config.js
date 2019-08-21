const rimraf = require("rimraf");
const fs = require('fs');

class CleanupManager
{
    constructor()
    {
        this.run();
    }

    async run()
    {
        try
        {
            const timestamp = await this.getTimestamp();
            const directories = await this.getAllAutomatedDirectories();
            await this.cleanup(timestamp, directories);
            await this.updateCachebust();
        }
        catch (error)
        {
            console.log(chalk.hex('#ff6426').bold(error));
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
                    reject('Skipping cleanup due to previous failure, see error above');
                }

                const timestamp = data.match(/\d+/g)[0];
                resolve(timestamp);

            });
        });
    }

    getAllAutomatedDirectories()
    {
        return new Promise((resolve, reject)=>{
            fs.readdir('public/automation', (error, paths)=>{
                if (error)
                {
                    reject(error);
                }

                resolve(paths);
            });
        });
    }

    cleanup(timestamp, directories)
    {
        return new Promise((resolve, reject)=>{
            console.log(chalk.white('Removing stale automated directories'));
            let count = 0;
            for (let i = 0; i < directories.length; i++)
            {
                const directoryTimestamp = directories[i].match(/\d+/)[0];

                if (parseInt(directoryTimestamp) !== parseInt(timestamp))
                {
                    rimraf(`public/automation/${ directories[i] }`, (err)=>{
                        if (err)
                        {
                            reject(err);
                        }

                        count++;
                        if (count === directories.length)
                        {
                            resolve();
                        }
                    });
                }
                else
                {
                    count++;
                    if (count === directories.length)
                    {
                        resolve();
                    }
                }
            }
        });
    }

    updateCachebust()
    {
        return new Promise((resolve, reject)=>{
            fs.readFile('config/papertrain/automation.tmp', (error, buffer)=>{
                if (error)
                {
                    reject(error);
                }

                let data = buffer.toString();
                data = data.replace('continue', '<?php');

                fs.writeFile('config/papertrain/automation.tmp', data, (error)=>{
                    if (error)
                    {
                        reject(error);
                    }

                    fs.rename('config/papertrain/automation.tmp', 'config/papertrain/automation.php', (error)=>{
                        if (error)
                        {
                            reject(error);
                        }

                        resolve();
                    });
                });
            });
        });
    }
}

new CleanupManager();