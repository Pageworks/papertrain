const rimraf = require("rimraf");
const fs = require('fs');

/** Prevents stale scripts from being bundled */
if(fs.existsSync('./_compiled')){
    rimraf.sync('./_compiled');
}

/** Cache busting timestamp logic */
if(!fs.existsSync(`config/papertrain/automation.php`)){
    fs.copyFile(`config/papertrain/example.automation.php`, `config/papertrain/automation.php`, (err) => {
        if (err){
            throw err;
        }
    });
}
