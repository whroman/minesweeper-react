ModalsCollection = require '../collections/ModalsCollection.coffee'
EventEmitter = require('events').EventEmitter
assign = require 'object-assign'

Modals = new ModalsCollection()
Modals.set 'NewGame'

ModalStore = assign {}, ,
    event: 'event'
    emitChange: ->
        @emit @event

    # To be called upon mounting a given component
    addChangeListener: (callback) ->
        @on @event, callback

    # To be called upon dismounting a given component
    removeChangeListener: (callback) ->
        @removeListener @event, callback