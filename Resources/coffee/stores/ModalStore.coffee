Reflux = require 'reflux'
assign = require 'object-assign'

ModalActions = require '../actions/ModalActions.coffee'
ModalsCollection = require '../collections/ModalsCollection.coffee'

Modals = new ModalsCollection()
Modals.set 'newGame'
Modals.set 'instructions'


ModalStore = Reflux.createStore #assign {}, store, handlers
    show: {}

    getAll: ->
        @show = Modals.show

    reset: ->
        Modals.reset()

    toggle: (modalName) ->
        Modals.toggle modalName

    listenables: [ModalActions]

    onToggle: (name) ->
        ModalStore.toggle name
        @update()

    onReset: ->
        @onChange()
        @update()

    onChange: (name) ->
        if !name
            ModalStore.reset()
        else
            ModalStore.toggle name
        @update()

    update: ->
        @trigger @getAll()


module.exports = ModalStore