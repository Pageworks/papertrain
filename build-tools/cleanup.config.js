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
            await this.cleanup();
            await this.update();
            await this.cachebust();
        }
        catch (error)
        {
            console.log(error);
        }
    }

    cachebust()
    {
        return new Promise((resolve, reject) => {
            fs.rename('config/papertrain/automation.tmp', 'config/papertrain/automation.php', (error) => {
                if (error)
                {
                    reject(error);
                }

                resolve();
            });
        });
    }

    update()
    {
        return new Promise((resolve, reject) => {
            if (fs.existsSync('public/automation'))
            {
                fs.rename(`public/automation`, `public/automation_BACKUP`, (error) => {
                    if (error)
                    {
                        reject(error);
                    }
    
                    fs.rename(`public/automation_INCOMING`, 'public/automation', (error) => {
                        if (error)
                        {
                            reject();
                        }
        
                        resolve();
                    });
                });
            }
            else
            {
                fs.rename(`public/automation_INCOMING`, 'public/automation', (error) => {
                    if (error)
                    {
                        reject();
                    }
    
                    resolve();
                });
            }
        });
    }

    cleanup()
    {
        return new Promise((resolve, reject) => {
            if (fs.existsSync('public/automation_BACKUP'))
            {
                fs.rmdir('public/automation_BACKUP', { recursive: true }, (error) => {
                    if (error)
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
}

new CleanupManager();