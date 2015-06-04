TilesCollection = require '../collections/TilesCollection.coffee'
EventEmitter = require('events').EventEmitter
assign = require 'object-assign'

Tiles = new TilesCollection()
Tiles.newGame 10, 10, 25

window.foo = Tiles

TileStore = assign {}, EventEmitter.prototype,
    event: 'change'

    get: (attrs) ->
        Tiles.get attrs

    getAll: ->
        Tiles.getAll()

    getInfo: ->
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

    emitChange: ->
        @emit @event

    # To be called upon mounting a given component
    addChangeListener: (callback) ->
        @on @event, callback

    # To be called upon dismounting a given component
    removeChangeListener: (callback) ->
        @removeListener @event, callback

module.exports = TileStore