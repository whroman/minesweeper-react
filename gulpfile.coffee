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

gulp.task 'css:build', ->
    gulp.src paths.scss.src
        .pipe gp.sourcemaps.init()
            .pipe gp.rename 'build.scss'
            .pipe(
                gp.sass options.scss
                    .on 'error', gp.sass.logError
            )
        .pipe gp.sourcemaps.write('./sass-maps')
        .pipe gulp.dest paths.build

gulp.task 'js:build', ->

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
            console.log 'browserify error:'
            console.log err
            @emit 'end'
        .pipe vinyl.source 'build.js'
        .pipe vinyl.buffer()
        .pipe gp.sourcemaps.init(loadMaps : true)
            .pipe gp.uglify options.uglify
        .pipe gp.sourcemaps.write('.maps')
        .pipe gulp.dest paths.build

# gulp.task 'js:build', ['js:coffee'], ->
#     gulp.src paths.js.all
#         .pipe gp.sourcemaps.init(loadMaps : true)
#             .pipe gp.concat 'build.js'
#         .pipe gp.sourcemaps.write('./maps')
#         .pipe gulp.dest paths.build

gulp.task 'server', ->
    gp.liveServer.static '.', 8890, false
        .start()


gulp.task 'watch', ->
    gulp.watch paths.scss.watch, options.gulpNoRead, ['css:build']
    gulp.watch [paths.coffee.watch], options.gulpNoRead, ['js:build']

gulp.task 'build', [
    'js:build'
    'css:build'
]

gulp.task 'dev', [
    'build'
    'watch'
    'server'
]

gulp.task 'default', ['dev']