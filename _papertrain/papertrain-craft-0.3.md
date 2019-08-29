# Papertrain for Craft 3 - v0.3

## Contents

1. [Requirements](#requirements)
    1. [Required Knowledge](#required-knowledge)
    1. [Required Software](#required-software)
1. [Tools & Libraries](#tools-and-libraries)
1. [Getting Started](#getting-started)
    - [New Project Setup](#new-project)
    - [Existing Project Setup](#existing-project)
1. [Working with Papertrain](#working-with-papertrain)
    1. [Front-End Imports](#front-end-imports)
    1. [The Project Templating Hierarchy](#the-project-templating-hierarchy)
    1. [Web Modules](#web-modules)

## Requirements

Papertrain provides the tooling to help limit the knowledge requirements when building new templates or web components, however, you should have a basic level of knowledge with the following requirements when attempting to construct advanced functionality, especially when constructing global state managers or micro single page applications.

### Required Knowledge

- Familiar with the [Craft 3 installation](https://docs.craftcms.com/v3/installation.html) process
- Familiar with [es2015 (es6)](https://www.ecma-international.org/ecma-262/6.0/)
- Familiar with [Custom Elements](https://html.spec.whatwg.org/multipage/custom-elements.html#custom-elements)
- Familiar with the [Template](https://html.spec.whatwg.org/multipage/scripting.html#the-template-element) element

### Required Software

- [Node.js](https://nodejs.org/en/)
- [Composer](https://getcomposer.org/download/)
- [Ubuntu LAMP stack](https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-ubuntu-18-04) or [MAMP Pro](https://www.mamp.info/en/)
- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

## Tools and Libraries

v0.3 uses the following third party tools/libraries:

- [rollup.js](https://rollupjs.org/guide/en/)
- [node-sass v4](https://github.com/sass/node-sass)
- [TypeScript v3](https://www.typescriptlang.org/docs/home.html)

v0.3 uses the following first party tools/libraries:

- [Device Manager v1](https://github.com/Pageworks/device-manager)

## Getting Started

Use the following guides to setup a Papertrain project. Please note that additional setup steps may be required on a project-by-project basis, please speak with the Project Manager or your team lead for additional assistance or instructions.

### New Project

1. Download the [latest release](https://github.com/Pageworks/papertrain/releases) of Papertrain
2. Extract the files into your projects root directory
3. Open your terminal and navigate to the projects root directory
4. Install the NPM dependencies by running the following command in your terminal

```script
npm install
```

5. Install Craft CMS by running the following command in your terminal

```script
composer install
```

6. Set your Apache server to point to the projects `public/` directory
7. Create a new empty database for the project
8. Run the setup script by running the following command in your terminal

```script
npm run setup
```

9. To finish the new project setup follow the Craft CMS installation guide that opens in your web browser. If your web browser doesn't automatically open navigate to the `/webmaster/install` page.
10. After Craft is installed you may need to navigate to the `/webmaster/utilities/updates` page to update Craft and the boilerplate plugins.

### Existing Project

1. Clone the repository
2. Navigate your terminal into the projects root directory
3. Install the NPM packages by running the following command:

```script
npm ci
```

4. Set your Apache server to point to the projects `public/` directory
5. Create a new empty database for the project OR import the existing staging/production database
6. Setup the project by running the following command:

```script
npm run setup
```

7. If you **DID NOT** import an existing database during *Step 5* you can finish the setup by following the Craft CMS installation guide that opens in your web browser. If your web browser doesn't automatically open navigate to the `/webmaster/install` page.


## Working with Papertrain

Papertrain comes with a custom Craft 3 module that provides basic functionality to the front-end developer. There are five predefined ways to pull the compiled code into the website.

### Front-End Imports

This section will cover the basics of requesting your compiled code in the front-end.

#### Critical CSS

Any file placed within a Critical CSS array will always be fetched and appended to the `<head>` before the loading animation ends. You can define Critical CSS by using the following:

```twig
{{ craft.papertrain.criticalCss(['first-file', 'second-file']) }}
```

#### Stylesheets

Any file placed within a Stylesheets array will be fetched and appended to the `<head>` after the browsers first idle callback. The CSS within these files will be lazy painted with the goal of helping to reduce the [complexity and improve render performance](https://developers.google.com/web/fundamentals/performance/rendering/simplify-paint-complexity-and-reduce-paint-areas) of the initial contextual paint. The goal is to provide an acceptable first contextual paint under one second. You can define Stylesheets by using the following:

```twig
{{ craft.papertrain.stylesheets(['first-file', 'second-file', 'thrid-file']) }}
```

#### NPM Packages

Sometimes it's easier to pull in a NPM package instead of trying to create your own homegrown solution. In these cases you'll need to follow these steps to ensure that the package is bundled for web and included in the project. In this example we will be using the `@pageworks/device-manager` package that is pre-installed in Papertrain.

1. Install the dependency via npm from your terminal

```script
npm i @pageworks/device-manager
```

2. Create a new Web Dependency object within the `webDependencies` section of the projects `package.json` file

```json
{
    "package": "@pageworks/device-manager",
    "import": "DeviceManager"
}
```

The allowed import options are as follows:
- `PackageName`
- `{ PackageName }`
- `* as PackageName`

3. Run the build command in your terminal

```script
npm run build
```

Unless the NPM package uses a [Node.js API](https://nodejs.org/dist/latest-v6.x/docs/api/) and the creator didn't provide a [browser ready substitute](https://docs.npmjs.com/files/package.json#browser) the package is ready to be used in the front-end. Use the following to within your template to request the package:

```twig
{{ craft.papertrain.packages(['pageworks-device-manager']) }}
```

If you're unsure what the generated file is called you can look for it in the `public/automation/packages/` directory.

#### Web Components

Web Components typically handle their CSS and Script front-end includes, however, you could use the following in a template to include a Web Component:

```twig
{{ craft.papertrain.components(['my-cool-component']) }}
```

#### Web Modules

Web Modules are global state managers and can be requested in your template by using the following:

```twig
{{ craft.papertrain.modules(['example-module']) }}
```

### The Project Templating Hierarchy

Website Templates are primarily composed of two components.

1. The Template
2. Web Components

#### Template

A new template can be created by using the Papertrain component generator. To start the generator run the following script in your terminal:

```script
npm run create
```

Then select the Template option from the list.

Templates are typically generated in the projects root `templates/` directory, however, any valid path within the `templates/` directory is allowed. An example of when templates may need to be placed within another template could be the My Account section of a website.

Templates consists of a View and a Stylesheet.

In Papertrain these files are generated as `template.twig` and `template.scss`.

#### Web Component

[Web Components](https://developer.mozilla.org/en-US/docs/Web/Web_Components) are [Custom Elements](https://html.spec.whatwg.org/multipage/custom-elements.html#custom-elements) that typically live within a specific template directory.

A new Web Component can be created by using the Papertrain component generator. To start the generator run the following script in your terminal:

```script
npm run create
```

Then select the Web Component option from the list.

Web Components are always composed of three primary components: a View, a Stylesheet, and a Controller.

In Papertrain Web Components will be generated with the following three files:

1. `example-component.twig`
2. `example-component.scss`
3. `example-component.ts` (the `js` filetype is allowed, however, TypeScript is preferred)

*Note:* occasionally global Web Components (such as a Header) may need to live at the projects `templates/` directory.

### Web Modules

Some project may require a state manager or only the Model and the Controller components of the [MVC software design pattern](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller) they can be created as Web Modules. Web Modules are similar to NPM Packages since they also lack a View. In the following example we will create a Cart Manager module.

1. Create a new file named `cart-manager.ts` in the `web_modules/` directory
    - Files should be a `.ts` file, however, the `.js` filetype is allowed
    - Filenames should be written in lowercase
    - Filenames will be written in [kebab case](https://en.wikipedia.org/wiki/Letter_case#Special_case_styles)
2. Create the Cart Manager class shell

```javascript
class CartManager
{
    // Logic goes here
}
```

3. Create a public function that gets the Cart as a JSON object from Craft Commerce

```typescript
interface CraftCart
{
    foo : string
    bar : number
}

class CartManager
{
    public cart : CraftCart;

    constructor()
    {
        this.cart = null;
        this.init();
    }

    public getCart() : Promise<CraftCart|string>
    {
        const data = new FormData();
        data.append('CRAFT_CSRF_TOKEN', document.documentElement.dataset.csrf);

        return new Promise((resolve, reject) => {
            fetch(`${ window.location.origin }/actions/commerce/cart/update-cart`,
            {
                method: 'POST',
                credentials: 'include',
                headers: new Headers({
                    'X-Requested-With': 'XMLHttpRequest',
                    'Accept': 'application/json'
                }),
                body: data
            })
            .then(request => request.json())
            .then(response => {
                this.cart = response.cart;
                resolve(response.cart);
            })
            .catch(error => {
                reject(error);
            });
        });
    }

    private init() : void
    {
        this.getCart().then(cart => {
            console.log('Fetched initial cart');
        })
        .catch(error => {
            console.error(error);
        });
    }
}
```

4. Run the build command in your terminal

```script
npm run build
```

5. Request the Web Module in your template by using the following:

```twig
{{ craft.papertrain.modules(['cart-manager']) }}
```

The Cart Manager will be available as `cartManager` within the global scope of the window.
