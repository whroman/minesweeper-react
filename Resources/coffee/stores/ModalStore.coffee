Reflux = require 'reflux'
assign = require 'object-assign'

ModalActions = require '../actions/ModalActions.coffee'
ModalsCollection = require '../collections/ModalsCollection.coffee'

Modals = new ModalsCollection()
Modals.set 'newGame'
Modals.set 'instructions'

store =
    show: {}

    getAll: ->
        @show = Modals.show

    reset: ->
        Modals.reset()

    toggle: (modalName) ->
        Modals.toggle modalName


handlers =
    # listenables:
    #   Check Actions source for list of events that Store will be listening for.
    #   Actions.change() will fire "onChange" in Store if "change" is listed in Actions
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

ModalStore = Reflux.createStore assign {}, store, handlers

module.exports = ModalStore