interface TwigOptions
{
    data?: string
    id?: string
    href?: string
    async?: boolean
    load?: (template:TwigTemplate)=>void
}

interface TwigTemplate
{
    render: (data:object)=>string
}

declare function twig(options:TwigOptions) : TwigTemplate

class TemplateManager
{
    private fetchTemplate(filePath:string) : Promise<string>
    {
        return new Promise((resolve, reject)=>{
            fetch(`${ window.location.origin }/twig/${ filePath }`)
            .then(request => request.text())
            .then(response => { resolve(response); })
            .catch(error => { reject(error); });
        });
    }

    public async load(filePath:string) : Promise<TwigTemplate>
    {
        try
        {
            const templateData = await this.fetchTemplate(filePath);
            const template = twig({ data: templateData });
            return template;
        }
        catch (error)
        {
            return null;
        }
    }

    public async ajax(filePath:string, data:object) : Promise<string>
    {
        try
        {
            const template = await this.load(filePath);
            const templateHTML = template.render(data);
            return templateHTML;
        }
        catch (error)
        {
            return '';
        }
    }
}