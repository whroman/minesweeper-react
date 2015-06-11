# Packages
Reflux = require 'reflux'
assign = require 'object-assign'

TilesActions = require '../actions/TilesActions.coffee'
ModalActions = require '../actions/ModalActions.coffee'

TilesCollection = require '../collections/TilesCollection.coffee'

# Bootstrap
Tiles = new TilesCollection()
loadedTiles =
    all: []
    success: false

if window.localStorage
    loadedTiles.string = window.localStorage.getItem 'tiles'
    loadedTiles.isValid = loadedTiles.string && loadedTiles.string[0] is '['

    if loadedTiles.isValid
        loadedTiles.all = JSON.parse loadedTiles.string
        if loadedTiles.all.length > 0
            Tiles.loadGame loadedTiles.all
            loadedTiles.success = true

if !loadedTiles.success
    Tiles.newGame 10, 10, 25

# Exposing `Tiles` methods
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

# `TileStore` actions
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

        if window.localStorage
            window.localStorage.setItem 'tiles', JSON.stringify all

TileStore = Reflux.createStore assign {}, store, handlers

module.exports = TileStore