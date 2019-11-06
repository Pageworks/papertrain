# Papertrain for Craft CMS - v0.4

## Contents

1. [Overview](#overview)
    1. [General Workflow](#general-workflow)
    1. [Required Knowledge](#required-knowledge)
    1. [Required Software](#required-software)
1. [Tools & Libraries](#tools-and-libraries)
1. [Getting Started](#getting-started)
    - [New Project Setup](#new-project)
    - [Existing Project Setup](#existing-project)
1. [Compiling Papertrain](#compiling-papertrain)
1. [Deploying to Production](#deploying-to-production)

## Overview

Papertrain provides custom tooling to build fast, organized, and optimized websites or web applications. To learn more about the underlying ideas behind Papertrain please take a moment to read about the [JINT Methodology](https://jintmethod.dev/) and [Atomic Design Methodology](http://atomicdesign.bradfrost.com/table-of-contents/).

### General Workflow

Use the `npm run create` command to generate a `Template`, then add (custom) elements and scss to the generated files. When a custom element needs functionality (JavaScript) use the `npm run create` command to generate a `Web Component`. If the component is only used within the template, place the component directly in the templates directory, otherwise, if a component is used on several templates place it in the `templates/` directory. Use the [twig include statement](https://twig.symfony.com/doc/2.x/tags/include.html) to include the web component.

Web components **SHOULD NOT** directly communicate with one another. If several components need to react to other components changes or need to share data received from an API use the `npm run create` command to generate a `State Manager` and use the [ES Module import statement](https://v8.dev/features/modules). Web components submit information to Web Modules (also known as State Managers) and Web Modules dispatch [custom events](https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent/CustomEvent) with an instance of the updated state on the `document`. Then any web components that need to react to changes can listen for the event and react accordingly.

Please note that this is a general guide and should work for most projects. You don't have to use the `npm run create` command to create everything within the project. If you feel as if the tools provided by Papertrain are restricting your ability to complete a task or build a project feel free to ignore them. Any JavaScript or TypeScript written within the `templates/` directory will be compiled into the `public/automation/` directory, all ES Module import statements will be rewritten to match the path for the public files (`./`), all scripts (besides Web Workers) are compiled into one file for IE 11 with the import statements removed, and all scss files within the `templates/` directory are compiled into css and placed in the `public/automation/` directory. You can structure the `templates/` directory to work for your specific project and can place the scss/JavaScript/TypeScript files anywhere. If the base files used by the generator (`npm run create`) need to be modified for a project they can be found in the `build-tools/generator/files/` directory. Per the [JINT](https://jintmethod.dev/) methodology Papertrain is a malleable project framework and can be shaped to work for the project's unique/specific needs. It should never limit the developer's ability to perform their job.

### Required Knowledge

- [Craft 3 Installation](https://docs.craftcms.com/v3/installation.html)
- [ES6](https://www.ecma-international.org/ecma-262/6.0/)
- [Custom Elements](https://html.spec.whatwg.org/multipage/custom-elements.html#custom-elements)
- [Web Components](https://developer.mozilla.org/en-US/docs/Web/Web_Components)
- [HTML Content Template Element](https://html.spec.whatwg.org/multipage/scripting.html#the-template-element)
- [ES Modules](https://v8.dev/features/modules)

### Required Software

- [Node.js >=12.10.0](https://nodejs.org/en/)
- [Composer](https://getcomposer.org/download/)
- [Ubuntu LAMP stack](https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-ubuntu-18-04) or [MAMP Pro](https://www.mamp.info/en/)
- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

## Tools and Libraries

Papertrain uses the following third party tools/libraries:

- [rollup.js](https://rollupjs.org/guide/en/)
- [node-sass v4](https://github.com/sass/node-sass)
- [TypeScript v3](https://www.typescriptlang.org/docs/home.html)

*Note:* If you're having an issue with node-sass when compiling try running the rebuild command `npm rebuild node-sass`

Papertrain uses the following first party tools/libraries:

- [Device Manager v1](https://github.com/Pageworks/device-manager)

## Getting Started

Use the following guides to set up a project. Additional setup steps may be required on a project-by-project basis, speak with the project manager or team lead for additional instructions.

### New Project

1. Download the [latest release](https://github.com/Pageworks/papertrain/releases) of Papertrain
2. Extract the files into an empty project directory
3. Open your terminal and navigate to the projects root directory
4. Install the NPM dependencies by running the following command in your terminal:

```script
npm i
```

5. Install Craft CMS by running the following command in your terminal

```script
composer install
```

6. Set your Apache webserver to serve the projects `public/` directory
7. Create a new empty database for the project ([refer to craft's installation guide for database settings](https://docs.craftcms.com/v3/installation.html#step-4-create-a-database))
8. Run Papertrain's setup script by running the following command in your terminal:

```script
npm run setup
```

9. To finish the new project setup follow the Craft CMS installation guide that opens in your web browser. If your web browser doesn't automatically open navigate to the `/webmaster/install` page.
10. After Craft is installed you may need to navigate to the `/webmaster/utilities/updates` page to update Craft CMS and the default plugins.

### Existing Project

1. Clone the repository
2. Navigate your terminal into the projects root directory
3. Install the NPM packages by running the following command:

```script
npm ci
```

4. Set your Apache webserver to serve the projects `public/` directory
5. Create a new empty database for the project ([refer to craft's installation guide for database settings](https://docs.craftcms.com/v3/installation.html#step-4-create-a-database)) **OR** import the existing staging/production database
6. Setup the project by running the following command:

```script
npm run setup
```

7. If you **DID NOT** import an existing database during *Step 5* you can finish the setup by following the Craft CMS installation guide that opens in your web browser. If your web browser doesn't automatically open navigate to the `/webmaster/install` page.


## Compiling Papertrain

Papertrain uses [NPM scripts](https://docs.npmjs.com/misc/scripts) as it's primary task-runner. Below are the basic scripts that you'll need to know to work with Papertrain. You can view all scripts by opening the `package.json` file and looking at the `scripts` section.

```sh
# Compiles all CSS and JavaScript
npm run build

# Compiles all CSS and JavaScript + bundles all JavaScript for IE 11
npm run production

# Launches a browser-sync proxy allowing the project to be viewed on a LAN
npm run preview

# Uses rollupjs to convert import statements within the packages/ directory into IIFEs
npm run bundle

# Starts the code generator, used to quickly create web components, templates, state managers, or global BEM based classes
npm run create
```

## Deploying to Production

Papertrain server-side compiles CSS and JavaScript using [Nodejs](https://nodejs.org/en/). Follow these steps to setup the tools needed for server-side compiling. If you don't want server side compiling update the `.gitignore` file.

This guide will assume your server is running Ubuntu.

```sh
# Install webp
sudo apt-get install webp

# Install nodejs
sudo apt-get install nodejs

# Install node version manager
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash

# Install the current version of nodejs
nvm install 12.10.0

# Setup post-deployment hooks/commands
<path to npm-cli.js> ci
<path to npm-cli.js> run production
```