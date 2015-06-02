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

        when 'TILES_CLEAR_SAFE_RANDOM'
            console.log 'tiles clear safe random'
            tile = TileStore.randomSafeTile()
            if tile
                tile.clear()
                TileStore.emitChange()

        when 'TILES_NEW_GAME'
            console.log 'newGame'
            TileStore.newGame 8, 4, 10
            TileStore.emitChange()

module.exports = AppDispatcher