<p align="center">
<a href="http://papertrain.io"><img alt="Papertrain" src="_papertrain/logo.png"/></a><br/>
<img style="display:inline-block;" src="https://img.shields.io/badge/markup-HTML-orange.svg?style=flat-square"/>
<img style="display:inline-block;" src="https://img.shields.io/badge/style-SASS-blue.svg?style=flat-square"/>
<img style="display:inline-block;" src="https://img.shields.io/badge/typescript-3.2-yellow.svg?style=flat-square"/>
<img style="display:inline-block;" src="https://img.shields.io/badge/bundler-webpack-5299c8.svg?style=flat-square"/>
<img style="display:inline-block;" src="https://img.shields.io/badge/CMS-Craft%203.1-ff69b4.svg?style=flat-square"/>
<a style="display:inline-block;" href="https://github.com/AndrewK9/papertrain/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-MIT-lightgray.svg?style=flat-square"/></a>
</p>

# Papertrain
Papertrain helps developers build amazing user experiences by providing a frontend framework with the primary focus being the end user. Whether you're developing websites or web-based applications Papertrain helps the development process by using modern technologies such as [Webpack](https://webpack.js.org/) and [TypeScript](https://www.typescriptlang.org/) along with providing an [atomic design](http://bradfrost.com/blog/post/atomic-web-design/) based framework. Papertrain is an [open source project](https://github.com/Pageworks/papertrain) and was inspired by [Locomotive](https://locomotive.ca/en). It's built upon open source snippets & concepts from [Material.io](https://material.io/), [Harry Roberts](https://csswizardry.com/2011/08/building-better-grid-systems/), [Brad Frost](http://bradfrost.com/), and [Intuit](https://github.com/intuit). The primary benefit to developers is that Papertrain provides simple & malleable utilities to help handle some of the micro-interactions that transform average products into amazing ones. Learn more about the project or how to get started at [papertrain.io/getting-started](http://papertrain.io/getting-started).

# Goals
#### User Focused
Create a framework that handles the minor utilities needed for providing a better experience by transitioning traditional afterthought design decisions to forethoughts.

#### Unify
Provide a basic and simple structure for naming elements and writing scripts with a focus on limiting friction during collaborative projects.

#### Inspire
Provide a flexible foundation that inspires developers to create, innovate, and share.

# Principles
#### Motion Provides Meaning
Motion focuses attention and maintains continuity, through subtle feedback and coherent transitions. As elements appear on screen, they transform and reorganize the environment, with interactions generating new transformations.

#### Cross-Platform
Projects should be optimized for the best user experience across all platforms. The basic product should maintain the design and feel of the target platform, however, the user interactions, content, and motion should change to work best for the active platform.

# CSS
- Using [SASS](https://sass-lang.com/) as the CSS preprocessor
- CSS architecture based on concepts by [Harry Roberts](https://csswizardry.com/2011/08/building-better-grid-systems/)
- Minimal BEM like CSS Syntax `.o-object -modifier`
- SASS snippets from [Intuit](https://github.com/intuit)
- Using [Transparent UI Namespaces](https://csswizardry.com/2015/03/more-transparent-ui-code-with-namespaces/)

## Grid System
Uses a inline-flex gird system based on the inline-block system by [Intuit](https://github.com/intuit). See how we've implemented their grid system concept at the Papertrains [grid documentation](http://papertrain.io/components/grid).

# Typescirpt
- Uses a Typescript module structure.
- Modules instantiated via HTML attributes: `data-module="ModuleName SecondModule"`
- All DOM related JavaScript is hooked to `js-` prefixed classes
- jQuery is **NOT** included and should be avoided whenever possible

# Page Transitions
Using [fuel-pjax](https://github.com/Pageworks/fuel-pjax) for page transitions and link prefetching Build custom page transitions with the Transition Manager class.

# Feedback
Feel free to [open an issue](https://github.com/Pageworks/papertrain/issues).

# License
[MIT](https://github.com/Pageworks/papertrain/blob/master/LICENSE)
