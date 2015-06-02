Dispatcher = require '../Dispatcher.coffee'

module.exports =
    toggleFlag: (uid) ->
        Dispatcher.dispatch
            type: 'TILE_FLAG_TOGGLE'
            uid: uid

    clear: (uid) ->
        Dispatcher.dispatch
            type: 'TILE_CLEAR'
            uid: uid