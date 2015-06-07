React = require 'react/addons'

R = React.DOM

Info = React.createClass
    displayName: 'Info'

    render: ->
        components = []

        if @props.info
            components = [
                R.li key: 'tiles', @props.info.numOfTiles + " tiles"
                R.li key: 'mines', @props.info.numOfMines + " mines"
                R.li key: 'flagged', @props.info.numOfFlags + " flagged tiles"
                R.li key: 'cleared', @props.info.numOfUncleared + " left to clear"
            ]

        R.ul id:'stats', components

module.exports = Info