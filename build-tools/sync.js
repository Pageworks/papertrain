const browserSync = require('browser-sync');
const fs = require('fs');
const dotenv = require('dotenv');
const envConfig = dotenv.parse(fs.readFileSync('.env'));
for (let k in envConfig) {
  process.env[k] = envConfig[k]
}

browserSync.create('development');

browserSync.init({
    proxy: process.env.DEV_URL
});

browserSync.watch("./templates", (event, file)=>{
    browserSync.reload;
});
browserSync.watch("./public/assets", (event, file)=>{
    browserSync.reload;
});
