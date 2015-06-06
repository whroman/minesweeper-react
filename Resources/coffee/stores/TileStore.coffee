Reflux = require 'reflux'

TilesActions = require '../actions/TilesActions.coffee'
ModalActions = require '../actions/ModalActions.coffee'

TilesCollection = require '../collections/TilesCollection.coffee'

Tiles = new TilesCollection()
Tiles.newGame 10, 10, 25

changeModal = (name) ->
    if !name
        ModalActions.reset()
    else
        ModalActions.toggle name

onTilesChange = ->
    TileStore.getInfo()

TileStore = Reflux.createStore
    listenables: [TilesActions]

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

        # asdf

    onClearSafeRandomTile: ->
        tile = @randomSafeTile()
        if tile
            tile.clear()
            onTilesChange()

        @trigger @getAll()

    onNewGame: ->
        @newGame 10, 10, 25
        onTilesChange()
        changeModal 'newGame'
        @trigger @getAll()

    onTileFlagToggle: (uid) ->
        tile = @get uid: uid
        tile.toggleFlag()
        onTilesChange()
        @trigger @getAll()

    onTileClear: (uid) ->
        console.log uid
        attrs = uid: uid
        tile = @get attrs
        tile.clear()
        onTilesChange()
        @trigger @getAll()

module.exports = TileStore