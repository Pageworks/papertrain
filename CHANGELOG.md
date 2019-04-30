## 0.1.0

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

- Removes: base complex content directory
- Removes: initial form SVGs
- Removes: base form macros
- Removes: app directory
