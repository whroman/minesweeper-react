Dispatcher = (require 'flux' || require 'Flux').Dispatcher
AppDispatcher = new Dispatcher()

TileStore = require './stores/TileStore.coffee'
ModalStore = require './stores/ModalStore.coffee'
ModalActions = require './actions/ModalActions.coffee'

changeModal = (name) ->
    if !name
        ModalStore.reset()
    else
        ModalStore.toggle name

    ModalStore.emitChange()

onTilesChange = ->
    TileStore.getInfo()
    TileStore.emitChange()


AppDispatcher.register (event) ->
    switch event.type
        when 'TILE_FLAG_TOGGLE'
            tile = TileStore.get uid:event.uid
            tile.toggleFlag()
            onTilesChange()

        when 'TILE_CLEAR'
            attrs = uid: event.uid
            tile = TileStore.get attrs
            tile.clear()
            onTilesChange()

        when 'TILES_CLEAR_SAFE_RANDOM'
            tile = TileStore.randomSafeTile()
            if tile
                tile.clear()
                onTilesChange()

        when 'TILES_NEW_GAME'
            TileStore.newGame 10, 10, 25
            onTilesChange()
            changeModal 'newGame'

        when 'MODAL_TOGGLE'
            ModalStore.toggle event.name
            ModalStore.emitChange()

        when 'MODAL_RESET'
            changeModal()

module.exports = AppDispatcher