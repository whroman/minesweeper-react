TileComponent = require './TileComponent.coffee'
Dispatcher = require '../Dispatcher.coffee'
TileStore = require '../stores/TileStore.coffee'

R = React.DOM

getState = ->
    all: TileStore.getAll()

Tiles = React.createClass
    displayName: 'Tiles'
    getInitialState: ->
        getState()

    componentDidMount: ->
        TileStore.addChangeListener this._onChange

    componentWillUnmount: ->
        TileStore.removeChangeListener this._onChange

    render: ->
        tiles = this.state.all.map (item, index) =>
            React.createElement TileComponent, {
                key: index
                ref: item.model.uid
                tile: item
            }

        R.ul id:'board', tiles

    _onChange: ->
        console.log 'change!'
        this.setState getState()

module.exports = Tiles