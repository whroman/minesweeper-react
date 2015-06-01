Tile = require './Tile.coffee'
R = React.DOM

Tiles = React.createClass
    displayName: 'Tiles'
    render: ->
        tiles = this.props.data.map (item) ->
            React.createElement Tile, null

        R.ul {
            id: 'board'
        }, tiles


module.exports = Tiles