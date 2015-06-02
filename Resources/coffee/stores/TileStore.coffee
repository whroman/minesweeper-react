TilesCollection = require '../collections/TilesCollection.coffee'
Dispatcher = require '../Dispatcher.coffee'

Tiles = new TilesCollection()

TodoStore =
    getAll : ->
        console.log(Tiles.getAll())
        Tiles.getAll()

module.exports = TodoStore