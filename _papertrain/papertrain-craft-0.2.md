# Papertrain for Craft 3 - v0.2

## Requirements

- Familiar with the base [Craft 3 installation](https://docs.craftcms.com/v3/installation.html)
- [Node.js](https://nodejs.org/en/)
- [Composer](https://getcomposer.org/download/)
- [Ubuntu LAMP stack](https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-ubuntu-18-04) or [MAMP Pro](https://www.mamp.info/en/)
- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [Dashlane](https://www.dashlane.com/)
- [DropSync 3](https://www.mudflatsoftware.com/)

## Getting Started

### New Project

1. Start by downloading the [latest release](https://github.com/Pageworks/papertrain/releases) of Papertrain and extracting the files into your projects root directory

2. Install the NPM dependencies by running the following command in your terminal

```script
npm install
```

3. Install Craft CMS by running the following command in your terminal

```script
composer install
```

4. Set your Apache server to point to the projects `public/` directory.

5. Create a new empty database for the project

6. Run the setup script by running the following command in your terminal

```script
npm run dev && npm run setup
```

To finish follow the Craft CMS installation in the browser. If the browser doesn't automatically open, navigate to the `/webmaster` page.

### Additional Steps

After Craft is installed you may need to navigate to the Utility -> Updates section and update Craft or any of the plugins.

If you're using a Git repository run the following command in your terminal:

```script
git init
```

Followed by creating your first commit:

```script
git commit -m "Initial commit"
```

Don't forget to set your remote:

```script
git remote add origin <URL>
```

Then push your commit and master branch:

```script
git push -u origin master
```

## Joining an Existing Project

1. Start by cloning the project

```script
git clone <URL>
```

2. Install the NPM dependencies by running the following command in your terminal

```script
npm ci
```

3. Set your Apache server to point to the projects `public/` directory

4. Create a new empty database for the project

5. Request access to the following information in Dashlane

- Saved password
- Secure note

6. Run the setup script by running the following command in your terminal

```script
npm run dev && npm run setup
```

To finish follow the Craft CMS installation in the browser. If the browser doesn't automatically open, navigate to the `/webmaster` page. Log in using the email and password pair found in Dashlane.

7. Open DropSync 3 and create a new Folder Pair, do the following

    1. Use the projects name for the folder pairing name
    1. Use the SSH access method
    1. Drag your projects local `public/uploads/` directory into the left side of the folder pair
    1. Enter the public IPv4 address from the projects secure note for the Host name
    1. Enter the Username from the secure note for the User name
    1. Enter the password from the secure note for the password
    1. Use port 22
    1. Click the left arrow button to open the path navigation popup
    1. Navigate to `www/public_html/public/`
    1. Select the `uploads/` directory
    1. Click the connect button
    1. Check to box to the right of the uploads folder
    1. Right click the folder pair you created (can be found in the sidebar) and select "Open configuration window"
    1. In the "Allowed Sync Directions" change from Both to Right to Left
    1. Close the configuration window
    1. Click the arrow to sync all check directories and files to your local uploads directory
    1. Click proceed when the file transfer preview window appears
    1. Close DropSync 3 when all files have been transferred to your local directory

## Working With Papertrain

### Tools & Libraries

v0.2 uses the following 3rd party tools/libraries:

- [Webpack v4](https://webpack.js.org/configuration/)
- [node-sass v4](https://github.com/sass/node-sass)
- [TypeScript v3](https://www.typescriptlang.org/docs/home.html)

v0.2 uses the following first party tools/libraries:

- [Device Manager v1](https://github.com/Pageworks/device-manager)
- [State Manager v1](https://github.com/Pageworks/state-manager)

### Build Tools

#### Using the Generator

To run the code generator run the following command

```
npm run create
```

Then select what you would like to create, the table below shows the differences between the available options:

| Type      | Location                     | Provides                            |
| --------- | ---------------------------- | ----------------------------------- |
| global    | `templates/_lib/globals/`    | Sass                                |
| object    | `templates/_lib/objects/`    | Sass Twig                           |
| component | `templates/_lib/components/` | Sass Twig TypeScript                |
| template  | `templates/`                 | Sass Twig [TypeScript]              |


#### Compiling Your Code

**Development**

You can compile your code for development use by running the following command in your terminal

```
npm run dev
```

Development code is not minified or uglified.

**Production**

You can compile production quality code by running the following command in your terminal

```
npm run compile
```

#### Design and Development

**JavaScript Framework**

Papertrain uses a [Modular Design Pattern](https://github.com/Pageworks/modular-design-pattern) in an attempt to codify Brad Frost's [Atomic Design methodology](http://bradfrost.com/blog/post/atomic-web-design/). The primary use of this patten is to manage an infinite amount of interchangeable components that can each individually communicate with an infinite amount of business-logic controllers.

[Checkout this example](https://github.com/codewithkyle/modular-design-pattern-javascript-example) of how we've converted this pattern to work for JavaScript. A live demo showcasing how components can be used together is [available here](https://codewithkyle.github.io/modular-design-pattern-javascript-example/).

**Complex Content**

Complex Content is a structure that defines the layout and grouping of sections, containers, and blocks. [Checkout this example](https://pageworks.github.io/complex-content/) to see how pages are constructed. [Click here](https://github.com/Pageworks/complex-content#structure) to learn more about the basic structure of Complex Content.

In Craft 3 Complex Content is a [matrix field type](https://docs.craftcms.com/v3/matrix-fields.html) and is used as a substitute page builder.

**Atomic Design**

The goal of Atomic Design is to break templates into components that can be broken into objects that can be sometimes broken down into globals. By doing this we can craft small, reuseable, elements and code snippets that can be reused throughout the site or on other projects.

#### CSS

In Papertrain a Global is a unique style for a [Basic HTML Element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element). Globals will **NEVER** apply the style to the raw HTML element.

File: `Button.scss`

**Correct Usage**

```scss
.g-button{
    border: 2px solid aqua;
    border-radius: 2px;
    padding: 0 16px;
    height: 36px;
    line-height: 36px;

    &.-solid{
        background-color: aqua;
    }
}
```

**Incorrect Usage**

```scss
button{
    border: 2px solid aqua;
    border-radius: 2px;
    padding: 0 16px;
    height: 36px;
    line-height: 36px;
}
```

#### Your First Template

This section will detail the process of adding a new template to the project. We will generate a template, a component.

1. Run the following command to generate the template

```
npm run create
```
2. Name the template **demo**
3. Answer the questions
4. Select **template** from the list
5. Press enter to use the default path of `templates/` for the new template

At this point your new template has been created and available at `templates/demo/`. If your site is running you can checkout the template by opening a browser and navigating to the `/demo` page.

5. Create a component by running the following command in your terminal

```
npm run create
```
6. Name the component **demo component**
    - Note that underscores and hyphens are not allowed, they will be generated for you
7. Answer the questions
8. Use your arrow keys to select **component** from the list
9. When asked for a path enter `templates/demo`

You can checkout your new components files in the `templates/demo/demo-component/` directory.

8. Open the `templates/demo/index.twig` file
9. In the `<section>` element include your component using Twigs [include statement](https://twig.symfony.com/doc/2.x/tags/include.html) `{% include "demo/demo-component" %}`

10. Open the `templates/demo/demo-component/demo-component.ts` file
11. Paste the following code into the classes `afterMount()` method

```javascript
this.view.style.border = '2px solid blue';
this.view.style.width = '512px';
this.view.style.height = '512px';

this.view.addEventListener('click', ()=>{
    this.view.style.border = '2px solid red';
});
```

12. Run the development compile command by running the following command in your terminal

```
npm run dev
```

13. On the `/demo` page you should see your demo component with a blue border, click on the component and notice the border color change

Notice that `this.view` refers to the initial demo component node within the DOM. Use `this.view` when querying for other nodes within the component, see the example below:

```javascript
const slides = Array.from(this.view.querySelectorAll('.js-slide'));
const button = this.view.querySelector('button');
```

By always querying from `this.view` we can safely have several instances of the component on the page.


#### Your First Block

This section will detail the process of adding a new block to Complex Content, if Complex Content is not installed you can [download it here](https://github.com/Pageworks/complex-content/releases/tag/v0.1.0).

1. In your browser navigate to the `webmaster/settings/fields` page
2. Click on the **Complex Content** matrix field
3. On the edit page click the **New block type** button
4. Enter **Demo** as the blocks name and **demoBlock** as the blocks handle
5. Name the default blank field **Heading**
6. Click the orange **Save** button
7. Click the **Spoon** tab located in the side navigation panel
8. Click on the **Complex Content** matrix field
9. Create a **Basic Blocks** group (if it doesn't already exist) by clicking the **New Group** button, if the group already exists drag the **Demo** block from the **Blocks** section into the **Basic Blocks** section
10. Click the orange **Save** button
11. Click the **Entries** tab located in the side navigation panel
12. Click on the **Standard Pages** tab
13. Add a new entry named **Testing** if one doesn't already exist by clicking on the **New entry** button
14. In the **Content Builder** tab add your **Demo** block (located in the **Basic Blocks** dropdown)
15. Paste `Lorem Ipsum Dolor` into the **Heading** field and save the entry by clicking on the orange **Save Entry** button
16. Create a new `demoBlock.twig` file in the `templates/_blocks/` directory
17. Paste in the following code into the file you just created

```twig
{% if block.heading|length %}
    <div class="u-1/1">
        <h1>{{ block.heading }}</h1>
    </div>
{% endif %}
```

Your new block has been created. When writing blocks there are two possible paths to take:

**Option 1**

Write blocks using global classes and standard HTML elements. Blocks don't have their own Scss or TypeScript file so they are limited to global Scss.

**Option 2**

Replace the blocks code with a Twig [include statement](https://twig.symfony.com/doc/2.x/tags/include.html) and include the object or component you need.

#### Using Global Classes & JavaScript

Each JavaScript and CSS file is generated as it's own general file. To use a file on a page it must be registered. Components, objects, and templates are generated with a asset path building function that takes an array of strings.

**CSS**

```twig
{% set ExampleAssets = craft.papertrain.getAssetPaths(['demo']) %}

{% do view.registerCssFile(ExampleAssets['demo'].css) %}
```

CSS files can be registered to the view by passing in the string as a key to the asset object and requesting the `.css` path.

**JavaScript**

JavaScript is split into two unique types.

```twig
{% set ExampleAssets = craft.papertrain.getAssetPaths(['demo-component', 'notifyjs']) %}

{% do view.registerJsFile(ExampleAssets['notifyjs'].package) %}
{% do view.registerJsFile(ExampleAssets['demo-component'].module, { "defer":"defer" }) %}
```

The `.package` path is used to register NPM package dependencies. They should always be placed before all `.module` scripts and should never be loaded using `defer` or `async`.

The `.module` script is any non-NPM packaged script, even if it's imported into the script using the ES6 import syntax. Modules should always use the `defer` attribute.

#### Writing Global Scripts

Sometimes a global script is required, such as a global environment manager class. To create a new global script do the following:

1. Create a new TypeScript file in the `utils/scripts/` directory
2. Paste in the following class shell

```javascript
export class ClassName{
    constructor()
    {
        console.log('ClassName has been instantiated');
    }

    public static doSomething()
    {
        console.log('Anything can call me at any time');
    }
}

new ClassName();
```

If you want to control when/how the class is instantiated remove the `New ClassName();` line.

3. Open the `tsconfig.json` file located in the projects primary directory
4. Add `"ClassName": ["ClassName"]` to the **paths** object

You can now use your class anywhere. To do so just add the following import to the script you're working on:

```javascript
import { ClassName } from 'ClassName';
```


## Deploying to Production

Papertrain uses server-side compiling via [Nodejs](https://nodejs.org/en/) for the CSS and JavaScript modules/packages. Follow these steps to setup the server-side compiling. If you don't want server side compiling update the `.gitignore` file by removing the `/public/assets` line. This guide will assume your server is an Ubuntu Server.

```sh
# Install webp
sudo apt-get install webp

# Install nodejs
sudo apt-get install nodejs

# Install node version manager
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash

# Install node v10.13.0
nvm install 10.13.0

# Setup post-deployment hooks/commands
<path to npm-cli.js> ci
<path to npm-cli.js> run production
```