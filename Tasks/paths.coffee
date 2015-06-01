require 'coffee-script/register'

path =
    root    : './Resources/'

path.npm = './node_modules/'
path.build = path.root + 'build/'

path.scss =
    watch   : path.root + 'scss/**/*.scss'
    src     : [path.root + 'scss/app.scss']
    build   : 'build.scss'

path.coffee =
    src     : path.root + 'coffee/app.coffee'
    dest    : path.build + 'js/'
    watch   : path.root + 'coffee/**/*.coffee'

path.tests =
    watch   : './Spec/Unit/**/*.coffee'

path.js =
    build   : path.build + 'build.js'

    libs: [
        'react/dist/react.js'
    ].map (file) -> path.npm + file

path.js.all = path.js.libs.concat(path.coffee.dest + '**/*.js')

module.exports = path