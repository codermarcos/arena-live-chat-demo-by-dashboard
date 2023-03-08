import { join, resolve } from 'path';

import { Configuration, ProvidePlugin } from 'webpack';

import HtmlWebpackPlugin from 'html-webpack-plugin';
import CopyPlugin from 'copy-webpack-plugin';

import pkg from './package.json';

const templateParameters = {
  language: 'en',
  chatCode: '84cHSv9',
  chatPublishier: 'wizardmodestaging',
	chatUrl: `https://go.arena.im/embed/chat/`,
  title: 'Arena Live Chat Demo | codermarcos',
  description: 'Test created by Marcos (codermarcos)'
};

const config: Configuration = {
  mode: 'development',
  entry: {},
  output: {
    path: join(__dirname, pkg.config.out),
    clean: true,
  },
  module: {
    rules: [
      {
        test: /\.ejs$/,
        loader: 'ejs-loader',
        options: {
          esModule: false,
        },
      },
      {
        test: /\.ts$/,
        exclude: /(node_modules)/,
        use: {
          loader: 'swc-loader',
        },
      },
    ],
  },
  resolve: {
    extensions: ['.ejs'],
  },
  plugins: [
    new ProvidePlugin({
      include: '(path, data, options) => ejs.render(require(\'fs\').readFileSync(path), data, options)',
    }),
    new CopyPlugin({
      patterns: [
        {
          from: resolve(__dirname, './src', 'static'),
          to: resolve(__dirname, './dist'),
        },
      ],
    }),
    new HtmlWebpackPlugin({
      templateParameters,
      inject: false,
    }),
  ]
};

export default config;
