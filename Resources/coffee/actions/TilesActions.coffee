Dispatcher = require '../Dispatcher.coffee'

module.exports =
    clearSafeRandomTile: () ->
        Dispatcher.dispatch
            type: 'TILES_CLEAR_SAFE_RANDOM'

    newGame: () ->
        Dispatcher.dispatch
            type: 'TILES_NEW_GAME'