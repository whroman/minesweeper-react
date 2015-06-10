TileModel = require '../models/TileModel.coffee'

class TilesCollection
    constructor: () ->
        @all = []

        collection = @

        @model = class Model extends TileModel
            clear: ->
                super()
                collection.clearNeighbors @
                collection.moveUpdate()

            toggleFlag: ->
                super()
                collection.moveUpdate()

    newGame: (x, y, mines) ->
        @reset()
        @x = x
        @y = y
        @numOfMines = mines

        for y in [0..@y - 1]
            for x in [0..@x - 1]
                attrs = {
                    x   : x
                    y   : y
                }
                @add attrs

        for mineNum in [1..@numOfMines]
            tile = @randomSafeTile()
            tile.model.isMine = true

        @tallyMines()
        @gameUpdate()

    loadGame: (savedTiles) ->
        @reset()
        for tile in savedTiles
            @add tile.model
        @gameUpdate()

    # Finds an empty tile and marks it as a mine if no tiles
    # have yet to be cleared AND the given tile is a mine
    noMineFirstClick: (tile) ->
        if @numOfClears is 0 and tile.model.isMine is true
            tile.model.isMine = false
            @randomSafeTile().model.isMine = true
            @tallyMines()

        return tile

    add: (model) ->
        tile = new @model model
        @all.push tile
        tile

    reset: ->
        @all = []
        @

    randomSafeTile : () ->
        findAttrs =
            isClear : false
            isMine  : false

        safeTiles = @getAll findAttrs
        randomIndex = Math.floor Math.random() * safeTiles.length
        return safeTiles[ randomIndex ]

    tallyMines : () ->
        for tile in @all
            neighborMines = 0
            for adjacentTile in tile.getAdjacentTiles()
                neighborX = tile.model.x + adjacentTile[0]
                neighborY = tile.model.y + adjacentTile[1]
                neighborAttrs = {
                    isMine  : true
                    x       : neighborX
                    y       : neighborY
                }
                neighborMine = this.get(neighborAttrs)
                if neighborMine isnt undefined
                    neighborMines++
            tile.model.adjacentMines = neighborMines

    gameUpdate : ->
        @numOfMines = 0
        for tile in @all
            if tile.model.isMine is true
                @numOfMines++

        @moveUpdate()

    moveUpdate : ->
        @loss    = false
        @win     = false
        @numOfClears = 0
        @numOfFlags  = 0

        for tile in @all
            # Cleared Tiles
            if tile.model.isClear is true
                @numOfClears++

            # Flagged Tiles
            if tile.model.isFlagged is true
                @numOfFlags++

            # Check Game Loss
            if tile.model.isMine is true && tile.model.isClear is true
                @loss = true

        # Check Game Win
        if @loss is false && @all.length - @numOfMines - @numOfClears is 0
            @win = true

    clearNeighbors : (tile) ->
        shouldClearNeighbors = tile.model.adjacentMines is 0 and tile.model.isMine is false
        if shouldClearNeighbors
            for adjacentTile in tile.getAdjacentTiles()
                neighbor = @get(
                    x : tile.model.x + adjacentTile[0]
                    y : tile.model.y + adjacentTile[1]
                )

                shouldClearNeighbor = (
                    neighbor and
                    neighbor.model.isClear is false and
                    neighbor.model.isMine is false
                )

                if shouldClearNeighbor
                    neighbor.clear()

    get : (attrs) ->
        return @getAll(attrs)[0]

    getAll : (attrs) ->
        matches = []
        if !attrs
            return @all

        for tile in @all
            numOfAttrs = 0
            numOfMatchedAttrs = 0
            for key, val of attrs
                numOfAttrs++
                if tile.model[key] is val
                    numOfMatchedAttrs++

            if numOfMatchedAttrs is numOfAttrs
                matches.push tile

        return matches

module.exports = TilesCollection