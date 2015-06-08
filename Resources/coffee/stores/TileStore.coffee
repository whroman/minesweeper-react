Reflux = require 'reflux'
assign = require 'object-assign'

TilesActions = require '../actions/TilesActions.coffee'
ModalActions = require '../actions/ModalActions.coffee'

TilesCollection = require '../collections/TilesCollection.coffee'

Tiles = new TilesCollection()
Tiles.newGame 10, 10, 25

store =
    all: []
    info: {}

    get: (attrs) ->
        Tiles.get attrs

    getAll: ->
        @all = Tiles.getAll()

    getInfo: ->
        @info =
            win: Tiles.win
            loss: Tiles.loss
            numOfTiles: Tiles.all.length
            numOfMines: Tiles.numOfMines
            numOfFlags: Tiles.numOfFlags
            numOfUncleared: Tiles.all.length - Tiles.numOfMines - Tiles.numOfClears

    randomSafeTile: ->
        Tiles.randomSafeTile()

    newGame: (x, y, mines) ->
        Tiles.newGame x, y, mines

handlers =
    listenables: [TilesActions]

    onClearSafeRandomTile: ->
        tile = @randomSafeTile()
        if tile
            tile.clear()
            @update()

    onNewGame: ->
        @newGame 10, 10, 25
        ModalActions.change()
        @update()

    onTileToggleFlag: (uid) ->
        tile = @get uid: uid
        tile.toggleFlag()
        @update()

    onTileClear: (uid) ->
        attrs = uid: uid
        tile = @get attrs
        tile.clear()
        @update()

    update: ->
        all = @getAll()
        info = @getInfo()
        @trigger
            all: all
            info: info
        if info.win or info.loss
            ModalActions.change 'newGame'

TileStore = Reflux.createStore assign {}, store, handlers

module.exports = TileStore