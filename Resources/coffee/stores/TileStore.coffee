TilesCollection = require '../collections/TilesCollection.coffee'
EventEmitter = require('events').EventEmitter
assign = require 'object-assign'

Tiles = new TilesCollection()

TileStore = assign {}, EventEmitter.prototype,
    event: 'change'

    get: (attrs) ->
        Tiles.get attrs

    getAll: ->
        Tiles.getAll()

    getInfo: ->
        Tiles.getInfo()

    emitChange: ->
        @emit @event

    # To be called upon mounting a given component
    addChangeListener: (callback) ->
        @on @event, callback

    # To be called upon dismounting a given component
    removeChangeListener: (callback) ->
        @removeListener @event, callback

module.exports = TileStore