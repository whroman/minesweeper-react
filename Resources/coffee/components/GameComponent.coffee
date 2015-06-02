Dispatcher = require '../Dispatcher.coffee'
TileStore = require '../stores/TileStore.coffee'

TilesComponent = require './TilesComponent.coffee'
InfoComponent = require './InfoComponent.coffee'
DashboardComponent = require './DashboardComponent.coffee'


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
        boardWrappper = R.div {
            id:'board-wrappper'
            key: 'board-wrappper'
        }, [
            React.createElement InfoComponent,
                key: 'info'
                info: @state.info
            React.createElement TilesComponent,
                key: 'tiles'
                tiles: @state.all
        ]

        dashboard = React.createElement DashboardComponent,
            key: 'dashboard'

        R.div null, [
            boardWrappper
            dashboard
        ]
    _onChange: ->
        console.log 'change!'
        @setState getState()

module.exports = Game