Reflux = require 'reflux'

ModalActions = require '../actions/ModalActions.coffee'
ModalsCollection = require '../collections/ModalsCollection.coffee'
EventEmitter = require('events').EventEmitter
assign = require 'object-assign'

Modals = new ModalsCollection()
Modals.set 'newGame'
Modals.set 'instructions'

ModalStore = Reflux.createStore

    all: {}

    getAll: ->
        Modals.show
        @modals = Modals.show

    reset: ->
        Modals.reset()

    toggle: (modalName) ->
        Modals.toggle modalName

    # 
    listenables: [ModalActions]

    onToggle: (name) ->
        ModalStore.toggle name
        ModalStore.emitChange()

    onReset: ->
        changeModal()

module.exports = ModalStore