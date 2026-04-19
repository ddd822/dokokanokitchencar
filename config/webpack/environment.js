require("dotenv").config();

const { environment } = require('@rails/webpacker')

const webpack = require('webpack')

environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    Popper: 'popper.js'
  })
)

// ここに追記：環境変数をJSに埋め込むDefinePlugin設定
environment.plugins.append(
  'Define',
  new webpack.DefinePlugin({
    'process.env.Maps_API_Key': JSON.stringify(process.env.Maps_API_Key)
  })
)

module.exports = environment
