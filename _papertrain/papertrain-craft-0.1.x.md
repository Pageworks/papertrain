# Papertrain for Craft 3 - v0.1.x

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

1. Create a new empty directory for the project

2. [Download the latest v0.1 release from GitHub](https://github.com/Pageworks/papertrain/releases/tag/v0.1.4).

3. Unzip the download and move the files into your empty project directory

4. Via your terminal CD into the project directory

5. Run the following command in your terminal to cleanup the unnecessary project files 

```
rm README.md CHANGELOG.md LICENSE && rm -rf _papertrain
```

6. Install NPM packages using the following command

```
npm i
```

7. Fix any package vulnerabilities with the following command

```
npm audit fix && npm run dev
```

8. Install vendor packages using the following command

```
composer install
```

9. Remove the `/vendor` directory from the `.gitignore` file

10. Point your Apache server to use the `index.php` file located in the `public/` directory

11. Create a new database for the project based on the [see Craft 3 guide for details](https://docs.craftcms.com/v3/installation.html#step-4-create-a-database)

12. Clone the `.env.example` file using the following command

```
cp .env.example .env
```

13. Open the `.env` file and enter all relevant environment information

14. In a browser navigate to your sites `/webmaster` page

15. Install Craft CMS

- Use `web@page.works` for the email address
- Generate a secure password using dashlane

16. Navigate to the `/webmaster/utilities/updates` page and update Craft CMS and all base plugins

17. Edit the `templates/_layotus/base.twig` file by replacing `{% inlucde "_layouts/global-css.twig" %}` with `{% include "_layouts/global-css.twig" %}`

18. Init the project using the following command

```
git init
```

19. Set the remote for the project

```
git remote add origin <URL>
```

20. Create the initial commit

```
git add . && git commit -m "Initial Papertrain install"
```

21. Push the master branch up to the repository

```
git push -u origin master
```

### Existing Project

1. Clone the project by running the following command in your terminal

```
git clone <URL>
```

2. CD into the cloned project directory

```
cd <DIRECTORY>
```

3. Install the NPM packages using NPMs continuous integration installation command

```
npm ci && npm run dev
```

4. Point your Apache server to use the `index.php` file located in the `public/` directory

5. Create a new database for the project based on the [see Craft 3 guide for details](https://docs.craftcms.com/v3/installation.html#step-4-create-a-database)

6. Download the existing projects database from the `/webmaster/utilities/db-backup` page found on the staging or productions websites control panel

7. Import the database into your empty local database

8. Clone the `.env.example` file using the following command

```
cp .env.example .env
```

9. Open the `.env` file and enter all relevant environment information

10. Request access to the following information in Dashlane

- Saved password
- Secure note

11. Open DropSync 3 and create a new Folder Pair, do the following

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

12. Open your web browser and navigate to  the `/webmaster` page

13. Log in using the email and password pair found in Dashlane

## Working With Papertrain

### Tools & Libraries

v0.1.x uses the following 3rd party tools/libraries:

- [Webpack v4](https://webpack.js.org/configuration/)
- [node-sass v4](https://github.com/sass/node-sass)
- [TypeScript v3](https://www.typescriptlang.org/docs/home.html)

v0.1.x uses the following first party tools/libraries:

- [Pjax v2](https://github.com/Pageworks/pjax)
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

Be sure to run this command before deploying any CSS or JavaScript changes.

#### Design and Development

**JavaScript Framework**

Papertrain uses a [Modular Design Pattern](https://github.com/Pageworks/modular-design-pattern) in an attempt to codify Brad Frost's [Atomic Design methodology](http://bradfrost.com/blog/post/atomic-web-design/). The primary use of this patten is to manage an infinite amount of interchangeable components that can each individually communicate with an infinite amount of business-logic controllers.

[Checkout this example](https://github.com/codewithkyle/modular-design-pattern-javascript-example) of how we've converted this pattern to work for JavaScript. A live demo showcasing how components can be used together is [available here](https://codewithkyle.github.io/modular-design-pattern-javascript-example/).

**Complex Content**

Complex Content is a structure that defines the layout and grouping of sections, containers, and blocks. [Checkout this example](https://pageworks.github.io/complex-content/) to see how pages are constructed. [Click here](https://github.com/Pageworks/complex-content#structure) to learn more about the basic structure of Complex Content.

In Craft 3 Complex Content is a [matrix field type](https://docs.craftcms.com/v3/matrix-fields.html) and is used as a substitute page builder.

**Atomic Design**

The goal of Atomic Design is to break templates into components that can be broken into objects that can be sometimes broken down into globals. By doing this we can craft small, reuseable, elements and code snippets that can be reused throughout the site or on other projects.

#### Your First Template

This section will detail the process of adding a new template to the project. We will generate a template, a component.

1. Run the following command to generate the template

```
npm run create
```

2. Use your arrow keys to select **template** from the list
3. Name the template **demo**
4. Provide the "no" value `n` for the TypeScript question

At this point your new template has been created and available at `templates/demo/`. If your site is running you can checkout the template by opening a browser and navigating to the `/demo` page.

5. Create a component by running the following command in your terminal

```
npm run create
```

6. Use your arrow keys to select **component** from the list
7. Name the component **demo component**
    - Note that underscores and hyphens are not allowed, they will be generated for you

You can checkout your new component at the `templates/_lib/components/` directory.

8. Open the `templates/demo/index.twig` file
9. In the `<section>` element include your component using Twigs [include statement](https://twig.symfony.com/doc/2.x/tags/include.html) `{% include "_lib/components/demo-component/demo-component.twig" %}`

10. Open the `templates/_lib/components/demo-component/demo-component.ts` file
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

Each JavaScript and CSS file is generated as it's own general file. To use a file on a page it must be registered.

**CSS**

```twig
{% do view.registerCssFile(alias('@rootUrl')|trim('/') ~ '/assets/styles/demo-component.' ~ craft.app.config.general.cssCacheBustTimestamp ~ '.css') %}
```

For CSS file registration replace the `demo-component` section with the name of the CSS file.

**JavaScript**

```twig
{% do view.registerJsFile(alias('@rootUrl')|trim('/') ~ '/assets/scripts/demo-component.' ~ craft.app.config.general.jsCacheBustTimestamp ~ '.js', { "async":"async" }) %}
```

For JavaScript file registration replace the `demo-component` section with the name of the JavaScript file. `async` is the preferred method for loading JavaScript files.

If you need to register a global script (something from the `utils/scripts/` directory) or an NPM package that is imported use the following registration statement:

```twig
{% do view.registerJsFile(alias('@rootUrl')|trim('/') ~ '/assets/scripts/npm.package-name.' ~ craft.app.config.general.jsCacheBustTimestamp ~ '.js') %}
```

Since global scripts and NPM packages are usually dependencies of your script they are not required to be `async` or `defer` loaded. If you're unsure of how Webpack bundled your dependency check the `public/scripts/` directory for your file. If a NPM package was scoped under an organization (`@pageworks`) the bundle name will be the organization name and not the individual package.

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