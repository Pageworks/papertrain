const rimraf = require("rimraf");
const fs = require('fs');

/** Prevents stale scripts from being bundled */
if(fs.existsSync('./_compiled')){
    rimraf.sync('./_compiled');
}

/** Cache busting timestamp logic */
if(!fs.existsSync(`config/papertrain/automation.php`)){
    createFile();
}
else
{
    fs.unlink('config/papertrain/automation.php', (error)=>{
        if (error)
        {
            throw error;
        }

        createFile();
    });
}

function createFile()
{
    fs.copyFile(`config/papertrain/example.automation.php`, `config/papertrain/automation.php`, (err) => {
        if (err){
            throw err;
        }

        fs.readFile('config/papertrain/automation.php', (error, buffer)=>{
            if (error)
            {
                throw error;
            }

            let data = buffer.toString();
            const timestamp = Date.now().toString();
            data = data.replace(/\d+/g, timestamp);

            fs.writeFile('config/papertrain/automation.php', data, (error)=>{
                if (error)
                {
                    throw error;
                }
            });
        });
    });
}
