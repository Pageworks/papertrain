# Papertrain for Craft 3 - v0.3

## Contents

1. [Requirements](#requirements)
    - [Required Knowledge](#required-knowledge)
    - [Required Software](#required-software)
1. [Tools & Libraries](#tools-and-libraries)
1. [Getting Started](#getting-started)

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

### New Project

1. Start by downloading the [latest release](https://github.com/Pageworks/papertrain/releases) of Papertrain and extracting the files into your projects root directory
2. Open your terminal and navigate to the projects root directory
3. Install the NPM dependencies by running the following command in your terminal

```script
npm install
```

4. Install Craft CMS by running the following command in your terminal

```script
composer install
```

5. Set your Apache server to point to the projects `public/` directory
6. Create a new empty database for the project
7. Run the setup script by running the following command in your terminal

```script
npm run setup
```

8. To finish the new project setup follow the Craft CMS installation guide that opens in your web browser. If your web browser doesn't automatically open navigate to the `/webmaster/install` page.
9. After Craft is installed you may need to navigate to the `/webmaster/utilities/updates` page to update Craft and the boilerplate plugins.

