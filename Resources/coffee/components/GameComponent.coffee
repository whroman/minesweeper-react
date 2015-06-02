ComponentTiles = require './TilesComponent.coffee'

R = React.DOM

Game = React.createClass
    displayName: 'Tiles'
    getInitialState: ->
        all: []

    render: ->
        Board = React.createElement ComponentTiles, {
            tiles: this.state.all
        }

        R.div {
            id: 'game'
        }, Board

module.exports = Game