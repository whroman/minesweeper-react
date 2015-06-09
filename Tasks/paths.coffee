require 'coffee-script/register'

paths =
    root    : './Resources/'

paths.npm = './node_modules/'
paths.build = paths.root + 'build/'

paths.scss =
    watch   : paths.root + 'scss/**/*.scss'
    src     : [paths.root + 'scss/app.scss']
    build   : 'build.scss'

paths.coffee =
    src     : paths.root + 'coffee/App.coffee'
    dest    : paths.build + 'js/'
    watch   : paths.root + 'coffee/**/*.coffee'

paths.js =
    build   : paths.build + 'build.js'

paths.js.all = [paths.coffee.dest + '**/*.js']

module.exports = paths