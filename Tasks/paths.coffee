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
    src     : paths.root + 'coffee/app.coffee'
    dest    : paths.build + 'js/'
    watch   : paths.root + 'coffee/**/*.coffee'

paths.tests =
    watch   : './Spec/Unit/**/*.coffee'

paths.js =
    build   : paths.build + 'build.js'

    libs: [
        'react/dist/react.js'
    ].map (file) -> paths.npm + file

paths.js.all = paths.js.libs.concat(paths.coffee.dest + '**/*.js')

module.exports = paths