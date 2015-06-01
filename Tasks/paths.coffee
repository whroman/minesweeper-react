require 'coffee-script/register'

path =
    root    : './Resources/'

path.npm = './node_modules/'
path.build = path.root + 'build/'

path.scss =
    watch   : path.root + 'scss/**/*.scss'
    src     : [path.root + 'scss/app.scss']
    build   : 'build.scss'

path.coffee = {}
path.coffee.src = path.root + 'coffee/app.coffee'
path.coffee.dest = path.build + 'js/'
path.coffee.watch = path.root + 'coffee/**/*.coffee'

path.js =
    build   : path.build + 'build.js'

    libs: [
        'react/dist/react.js'
    ].map (file) -> path.npm + file

path.js.all = path.js.libs.concat(path.coffee.dest + '**/*.js')

module.exports = path