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
			await this.injectSass(file);
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
	
	injectSass(file)
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

				   	fs.unlink(`public/automation/${ filename }.css`, (error)=>{
						if (error)
						{
							reject(error);
						}

					   fs.writeFile(`public/automation/${ filename }.css`, result.css, (error)=>{
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
