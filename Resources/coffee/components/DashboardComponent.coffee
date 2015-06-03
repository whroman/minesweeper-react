ModalActions = require '../actions/ModalActions.coffee'
TilesActions = require '../actions/TilesActions.coffee'

R = React.DOM

Dashboard = React.createClass
    displayName: 'Dashboard'

    render: ->
        R.div id:'dashboard', [
            R.div {
                key: 'new-game'
                className: 'new-game button'
                onClick: ->
                    ModalActions.toggle 'newGame'
            }, 'new game'

            R.div {
                key: 'select-tile'
                className: 'select-tile button'
                onClick: TilesActions.clearSafeRandomTile
            }, 'clear a safe tile'

            R.div {
                key: 'instructions'
                className: 'instructions button'
                onClick: ->
                    ModalActions.toggle 'instructions'
            }, 'instructions'
        ]

module.exports = Dashboard