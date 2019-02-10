const browserSync = require('browser-sync');
const fs = require('fs');
const dotenv = require('dotenv');
const envConfig = dotenv.parse(fs.readFileSync('.env'));
for (let k in envConfig) {
  process.env[k] = envConfig[k]
}

browserSync.create('papertrain');

browserSync.init({
    proxy: process.env.DEV_URL
});

browserSync.watch("./templates").on("change", browserSync.reload);
browserSync.watch("./public/assets").on("change", browserSync.reload);

browserSync.watch("./app/typescript").on("change", ()=>{
    const message = 'Compiling TypeScript';
    browserSync.notify(`<div style="position:fixed;top:0;left:0;display:inline-flex;width:100vw;height:100vh;justify-content:center;align-items:center;background-color:#fafafa"><span style="display:inline-block;padding:16px 32px;border-radius:4px;background-color:#ffffff;box-shadow: 0 4px 32px rgba(75,78,109,0.1);font-size:22px;color:#414141;">${message}</span></div>`, Infinity);
});

browserSync.watch("./_compiled").on("change", ()=>{
    const message = 'Bundling Modules';
    browserSync.notify(`<div style="position:fixed;top:0;left:0;display:inline-flex;width:100vw;height:100vh;justify-content:center;align-items:center;background-color:#fafafa"><span style="display:inline-block;padding:16px 32px;border-radius:4px;background-color:#ffffff;box-shadow: 0 4px 32px rgba(75,78,109,0.1);font-size:22px;color:#414141;">${message}</span></div>`, Infinity);
});

browserSync.watch("./app/sass").on("change", ()=>{
    const message = 'Compiling SCSS';
    browserSync.notify(`<div style="position:fixed;top:0;left:0;display:inline-flex;width:100vw;height:100vh;justify-content:center;align-items:center;background-color:#fafafa"><span style="display:inline-block;padding:16px 32px;border-radius:4px;background-color:#ffffff;box-shadow: 0 4px 32px rgba(75,78,109,0.1);font-size:22px;color:#414141;">${message}</span></div>`, Infinity);
});