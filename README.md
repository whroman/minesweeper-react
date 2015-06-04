[![Build Status](https://travis-ci.org/whroman/minesweeper-react.svg?branch=master)](https://travis-ci.org/whroman/minesweeper-react)

# [Minesweeper React](http://whroman.github.io/minesweeper-react/)

A single-page Minesweeper app built using:

* [React](https://facebook.github.io/react/)
* [Coffeescript](http://coffeescript.org/)
* [Sass](http://sass-lang.com/)
* [Gulp](http://gulpjs.com/)
* [Jest](https://facebook.github.io/jest/)

View live [here](http://whroman.github.io/minesweeper-react/).

##Application

### Requirements
To work on the front-end code of the application, you'll need to have the following packages installed before continuing.

* [Node.js](http://nodejs.org): Use the installer provided on the NodeJS website.
* [Gulp](http://gulpjs.com/): Run `[sudo] npm install -g gulp`

## Tasks

### Structure

```
minesweeper-react
├── Gulpfile.coffee
│       // Holds project tasks, including:
│       // - Spinning up a local server
│       // - Sass compiling
│       // - Scripts
│       //      - Coffeescript compiling
│       //      - Uglify-ing
│       //      - Browserify-ing
│       //      - Concatenation
│       //      - Testing
│
└── Tasks
    │
    ├── index   // Exports `paths` and `options`
    ├── options // Exposes Gulp plugin option objects
    └── paths   // Exposes file paths of Resources manipulated by Gulp tasks

```
### Usage

* `gulp build`
    * Compiles, builds and live-reloads Sass
    * Compiles and builds Coffeescript
    * Destination of build files is defined in `Tasks//paths.js`

* `gulp` or `gulp dev`
    * Watches all \*.scss and \*.coffee files, automatically compiling and building the resources when a change is detected


## Development

### Getting Started

It is imperative to have the default `gulp` (or `gulp dev`) task running while developing. The dev server is located at `http://localhost:8890`.

### Adding New JS Libraries

1. Add lib to project using `npm` from the project root
2. Declare the path to the lib file in `[root]/Tasks//paths.js` as an Array item in `path.js.libs`. The files will be concat'd in listed order.


### Adding New Coffeescript Files

1) Create a `.coffee` file within `/Resources/coffee/`

2) The file will automatically show up in `index.html`

2+) The project currently uses only Angular modules, which, combined with this project's Gulp tasks, allows us to not have to declare any new files anyhwere for them to be compiled and built.

### Adding New SCSS Files

* Include new stylesheets in `/Resources/scss/app.scss` using `@import "path/to/file.scss"`