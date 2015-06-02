TilesComponent = require './TilesComponent.coffee'
InfoComponent = require './InfoComponent.coffee'
Dispatcher = require '../Dispatcher.coffee'
TileStore = require '../stores/TileStore.coffee'

R = React.DOM

getState = ->
    all: TileStore.getAll()
    info: TileStore.getInfo()

Game = React.createClass
    displayName: 'Game'
    getInitialState: ->
        getState()

    componentDidMount: ->
        TileStore.addChangeListener @_onChange

    componentWillUnmount: ->
        TileStore.removeChangeListener @_onChange

    render: ->
        R.div id:'game', [
            React.createElement InfoComponent, info: @state.info
            React.createElement TilesComponent, tiles: @state.all
        ]
    _onChange: ->
        console.log 'change!'
        @setState getState()

module.exports = Game