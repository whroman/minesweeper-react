Number.isInteger = require('../shims/isInteger.coffee')()

module.exports =
    class TileModel
        adjacentTiles = [
            [-1, -1], [ 0, -1], [ 1, -1],
            [-1,  0],           [ 1,  0],
            [-1,  1], [ 0,  1], [ 1,  1],
        ]

        constructor: (attrs) ->
            if !Number.isInteger(attrs.x) or !Number.isInteger(attrs.y)
                throw "`x` and `y` are required Integer attributes to instantiate Tile"

            @model =
                x : undefined
                y : undefined
                uid : undefined
                isMine : false
                isClear : false
                isFlagged : false
                adjacentMines : 0

            @set attrs

        set: (attrs) ->
            for key, attr of attrs
                @model[key] = attr
                @model.uid = String(attrs.x) + '-' + String(attrs.y)
            @

        getAdjacentTiles: ->
            adjacentTiles

        toggleFlag: ->
            @model.isFlagged = !@model.isFlagged
            @

        clear: ->
            @model.isClear = true
            @model.isFlagged = false
            @

