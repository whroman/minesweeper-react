Reflux = require 'reflux'
assign = require 'object-assign'
NewGameActions = require '../actions/NewGameActions.coffee'

store =
    data:
        x: 10
        y: 10
        mines: 25

handlers =
    # listenables:
    #   Check Actions source for list of events that Store will be listening for.
    #   Actions.change() will fire "onChange" in Store if "change" is listed in Actions
    listenables: [NewGameActions]

    onChange: (key, val) ->
        if @data[key] isnt undefined and @data[key] isnt null
            @data[key] = val
        @update()

    update: ->
        @trigger @data

NewGameStore = Reflux.createStore assign {}, store, handlers

module.exports = NewGameStore