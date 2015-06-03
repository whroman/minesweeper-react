Dispatcher = require '../Dispatcher.coffee'
TileStore = require '../stores/TileStore.coffee'
ModalStore = require '../stores/ModalStore.coffee'

ModalActions = require '../actions/ModalActions.coffee'

TilesComponent = require './TilesComponent.coffee'
InfoComponent = require './InfoComponent.coffee'
DashboardComponent = require './DashboardComponent.coffee'
ModalOverlayComponent = require './modals/ModalOverlayComponent.coffee'

assign = require 'object-assign'

R = React.DOM

getState = ->
    return assign {},
        getTileStoreState(),
        getModalStoreState()

getTileStoreState = ->
    all: TileStore.getAll()
    info: TileStore.getInfo()

getModalStoreState = ->
    modals: ModalStore.getAll()

Game = React.createClass
    displayName: 'Game'
    getInitialState: ->
        getState()

    componentDidMount: ->
        TileStore.addChangeListener @_onTileStoreChange
        ModalStore.addChangeListener @_onModalStoreChange

    componentWillUnmount: ->
        TileStore.removeChangeListener @_onTileStoreChange
        ModalStore.removeChangeListener @_onModalStoreChange

    _onTileStoreChange: ->
        tilesState = getTileStoreState()
        @setState tilesState
        console.log 'tile store change!'
        console.log tilesState.info.win, tilesState.info.loss
        console.log getTileStoreState()
        if tilesState.info.win or tilesState.info.loss
            console.log 'WOOOOOOOO'
            setTimeout (-> ModalActions.toggle 'newGame'), 0

    _onModalStoreChange: ->
        console.log 'change!'
        @setState getModalStoreState()

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

        overlays = React.createElement ModalOverlayComponent,
            key: 'modal-overlay'
            info: @state.info
            modals: @state.modals

        R.div null, [
            overlays
            boardWrappper
            dashboard
        ]

module.exports = Game