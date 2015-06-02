Dispatcher = require '../Dispatcher.coffee'
TileStore = require '../stores/TileStore.coffee'

TilesComponent = require './TilesComponent.coffee'
InfoComponent = require './InfoComponent.coffee'
DashboardComponent = require './DashboardComponent.coffee'
ModalOverlayComponent = require './modals/ModalOverlayComponent.coffee'

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
        info = React.createElement InfoComponent,
            key: 'info'
            info: @state.info

        tiles = React.createElement TilesComponent,
                key: 'tiles'
                tiles: @state.all

        boardWrappper = R.div {
            id:'board-wrappper'
            key: 'board-wrappper'
        }, [
            info
            tiles
        ]

        dashboard = React.createElement DashboardComponent,
            key: 'dashboard'

        ModalOverlay = React.createElement ModalOverlayComponent,
            key: 'modal-overlay'
            info: @state.info

        R.div null, [
            boardWrappper
            dashboard
            ModalOverlay
        ]
    _onChange: ->
        console.log 'change!'
        @setState getState()

module.exports = Game