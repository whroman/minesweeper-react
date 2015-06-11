Reflux = require 'reflux'
assign = require 'object-assign'
NewGameActions = require '../actions/NewGameActions.coffee'

store =
    data:
        x:
            value: 10
        y:
            value: 10
        mines:
            value: 25
            min: null
            max: null

    setMineVals: ->
        currentVal = @data.mines.val
        newVal = Math.floor( @data.x.value * @data.y.value / 4 )
        newMin = Math.floor( @data.x.value * @data.y.value / 5 )
        newMax = Math.floor( @data.x.value * @data.y.value / 2 )

        @data.mines.min = newMin
        @data.mines.max = newMax

        if (
            !currentVal or
            parseFloat(currentVal) < newFrom or
            parseFloat(currentVal) > newTo
        )
            @data.mines.value = newVal

store.setMineVals()

handlers =
    # listenables:
    #   Check Actions source for list of events that Store will be listening for.
    #   Actions.change() will fire "onChange" in Store if "change" is listed in Actions
    listenables: [NewGameActions]

    onChange: (key, val) ->
        if @data[key] isnt undefined and @data[key] isnt null
            @data[key].value = val

            # If `x` or `y` was changed, alter `mines` values accordingly
            if key isnt 'mines'
                @setMineVals()
            @update()
        else
            throw 'given `key` is not a property of `NewGameStore.data`'

    update: ->
        @trigger @data

NewGameStore = Reflux.createStore assign {}, store, handlers

module.exports = NewGameStore