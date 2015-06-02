Dispatcher = require '../Dispatcher.coffee'

module.exports =
    toggleFlag: (uid) ->
        Dispatcher.dispatch
            type: 'TILE_FLAG_TOGGLE'
            uid: uid

        # @setState isFlagged: !@props.tile.model.isFlagged

    # 
    clear: (uid) ->
        Dispatcher.dispatch
            type: 'TILE_CLEAR'
            uid: uid

        # @setState(
        #     @setState isClear: true
        #     @setState isFlagged: false
        # )