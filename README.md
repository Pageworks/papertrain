<p align="center">
<a href="#"><img src="https://i.imgur.com/s4wcp4b.png"/></a>
<img style="display:inline-block;" src="https://img.shields.io/badge/markup-HTML-orange.svg?style=flat-square"/>
<img style="display:inline-block;" src="https://img.shields.io/badge/style-SASS-blue.svg?style=flat-square"/>
<img style="display:inline-block;" src="https://img.shields.io/badge/typescript-3.1-yellow.svg?style=flat-square"/>
<img style="display:inline-block;" src="https://img.shields.io/badge/bundler-webpack-5299c8.svg?style=flat-square="/>
<img style="display:inline-block;" src="https://img.shields.io/badge/CMS-Craft%203-ff69b4.svg?style=flat-square"/>
<a style="display:inline-block;" href="https://github.com/AndrewK9/papertrain/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-MIT-lightgray.svg?style=flat-square"/></a>
</p>

# Papertrain - A Craft CMS Boilerplate
Papertrain is a front-end boilerplate for [Craft 3](https://craftcms.com/3) based on the boilerplates by [Pageworks](https://page.works/) and [Locomotive](https://locomotive.ca/). Includes SASS snippets from [Intuit](https://github.com/intuit) and grid system concepts by [Harry Roberts](https://csswizardry.com/2011/08/building-better-grid-systems/).

## Requirements
| Prerequisite    | How to check  | How to install                   |
| --------------- | ------------- | -------------------------------- |
| Node.js 4.1.1   | `node -v`     | [nodejs.org](https://nodejs.org) |

## Getting Started

`TODO: this`

## CSS
- Using [SASS](https://sass-lang.com/) as our CSS preprocessor
- CSS architecture based on concepts by [Harry Roberts](https://csswizardry.com/2011/08/building-better-grid-systems/)
- Minimal BEM like CSS Syntax `.block_element -modifier`
- SASS snippets from [Intuit](https://github.com/intuit)
- Using [Transparent UI Namespaces](https://csswizardry.com/2015/03/more-transparent-ui-code-with-namespaces/)
- Uisng [Bourbon](https://www.bourbon.io/) for additonal mixins for SASS utility

### SASS Import
1. __Settings:__ global variables and colour pallets.
1. __Vendors:__ bourbon mixins for base utility `@include size(x, y)`
1. __Tools:__ site wide mixins.
1. __Generic:__ low level far reaching generic element settings.
1. __Base:__ css for unclassed HTML elements `p {}, blockquote {}, ul {}` go in page.
1. __Objects:__ generic objects and object elements `.o-youtube-video`.
1. __Components:__ complete secitons of UI `.c-dca -copy`.
1. __Templates:__ css for specific template pages, used to style individual and unique elements within a page.
1. __Utilities:__ generic utility selectors, used to adjust elements in a very specific way `.u-text-center`

### Grid
Uses a inline-block gird system by [Intuit](https://github.com/intuit).

Start by inserting a `.o-layout` block and add a `.o-layout_item` element within the block. Initial blocks are `width: 100%`, additional values are avialable using `.u-1/2 .u-1/3 .u-1/4 ect...`. Additional fractions can be generated from `app/sass/tools/utilities/widths.scss`, currently using `1 2 3 4 5` values.

Create responsive elements using `@size` on the `.u-1/x` classes. If you wanted a block to start at full width but switch to 1/2 at a medium screen use `u-1/2@medium`. You can adjust the generated breakpoints in `app/sass/tools/utilities/widths.scss` by adding or removing `@include widths($widths-fractions, $size-variable-from-config, desired-@-name)`.

## JavaScript
- Uses a JavaScript modules structure. Add JavaScript modules via HTML data attributes: `data-module="example"`
- All DOM related JavaScript is hooked to `js-` prefixed classes
- jQuery is **NOT** included and should be avoided whenever possible
- [FontAwesome 5](https://fontawesome.com/) is globally included

## Page Transitions
Using [fuel-pjax](#) for page transitions.

### Usage
1. `base.twig` includes the basic pjax container/wrapper setup. When a transition is launched the new container is put the pjax wrapper and the old one is removed.
1. `BaseTransition` is launched by default. To use a custom transition:
    - Create a new class `TestTransition.js` which extends `BaseTransition`
    - Add a line in `app/scripts/transitions/transitions.js` like `export {default as TestTransition} from './TestTransition'`
    - Usage: `<a href="" data-transition="TestTransition">My Link</a>`

## Contact
Kyle Andrews |
|--------------------------------------------|
| [Email](mailto:kylea@page.works)           |
| [GitHub](https://github.com/codewithkyle)  |

## Feedback
Feel free to [open an issue](https://github.com/Pageworks/papertrain/issues).

## License
[MIT](https://github.com/Pageworks/papertrain/blob/master/LICENSE)