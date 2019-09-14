const sass = require('node-sass');
const fs = require('fs');
const chalk = require('chalk');

class SassWatcher
{
	constructor()
	{
		this.run();
	}

	async run()
	{
		try
		{
			const file = await this.getFile();
			const timestamp = await this.getTimestamp();
			await this.injectSass(file, timestamp);
		}
		catch (error)
		{
			console.log(chalk.hex('#ff6426').bold(error));
		}
	}

	getFile()
	{
		return new Promise((resolve, reject)=>{
			const file = process.argv.slice(2)[0];

			if (file)
			{
				resolve(file);
			}

			reject('Failed to get file from CLI, file was:', file);
		});
	}

	getTimestamp()
    {
        return new Promise((resolve, reject)=>{
            fs.readFile('config/papertrain/automation.php', (error, buffer)=>{
                if (error)
                {
                    reject(error);
                }

                const data = buffer.toString();
				const timestamp = data.match(/\d+/g)[0];
				
				if (timestamp)
				{
					resolve(timestamp);
				}

				reject('Failed to get the timestamp value, regex match returned', timestamp);
            });
        });
	}
	
	injectSass(file, timestamp)
	{
		return new Promise((resolve, reject)=>{
			sass.render(
				{
				   file: file,
				   outputStyle: 'compressed',
				   includePaths: ['sass/settings', 'sass/tools']
			   },
			   function(error, result)
			   {
					if (error)
					{
						reject(`SASS Compile Error: ${ error.message } at line ${ error.line } ${ error.file }`);
					}

				   	const filename = file.replace(/(.*\/)|(\.sass|\.css|\.scss)/g, '');

				   	fs.unlink(`public/automation/styles-${ timestamp }/${ filename }.css`, (error)=>{
						if (error)
						{
							reject(error);
						}

					   fs.writeFile(`public/automation/styles-${ timestamp }/${ filename }.css`, result.css, (error)=>{
							if (error)
							{
								reject(error);
							}
	
							resolve();
						});
				   });
			   }
		   );
        });
	}
}

new SassWatcher();
