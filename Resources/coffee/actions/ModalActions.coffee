Dispatcher = require '../Dispatcher.coffee'

module.exports =
    toggle: (name) ->
        console.log name
        Dispatcher.dispatch
            type: 'MODAL_TOGGLE'
            name: name

    reset: ->
        Dispatcher.dispatch
            type: 'MODAL_RESET'