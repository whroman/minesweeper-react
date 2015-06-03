ModalsCollection = require '../collections/ModalsCollection.coffee'
EventEmitter = require('events').EventEmitter
assign = require 'object-assign'

Modals = new ModalsCollection()
Modals.set 'newGame'
Modals.set 'instructions'

ModalStore = assign {}, EventEmitter.prototype,
    event: 'event'

    getAll: ->
        Modals.show

    reset: ->
        Modals.reset()

    toggle: (modalName) ->
        Modals.toggle modalName

    emitChange: ->
        @emit @event

    # To be called upon mounting a given component
    addChangeListener: (callback) ->
        @on @event, callback

    # To be called upon dismounting a given component
    removeChangeListener: (callback) ->
        @removeListener @event, callback

module.exports = ModalStore