const { environment } = require('@rails/webpacker');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');

environment.loaders.get('sass').use.splice(-1, 0, {
  loader: MiniCssExtractPlugin.loader,
});

module.exports = environment;
