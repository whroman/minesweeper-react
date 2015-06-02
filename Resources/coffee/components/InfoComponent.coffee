R = React.DOM

Info = React.createClass
    displayName: 'Info'

    render: ->
        R.ul id:'stats', [
            R.li null, @props.info.numOfTiles + " tiles"
            R.li null, @props.info.numOfMines + " mines"
            R.li null, @props.info.numOfFlags + " flagged tiles"
            R.li null, @props.info.numOfUncleared + " left to clear"
        ]

module.exports = Info