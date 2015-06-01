paths = require './paths.coffee'

options =
    gulpNoRead:
        read : false

    scss:
        style : 'compressed'
        sourcemap : true
        noCache : true

    coffee :
        bare : true

    uglify:
        mangle : false

    connect:
        root : './'
        port : '8888'

module.exports = options