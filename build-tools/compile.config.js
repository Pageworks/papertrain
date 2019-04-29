const rimraf = require("rimraf");
const fs = require('fs');

if(fs.existsSync('./_compiled')){
    rimraf.sync('./_compiled');
}
