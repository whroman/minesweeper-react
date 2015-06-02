Number.isInteger = Number.isInteger or (value) ->
    return (
        typeof value is "number" and
        isFinite(value) and
        Math.floor(value) is value
    )

module.exports =
    class TileModel
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

            @adjacentTiles = [
                [-1, -1], [ 0, -1], [ 1, -1],
                [-1,  0],           [ 1,  0],
                [-1,  1], [ 0,  1], [ 1,  1],
            ]

            @set attrs

        set: (attrs) ->
            for key, attr of attrs
                @model[key] = attr
                @model.uid = String(attrs.x) + '-' + String(attrs.y)
            @

        toggleFlag: ->
            @model.isFlagged = !@model.isFlagged
            @

        clear: ->
            @model.isClear = true
            @model.isFlagged = false
            @

        # 
        click: ($event) ->
            if !$event
                return @clear()

            flagKeyWasPressed = (
                $event.shiftKey is true or
                $event.altKey is true
            )

            if flagKeyWasPressed
                return @toggleFlag()
            else
                return @clear()