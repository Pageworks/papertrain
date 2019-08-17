## 0.3 - UNRELEASED

### Added

- Adds: moves `utils/styles/` to `scss-settings/`

### Fixed

- Fixes: moved dependencies to their proper section within `package.json`
- Fixes: updates base font stack to prefer native OS font stack
- Fixes: updates reset CSS in `base.twig`

### Removed

- Removes: `@pageworks/state-mananger` dependency
- Removes: `@pageworks/pjax` dependency
- Removes: `utils/` directory

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
