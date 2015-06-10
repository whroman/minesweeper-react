var path = require('path');
var coffeeCoverage = require('coffee-coverage');
console.log(__dirname)
var projectRoot = path.resolve(__dirname, "../");
var coverageVar = coffeeCoverage.findIstanbulVariable();
// Only write a coverage report if we're not running inside of Istanbul.
var writeOnExit = (coverageVar == null) ? (projectRoot + '/coverage/coverage-coffee.json') : null;

coffeeCoverage.register({
    instrumentor: 'istanbul',
    basePath: projectRoot,
    exclude: [
        '/Tasks',
        '/node_modules',
        '/Spec',
        '/Resources/build',
        '/Resources/scss',
        'gulpfile.coffee'
    ],
    coverageVar: coverageVar,
    writeOnExit: writeOnExit,
    initAll: true
});