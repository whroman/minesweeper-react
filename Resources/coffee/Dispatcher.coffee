Dispatcher = require('Flux').Dispatcher
AppDispatcher = new Dispatcher()
TileStore = require './stores/TileStore.coffee'

AppDispatcher.register (event) ->
    switch event.type
        when 'TILE_FLAG_TOGGLE'
            console.log 'tile flag'
            tile = TileStore.get uid:event.uid
            tile.toggleFlag()
            TileStore.emitChange()
        when 'TILE_CLEAR'
            console.log 'tile clear'
            tile = TileStore.get uid:event.uid
            tile.clear()
            TileStore.emitChange()

module.exports = AppDispatcher