# Unreleased Changes

### Adds

- Adds: `data-module` attribute can now create multiple modules from one attribute [#107](https://github.com/Pageworks/papertrain/issues/107)
- Adds: `data-csrf` attribute has been added the the `html` document for a non-cached global use of users CSRF token provided by Craft
- Adds: updates `fuel-pjax` to use `@codewithkyle/fuel-pjax` [#97](https://github.com/Pageworks/papertrain/issues/97)
- Adds: updates `animejs` to version 3 [#104](https://github.com/Pageworks/papertrain/issues/104)
- Adds: custom Freeform template [#73](https://github.com/Pageworks/papertrain/issues/73)
- Adds: new Freeform Complex Content block
- Adds: better form input margin control [#94](https://github.com/Pageworks/papertrain/issues/94)
- Adds: generic field inputs to Craft [#109](https://github.com/Pageworks/papertrain/issues/109)
- Adds: new column split option to CC copy block [#110](https://github.com/Pageworks/papertrain/issues/110)
- Adds: Spoon plugin and updates Complex Content layout [#112](https://github.com/Pageworks/papertrain/issues/112)
- Adds: Relabel plugin [#99](https://github.com/Pageworks/papertrain/issues/99)
- Adds: `dom-is-animated` status class with custom timer input [#100](https://github.com/Pageworks/papertrain/issues/100)
- Adds: normalzied all basic raw HTML elements [#103](https://github.com/Pageworks/papertrain/issues/103)
- Adds: 404 page uses custom single and Complex Content builder
- Adds: chrome viewport height fix [#87](https://github.com/Pageworks/papertrain/issues/87)
- Adds: application now tracks touch elements for custom `has-touch` status class [#84](https://github.com/Pageworks/papertrain/issues/84)
- Adds: `main.css` is always cached busted [#75](https://github.com/Pageworks/papertrain/issues/75)
- Adds: updated npm scripts and new dev/production build process
- Adds: adds custom browser-sync script to reload after webpack bundle/scss compile or when a twig file changes
- Adds: Updates base login account information [#114](https://github.com/Pageworks/papertrain/issues/114)
- Adds: heading block supports the generation of page jump links [#118](https://github.com/Pageworks/papertrain/issues/118)

### Fixes

- Fixes: flips auto generated page titles [#91](https://github.com/Pageworks/papertrain/issues/91)
- Fixes: module names switched from `private` to `public` [#86](https://github.com/Pageworks/papertrain/issues/86)
- Fixes: `getTemplateName` method in `TransitionManager` [#90](https://github.com/Pageworks/papertrain/issues/90)
- Fixes: moves `/vendor` in the `.gitignore` file to the top of the file so it's easier to find [#89](https://github.com/Pageworks/papertrain/issues/89)
- Fixes: updates base scripts [#102](https://github.com/Pageworks/papertrain/issues/102)
- Fixes: removes webkit highlight colour [#85](https://github.com/Pageworks/papertrain/issues/85)
- Fixes: form macro input values have been re-structured [#94](https://github.com/Pageworks/papertrain/issues/94)
- Fixes: all `easing` inputs for `animejs` have been updated to use the new format [#104](https://github.com/Pageworks/papertrain/issues/104)
- Fixes: the gallery block has been updated to use the new `animejs` format [#104](https://github.com/Pageworks/papertrain/issues/104)
- Fixes: normalizes button element and removes button element from custom button styles [#98](https://github.com/Pageworks/papertrain/issues/98)
- Fixes: normalized list elements except within copy block [#101](https://github.com/Pageworks/papertrain/issues/101)
- Fixes: cleans up container objects and reworks layout for both the complex content grid and general layout object use [#115](https://github.com/Pageworks/papertrain/issues/115)

### Removes

- Removes: `@types/animejs` npm package
- Removes: `webpack-dev-server` npm package and script

# 1.0.3 - 2019-01-10

### Fixes

- Fixes: Incorrect database dump file

# 1.0.2 - 2019-01-09

### Adds

- Adds: Adds polyfill include to fix `Array.from()` for IE 11
- Adds: Adds `pt_` table prefix

### Fixes:

- Fixes: Fixes application for IE 11
- Fixes: Cleans up all typescript files

### Removes

- Removes: Removes site name override so we can support clean craft installs.

# 1.0.1 - 2019-01-04

### Adds

- Adds: Predefined easing JSON object that uses the custom easing values defined in `config.scss`[#77](https://github.com/Pageworks/papertrain/issues/77)
- Adds: Scroll status tracking class to `html` [#76](https://github.com/Pageworks/papertrain/issues/76)
- Adds: Custom open source font [#76](https://github.com/Pageworks/papertrain/issues/67)
- Adds: Montserrat as a backup base font if the custom font fails to load [#76](https://github.com/Pageworks/papertrain/issues/67)

### Fixes

- Fixes: Heading elements were not using generated values from `typography.scss` [#70](https://github.com/Pageworks/papertrain/issues/70)
- Fixes: Tables were not using borders and hover colours based on section background colours [#72](https://github.com/Pageworks/papertrain/issues/72)

### Removes
- Removes: `svgo` dependency and lint script
- Removes: Custom link color and style variables from the `config.scss` and `colors.scss` files [#68](https://github.com/Pageworks/papertrain/issues/68)
- Removes: Uploaded demo assets [#71](https://github.com/Pageworks/papertrain/issues/71)
- Removes: Demo entries from the Standard Pages section [#69](https://github.com/Pageworks/papertrain/issues/69)
- Removes: Roboto as a base font [#76](https://github.com/Pageworks/papertrain/issues/67)

# 1.0.0 - 2018-12-24

### Adds
- Adds: Initial project welcome message and success page
- Fixes: Buttons padding and margins use `$unit` as base sizes
- Fixes: Moves `<a>` element base style within a `<p>` element
- Fixes: Normalized base `<a>` element
- Fixes: Updates viewport `<meta>` for a better user experience
- Fixes: Updates npm modules

---

# 0.1.2-beta - 2018-12-22

### Adds
- Adds: Basic lowercase text transform utility class
- Adds: Form input `-square` so input types can be both round an square
- Adds: `animejs` is now imported via NPM
- Adds: New navigation breakpoint variable to the config file
- Adds: Custom Pageworks developer easter egg to production sites
- Adds: Base heading sizes are generated based on the golden ratio
- Adds: Added `dotenv`
- Adds: Developers can now set their development websites URL in the `.env` file to prevent namespace issues between contributors
- Adds: Live debug tool. Admins when logged in can add `&debug=true` to a production website to view console logs
- Adds: New `hover` and `active` mixins that only apply styles when the devince is **NOT** a touch device [Issue #47](https://github.com/Pageworks/papertrain/issues/47)
- Adds: `$primary` and `$secondary` now have alt colours that will be used on dark backgrounds
- Adds: Icons that have opacity based hover effects (such as buttons) use opacity values set in the config file
- Adds: `async` attribute to scripts to help with load times
- Adds: New logo

### Fixes
- Fixes: Updated readme
- Fixes: Updated TypeScript classes to follow proper namespace and style standards
- Fixes: Updated the basic buttons to look better and added an `-alt` style to the basic `-outline` style button
- Fixes: Added the default icon hover effect to the password and pin input icons
- Fixes: Unique input styles (radio, checkboxes, switches) have been moved outside the `form` element
- Fixes: The loading bar line is now hidden by default since OSX allows users to overscroll on Chrome
- Fixes: Heading elements are normalized and custom heading styles are assigned to classes for better SEO
- Fixes: Base unit sizes are based on `rem` values instead of pixels and the base size has been doubled
- Fixes: Updated how gutters are generated and used to be less confusing [Issue #41](https://github.com/Pageworks/papertrain/issues/41)
- Fixes: Fixed a bug with `initModules` [Issue #44](https://github.com/Pageworks/papertrain/issues/44)
- Fixes: Updates to the newest version of `fuel-pjax`
- Fixes: Font imports have been moved from `base.twig` to an `@import` in the config file
- Fixes: The base grid system now uses flexbox by default instead of inline blocks
- Fixes: Updates the webpack compile files to use the best CSS, PostCSS and SASS loader settings

### Removes
- Removes: `u-hocus` and `u-actus` mixins

---

#  0.1.1-beta - 2018-11-09

### Adds
- Adds: contrast SASS function
- Adds: `isInView` utility function for tracking if elemenets are within the viewport

### Fixes
- Fixes: Headings use contrast function
- Fixes: Project now uses `rem` instead of `px`, `$unit` size is still the same
- Removes: Bourbon, keeps the 4 mixins that are actually used, see [Issue #27](https://github.com/Pageworks/papertrain/issues/27)

---

#  0.1.0-beta - 2018-11-09

### Adds
- Adds: Webpack
- Adds: TypeScript
- Adds: Custom flavor of Pjax

### Fixes
- Fixes: Updates to newest version of `node-sass`
- Fixes: Reworks JavaScript Architecture to work with TypeScript
- Fixes: Reworks transition manager to use promises instead of callbacks
- Fixes: Cleans SASS files, removes unused utilities
- Fixes: Reworks example page for easier onboarding
