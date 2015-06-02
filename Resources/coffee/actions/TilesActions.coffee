Dispatcher = require '../Dispatcher.coffee'

module.exports =
    clearSafeRandomTile: () ->
        console.log 'csrt'
        Dispatcher.dispatch
            type: 'TILES_CLEAR_SAFE_RANDOM'

    newGame: () ->
        console.log 'new game'
        Dispatcher.dispatch
            type: 'TILES_NEW_GAME'