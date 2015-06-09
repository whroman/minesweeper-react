require 'coffee-script/register'

gulp = require 'gulp'
del = require 'del'
browserify = require 'browserify'
coffee = require 'coffee-script'
spawn = require('child_process').spawn
vinyl =
    paths: require 'vinyl-paths'
    buffer: require 'vinyl-buffer'
    source: require 'vinyl-source-stream'

through = require 'through'

# Loads all gulp plugins located in package.json
# > Call plugins using `gp.<camelizedPluginName>
gp = do require 'gulp-load-plugins'

# Load configurations for gulp files
Tasks = require './Tasks'
paths = Tasks.paths
options = Tasks.options

gulp.task 'sass', ->
    gulp.src paths.scss.src
        .pipe gp.sourcemaps.init()
            .pipe gp.rename 'build.scss'
            .pipe(
                gp.sass options.scss
                    .on 'error', gp.sass.logError
            )
        .pipe gp.sourcemaps.write('./sass-maps')
        .pipe gulp.dest paths.build

gulp.task 'js:clean', (cb) ->
    del paths.coffee.dest, cb

gulp.task 'js:coffee', ['js:clean'], ->

    b = browserify(
        entries: [
            paths.coffee.src
        ]
        debug: true
        paths: paths.npm
    )

    b.transform (fileName) ->
        data = ''
        fileExtensionRe = /\.[0-9a-z]+$/i

        write = (buf) ->
            data += buf

        end = () ->
            # console.log fileName
            fileExt = fileExtensionRe.exec fileName
            if fileExt and fileExt[0] is '.coffee'
                this.queue coffee.compile data
            else
                this.queue data
            this.queue null

        through write, end

    b.bundle()
        .on 'error', (err) ->
            console.log err
        .pipe vinyl.source 'build.js'
        .pipe vinyl.buffer()
        .pipe gp.sourcemaps.init(loadMaps : true)
            .pipe gp.uglify options.uglify
        .pipe gp.sourcemaps.write()
        .pipe gulp.dest paths.coffee.dest

gulp.task 'js:build', ['js:coffee'], ->
    gulp.src paths.js.all
        .pipe gp.sourcemaps.init(loadMaps : true)
            .pipe gp.concat 'build.js'
        .pipe gp.sourcemaps.write('./maps')
        .pipe gulp.dest paths.build


test = ->
    childProcess = spawn 'npm', ['test']

    print = (data) ->
        if data
            console.log String(data)

    childProcess.stdout.on 'data', print
    childProcess.stderr.on 'data', (data) ->
        print data
        childProcess.kill()

gulp.task 'js:test', ['js:build'], test

gulp.task 'test', test


gulp.task 'server', ->
    gp.liveServer.static '.', 8890, false
        .start()


gulp.task 'watch', ->
    gulp.watch paths.scss.watch, options.gulpNoRead, ['sass']
    gulp.watch [paths.coffee.watch, paths.tests.watch], options.gulpNoRead, ['js:test']

gulp.task 'build', [
    'js:test'
    'sass'
]

gulp.task 'dev', [
    'build'
    'watch'
    'server'
]

gulp.task 'default', ['dev']