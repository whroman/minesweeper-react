TileComponent = require './TileComponent.coffee'
Dispatcher = require '../Dispatcher.coffee'
TileStore = require '../stores/TileStore.coffee'

R = React.DOM

Tiles = React.createClass
    displayName: 'Tiles'
    getInitialState: ->
        all: TileStore.getAll()

    render: ->
        tiles = this.state.all.map (item, index) =>
            React.createElement TileComponent, {
                key: index
                ref: item.model.uid
                tile: item
            }

        R.ul {
            id: 'board'
        }, tiles

    componentDidMount: ->
        collection = @

Dispatcher.register (event) ->
    switch event.type
        when 'TILE_FLAG_TOGGLE'
            console.log 'tile flag'
        when 'TILE_CLEAR'
            console.log 'tile clear'

module.exports = Tiles