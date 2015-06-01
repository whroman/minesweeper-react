R = React.DOM

Tile = React.createClass
    displayName: 'Tile'
    render: ->
        R.li {
            className: 'tile',
        }, R.span null, 'X'

module.exports = Tile