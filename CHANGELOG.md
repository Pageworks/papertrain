## 0.1.2 - Unreleased

### Fixes

- Fixes: namespacing issue where container, wrapper, and grid classes were prefixed as `o-` (objects) when they should be `u-` (utilities)

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
