## 0.1.4 - Unreleased

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
