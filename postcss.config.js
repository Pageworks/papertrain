/* eslint-disable */
const autoprefixer = require('autoprefixer');
const cssnano = require('cssnano');

module.exports = {
  plugins: [
    autoprefixer( {browsers: ['last 3 iOS versions', 'last 3 versions', 'ie >= 9']} ),
    cssnano({ preset: 'default' })
  ]
};