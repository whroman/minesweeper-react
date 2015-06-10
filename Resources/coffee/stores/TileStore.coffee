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

    getAll: (attrs) ->
        @all = Tiles.getAll attrs

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
    # Check Actions source for list of events that Store will be listening for.
    #   When heard, callback will fire based on name of listener.
    #   Ex: Actions.change() will fire "onChange" in Store if "change" is listed in Actions
    listenables: [TilesActions]

    onClearSafeRandomTile: ->
        tile = @randomSafeTile()
        if tile
            tile.clear()
            @update()
            return tile
        else
            return null

    onNewGame: (x, y, mines) ->
        @newGame x, y, mines
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