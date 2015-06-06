# Dispatcher = require '../Dispatcher.coffee'

# module.exports =
#     toggle: (name) ->
#         Dispatcher.dispatch
#             type: 'MODAL_TOGGLE'
#             name: name

#     reset: ->
#         Dispatcher.dispatch
#             type: 'MODAL_RESET'


Reflux = require 'reflux'

module.exports = Reflux.createActions [
    "toggle"
    "reset"
]