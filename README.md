[![Build Status](https://travis-ci.org/whroman/minesweeper-react.svg?branch=master)](https://travis-ci.org/whroman/minesweeper-react) [![Test Coverage](https://codeclimate.com/github/whroman/minesweeper-react/badges/coverage.svg)](https://codeclimate.com/github/whroman/minesweeper-react/coverage)

# [Minesweeper React](http://whroman.github.io/minesweeper-react/)

A single-page Minesweeper app built using:

### Languages

* [Coffeescript](http://coffeescript.org/)
* [Sass](http://sass-lang.com/)

### Client Code

* [Browserify](http://browserify.org/) - Brings node `require`s to client scripts
* [React](https://facebook.github.io/react/) - Frontend JS Framework
* [Reflux](https://github.com/spoike/refluxjs) - Provides helpers for establishing a [Flux architecture](https://facebook.github.io/flux/) on the client

### Tests

* [Mocha](http://mochajs.org/) - JS test framework
* [Chai](http://chaijs.com/) - Test assertion library
* [jsdom](https://github.com/tmpvar/jsdom) - Used here to spoof the DOM's JS API in tests regarding views
* [CoffeeCoverage](https://github.com/benbria/coffee-coverage) - Code coverage tool for Coffeescript
* [Istanbul](https://github.com/gotwarlost/istanbul) - Used here only to generate code coverage data file for Code Climate (`coverage/lcov.info`)

View live [here](http://whroman.github.io/minesweeper-react/).

## Requirements

To work on the app client code, you'll need to have the following packages installed before continuing.

* [Node.js](http://nodejs.org)
* [Gulp](http://gulpjs.com/)

Then run `npm install`.

## Commands

* `npm test` - Runs Mocha tests on all files in `Spec` except those that start with an underscore (eg. `Spec/_willNotRun.js`).

Destination of build files is defined in `Tasks/paths.js`

* `gulp css:build`
    * Compiles and builds Sass

* `gulp js:build`
    * Compiles and builds Coffeescript

* `gulp build`
    * Runs `css:build` and `js:build`

* `gulp` or `gulp dev`
    * Boots up a server at [127.0.0.1:8890/](http://127.0.0.1:8890/)
    * Runs `css:build` when a change is made in `Resources/scss/**/*.scss`
    * Runs `js:build` when a change is made in `Resources/coffee/**/*.coffee`

## Development

### Getting Started

It is imperative to have the default `gulp` (or `gulp dev`) task running while writing scss or coffee.

### Adding Third-Party JS

The project is currently only set up to accept libraries that have `browserify` support.

1) Install the library via `npm install <lib>`

2) Use `require` syntax to include the package in Coffee files

### Adding New Coffeescript Files

1) Create a `.coffee` file within `/Resources/coffee/`

2) The file will be automagically built into `build.js`

### Adding New SCSS Files

1) Include new stylesheets in `/Resources/scss/app.scss` using `@import "path/to/file.scss"`
2) The file will be automagically built into `build.css`
