const path = require('path');

module.exports = {
  output: { chunkFilename: 'js/[name].js?id=[chunkhash]' },
  resolve: {
    extensions: ['.js', '.svelte'],
    mainFields: ['svelte', 'browser', 'module', 'main'],
    alias: {
      '@': path.resolve('resources/js'),
    },
  },
  // plugins: [],
  module: {
    rules: [
      // svelte_loader_replace
    ],
  },
};
