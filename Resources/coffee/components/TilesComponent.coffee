React = require 'react/addons'

TileComponent = require './TileComponent.coffee'

R = React.DOM

Tiles = React.createClass
    displayName: 'Tiles'

    render: ->
        console.log @props.tiles
        # console.log @props.tiles.value
        if @props.tiles.value
            tiles = @props.tiles.value.map (item, index) =>
                React.createElement TileComponent, {
                    key: index
                    ref: item.model.uid
                    tile: item
                }

            R.ul id:'board', tiles

module.exports = Tiles