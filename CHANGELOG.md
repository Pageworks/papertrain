#  0.1.1-beta - 2018-11-09

- Adds: contrast SASS function
- Adds: `isInView` utility function for tracking if elemenets are within the viewport
- Fixes: Headings use contrast function
- Fixes: Project now uses `rem` instead of `px`, `$unit` size is still the same
- Removes: Bourbon, keeps the 4 mixins that are actually used, see [Issue #27](https://github.com/Pageworks/papertrain/issues/27)

#  0.1.0-beta - 2018-11-09

- Adds: Webpack
- Adds: TypeScript
- Adds: Custom flavor of Pjax
- Fixes: Updates to newest version of `node-sass`
- Fixes: Reworks JavaScript Architecture to work with TypeScript
- Fixes: Reworks transition manager to use promises instead of callbacks
- Fixes: Cleans SASS files, removes unused utilities
- Fixes: Reworks example page for easier onboarding