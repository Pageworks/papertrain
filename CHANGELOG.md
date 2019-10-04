## 0.3.1 - UNRELEASED

### Added

- Adds: [append](https://developer.mozilla.org/en-US/docs/Web/API/ParentNode/append#Polyfill) polyfill [#202](https://github.com/Pageworks/papertrain/issues/202)
- Adds: [Intersection Observer API](https://developer.mozilla.org/en-US/docs/Web/API/Intersection_Observer_API) polyfill ([source](https://github.com/w3c/IntersectionObserver/blob/master/polyfill/intersection-observer.js)) [#203](https://github.com/Pageworks/papertrain/issues/203)
- Adds: when Web Components are connected they fire a `component-mounted` event on the `document` [#204](https://github.com/Pageworks/papertrain/issues/204)
- Adds: [Custom Event API](https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent) polyfill ([source](https://github.com/kumarharsh/custom-event-polyfill/blob/master/polyfill.js))
- Adds: adds link to the [Web Components Library](https://components.papertrain.io/) in the `readme.md` file

### Fixed

- Fixes: broken Papertrain v0.3 documentation link [#199](https://github.com/Pageworks/papertrain/issues/199)
- Fixes: updates v0.3 documentation to require nodejs [v12.10.0](https://nodejs.org/download/release/latest-v12.x/)

## 0.3.0 - 2019-09-14

### Fixed

- Fixes: regex patterns only removes the `.css` or `.js` from the end of the filenames when fetching files

### Removed

- Removes: twigjs
- Removes: Template Manager web component

### Fixed

- Fixes: updates v0.3 documentation
- Fixes: runtime application trims `.js` and `.css` file extensions from the requested filename strings
- Fixes: papertrain module no longer sets the file extensions
- Fixes: `npm run compile` command is an alias for `npm run build`

## 0.3.0-a4 - 2019-09-05

### Added

- Adds: TypeScript watcher & web component script injector for browser sync usage
- Adds: async/await to the stylesheet fetching logic
- Adds: joining an existing project setup guide to the v0.3 documentation
- Adds: [Twig.js](https://github.com/twigjs/twig.js) JavaScript library ([twig.js example](https://github.com/codewithkyle/twigjs-prototype))
- Adds: `ajax/` directory to `public/` as a place to store Twig snippets for Twig.js
- Adds: `public/assets/libraries/` directory to store 3rd party libraries
- Adds: new library fetching step the the runtime `getScripts()` method
- Adds: new libraries loaded callback method to the runtime
- Adds: upgrades to Craft 3.3
- Adds: new Polyfill Hacks & Workarounds script to the `global-javascript.twig` file due to Safari and Edge limitations

### Fixed

- Fixes: removes `$elevation-3` through `$elevation-5` from `_config.scss`
- Fixes: reduces the drop shadow on `$elevation-1` and `$elevation-2`
- Fixes: regex file name parsing in the SASS compiler
- Fixes: hooks up `npm run dev` script to the new compilers & custom bundlers
- Fixes: upgrades templates from classes to IDs since there will only ever be 1 instance of a template (page) within the document
- Fixes: upgraded sass watcher's speed and performance
- Fixes: service worker is disabled on `.local` domains or when the `window.location.hostname` is `localhost`
- Fixes: switched the `|raw` twig filter back to exporting a the raw TemplateHelper response, easier to use and `|raw` didn't provide any performance advantages
- Fixes: adds `customElements` polyfill to Edge
- Fixes: runtime ignores library fetching methods on Safari due to fetch/ajax file size limit of 512kb

## 0.3.0-a3 - 2019-08-27

### Added

- Adds: updates the Getting Started > New Project guide
- Adds: `dataModel` variable to templates
- Adds: service worker for custom `.js` and `.css` caching
- Adds: new `criticalCss` array and loading animation
- Adds: new `reset.scss` file to the `sass/` directory
- Adds: `@pageworks/device-manager` package is now a default package
- Adds: initial `noscript` style
- Adds: basic sitemap navigation for users with JavaScript disabled
- Adds: `base.scss` and `page.scss` to the `_layouts/` directory

### Fixed

- Fixes: `npm run setup` now calls `npm run build` before guiding the user through the setup process
- Fixes: updates Craft CMS to v3.2
- Fixes: updates boilerplate plugins
- Fixes: removes `echo` from Papertrain services, instead returns a `string`
- Fixes: updates runtime class to provide callbacks after all scripts/stylesheets have finished loading
- Fixes: updates tslint to handle both sets of typescript (templates and web_modules)
- Fixes: runtime web component conflicts with NPM packages
- Fixes: updates default template and component files to use the `|raw` twig filter
- Fixes: web component are generated into hidden directories
- Fixes: renames `_globals/` to `_global-stylesheets/`

### Removed

- Removes: reset CSS from the documents head
- Removes: empty `_components/` directory
- Removes: `sass/_base/` directory and files
- Removes: `uuid/v4` is no longer generated as a package by default, it is still installed as a dependency

## 0.3.0-a2 - 2019-08-21

### Added

- Adds: Papertrain v0.3 documentation
- Adds: `cleanup.config.js` build tool, cachebust timestamp and automated directories are only removed when all compilers/bundlers run successfully

### Fixed

- Fixes: added v0.3 draft documentation link & updates shields in `readme.md`
- Fixes: generated web components will always end with `-component`

### Removed

- Removes: `cross-env` dependency

## 0.3.0-a1 - 2019-08-20

### Added

- Adds: moves `utils/styles/` to `scss-settings/`
- Adds: moves `_lib/globals/` to `_globals/`
- Adds: `web_modules/` directory, used for global state manager classes
- Adds: new Runtime class to handle lazy loading cache busted CSS, packages, modules, and web components
- Adds: [rollup.js](https://rollupjs.org/guide/en/) [#189](https://github.com/Pageworks/papertrain/issues/189)
- Adds: new web modules bundler
- Adds: new node modules bundler
- Adds: web component bundler
- Adds: custom elements polyfill from the [Polymer Project](https://www.polymer-project.org/)
- Adds: legacy bundler for creating our single `main.js` file for IE 11 and other non-es2015 compatible browsers
- Adds: new **Web Component** type to the generator
- Adds: initial v0.3 documentation rough draft

### Fixed

- Fixes: moved dependencies to their proper section within `package.json`
- Fixes: updates base font stack to prefer native OS font stack
- Fixes: updates reset CSS in `base.twig`
- Fixes: moves Env class to `web_modules/` and adds initial DOM state values
- Fixes: updates document title to use product name on commerce sites OR just the static site name when no entry/category/product is available
- Fixes: updates SASS compiler script to provide better error reporting
- Fixes: updates the generators core functionality [#190](https://github.com/Pageworks/papertrain/issues/190)
- Fixes: updates npm scripts to use new bundlers & TypeScript compiler config files

### Removed

- Removes: `@pageworks/state-mananger` dependency
- Removes: `@pageworks/pjax` dependency
- Removes: `webpack` dependency
- Removes: `utils/` directory
- Removes: `_lib/` directory
- Removes: `.g-wrapper` and `.g-grid` global classes
- Removes: empty `_svgs/` directory
- Removes: empty `_macros/` directory
- Removes: empty `ajax/` directory
- Removes: **components** and **objects** from the generator

## 0.2.5 - 2019-08-16

### Fixed

- Fixes: updates documentation links to use the blobs from master, not develop
- Fixes: removes typography generator SCSS & heading mixins

### Removed

- Removes: `_typography.scss` from `utils/styles/tools/`

## 0.2.4 - 2019-08-02

### Added

- Adds: updated project setup section of the readme
- Adds: updated IE 11 polyfills to use `nomodule` attribute instead of wrapping the `document.write()` method in a render blocking script
- Adds: papertrain v0.1 documentation
- Adds: papertrain v0.2 documentation
- Adds: contributing guidelines document [#186](https://github.com/Pageworks/papertrain/issues/186)

### Fixed

- Fixes: corrects the release date year for the v0.2.x releases

## 0.2.3 - 2019-07-25

### Added

- Adds: SASS watcher build tool [#184](https://github.com/Pageworks/papertrain/pull/184)

## 0.2.2 - 2019-06-21

### Added

- Adds: reset CSS to `base.twig` `<head>` [#181](https://github.com/Pageworks/papertrain/issues/181)
- Adds: `page.twig` layout for templates
- Adds: `public/automation/` directory due to gitignore issues with the assets directory [#180](https://github.com/Pageworks/papertrain/issues/180)
- Adds: `.editorconfig` file to `.gitignore`

### Fixed

- Fixes: updates Craft CMS to latest version
- Fixes: sets min-height to `100vh`
- Fixes: removes default padding from `<main>`

### Removed

- Removes: `.editorconfig` file

## 0.2.1 - 2019-06-17

### Added

- Adds: better NPM package code splitting for Webpack [#177](https://github.com/Pageworks/papertrain/issues/177)
- Adds: adds base path config to the generator script [#176](https://github.com/Pageworks/papertrain/issues/176)
- Adds: the `beforeDestroy()` method returns a promise and doesn't remove the Node until the promise resolves [#175](https://github.com/Pageworks/papertrain/issues/175)

### Fixed

- Fixes: the default element normalization only effects elements within the custom `<page-view>` element

## 0.2.0 - 2019-06-10

### Added

- Adds: Developers name input to the startup questionnaire [#167](https://github.com/Pageworks/papertrain/issues/167)
- Adds: [Preparse](https://github.com/aelvan/Preparse-Field-Craft) plugin to the boilerplate[#169](https://github.com/Pageworks/papertrain/issues/169)
- Adds: basic Imager config to the `/config` directory [#168](https://github.com/Pageworks/papertrain/issues/168)
- Adds: Papertrain module and `craft.papertrain.getAssetPaths()` variable [#170](https://github.com/Pageworks/papertrain/issues/170)
- Adds: server-side compiling [#171](https://github.com/Pageworks/papertrain/issues/171)
- Adds: Moves Env class instantiation to the Application class
- Adds: Added a public static `Env.startLoading()` and `Env.stopLoading()` class to triggering the loading animation
- Adds: new generator script [#172](https://github.com/Pageworks/papertrain/issues/172)
- Adds: updates the readme [#166](https://github.com/Pageworks/papertrain/issues/166)

### Fixed

- Fixes: `.gitignore` file wasn't remove the leading `/` from the vendor directory line
- Fixes: removes the Pjax class instantiation due incomplete Application class methods

### Removed

- Removes: `cc-installer.sh` script

## 0.1.4 - 2019-06-05

### Added

- Adds: IE 11 (only) polyfill scripts [#163](https://github.com/Pageworks/papertrain/issues/163)
- Adds: global "This site requires JavaScript" notice [#162](https://github.com/Pageworks/papertrain/issues/162)

### Fixed

- Fixes: changelog heading sizes
- Fixes: `normalize.scss` line heights and inline elements display values [#158](https://github.com/Pageworks/papertrain/issues/158)
- Fixes: input border radius defaults to `0px` [#156](https://github.com/Pageworks/papertrain/issues/156)
- Fixes: relocates the global JavaScript & CSS [#161](https://github.com/Pageworks/papertrain/issues/161)

## 0.1.3.3 - 2019-05-14

### Fixed

- Fixes: setup test email address validation bug

## 0.1.3.2 - 2019-05-14

### Added

- Adds: setup script requires the developers email address and sets it as the `testToEmailAddress` in `general.php`

### Fixed

- Fixes: outstanding merge conflict issue from the previous release

## 0.1.3.1 - 2019-05-14

### Added

- Adds: notice, warning, success, and error pallet variables

### Fixed

- Fixes: `<main>` display broke after fixing `<style>` script

## 0.1.3 - 2019-05-14

### Added

- Adds: new grey pallet along with warm grey, cool grey, blue grey, primary, and secondary pallets [#152](https://github.com/Pageworks/papertrain/issues/152)
- Adds: `-raised` modifier class to the `g-button` global
- Adds: `-rounded` modifier class to the `g-button` global
- Adds: elevation variables to the `config.scss` file
- Adds: [SEO](https://github.com/ethercreative/seo/blob/v3/README.md) plugin
- Adds: initial Homepage single and template

### Fixed

- Fixes: solid buttons line height appearing unaligned next to an outline button [#151](https://github.com/Pageworks/papertrain/issues/151)
- Fixes: `page.scss` styles
- Fixes: `normalize.scss` breaking `script` and `style` elements
- Fixes: updates Craft

## 0.1.2 - 2019-05-12

### Adds

- Adds: global heading class [#145](https://github.com/Pageworks/papertrain/issues/145)
- Adds: global button class [#144](https://github.com/Pageworks/papertrain/issues/144)

### Fixed

- Fixes: namespacing issue where container, wrapper, and grid classes were prefixed as `o-` (objects) when they should be `u-` (utilities)
- Fixes: `-base-background` is now `-white-background`
- Fixes: `-secondary-background` is now `-snow-background`
- Fixes: moves gutter and container unit configs into `settings/_units.scss`
- Fixes: normalizes all elements to use `position: relative;`
- Fixes: switches base sans-serif font to Roboto and serif font to Roboto Slab, moves Circular to the fallback font
- Fixes: moves containers, grids, and wrapper to the `/globals` directory [#150](https://github.com/Pageworks/papertrain/issues/150)
- Fixes: uses regex to replace spaces to `-` when generating files [#143](https://github.com/Pageworks/papertrain/issues/143)
- Fixes: switches `siteUrl` to `alias('@rootUrl')`
- Fixes: TypeScript compiling excludes [#149](https://github.com/Pageworks/papertrain/issues/149)
- Fixes: Non-Chrome script order [#148](https://github.com/Pageworks/papertrain/issues/148)
- Fixes: stylelint rules [#147](https://github.com/Pageworks/papertrain/issues/147)
- Fixes: changes `single` to `template` in the generator

### Removed

- Removes: `u-clearfix` mixin
- Removes: `u-truncate` mixin

## 0.1.1 - 2019-05-01

### Fixes

- Fixes: generator generates singles into their own public directory within `/templates`
- Fixes: singles `.twig` file has been renamed to `index.twig`
- Fixes: missing `data-module` attribute on singles
- Fixes: sass compiler now compiles all SCSS files within the `/templates` directory
- Fixes: issue calling undefined variable on `entry` or `category`

### Removes

- Removes: `templates/_singles` directory

## 0.1.0 - 2019-04-30

### Adds

- Adds: `pjax.twig` layout that requires `craft.app.request.isPjax`
- Adds: `/templates/utils` directory
- Adds: `/templates/lib` directory for storing Objects, Components, and Globals
- Adds: CLI based object, component, single, and global generator `npm run create`
- Adds: global `utils` directory for storing global scripts & SCSS files
- Adds: custom setup script (`npm run setup`) for cleaning up unneeded Papertrain files, directories, and generating the `.env` file

### Fixes

- Fixes: `ajax.twig` layout requires `craft.app.request.isAjax`
- Fixes: updates the base 404 page
- Fixes: cleans up the base homepage
- Fixes: webpack config
- Fixes: typescript config
- Fixes: updates `base.twig` layout
- Fixes: switches from [@codewithkyle](http://codewithkyle.com) dependencies to [@pageworks](https://github.com/Pageworks)

### Removes

- Removes: base complex content layout & blocks
- Removes: initial SVGs
- Removes: form macros
- Removes: `/app` directory
