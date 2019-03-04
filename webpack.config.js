const FriendlyErrorsWebpackPlugin = require('friendly-errors-webpack-plugin');
const path = require('path');

module.exports = {
    mode:  process.env.NODE_ENV === 'production' ? "production" : "development",
    optimization: {
        removeAvailableModules: false,
        removeEmptyChunks: false
    },
    resolve: {
        extensions: ['.js']
    },
    entry: './_compiled/App.js',
    output: {
        path: path.resolve(__dirname, "public/assets/scripts"),
        filename: 'app.js',
        pathinfo: false
    },
    plugins: [
        new FriendlyErrorsWebpackPlugin()
    ]
  };
