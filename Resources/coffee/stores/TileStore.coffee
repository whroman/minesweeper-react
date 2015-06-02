TilesCollection = require '../collections/TilesCollection.coffee'
Dispatcher = require '../Dispatcher.coffee'
EventEmitter = require('events').EventEmitter
assign = require 'object-assign'

Tiles = new TilesCollection()

TodoStore = assign {}, EventEmitter.prototype,
    event: 'change'
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

Dispatcher.register (event) ->
    switch event.type
        when 'TILE_FLAG_TOGGLE'
            console.log 'tile flag'
            tile = Tiles.get uid:event.uid
            tile.toggleFlag()
            TodoStore.emitChange()
        when 'TILE_CLEAR'
            console.log 'tile clear'
            tile = Tiles.get uid:event.uid
            tile.clear()
            TodoStore.emitChange()


module.exports = TodoStore