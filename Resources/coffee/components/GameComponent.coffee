React = require 'react'
Reflux = require 'reflux'

TileStore = require '../stores/TileStore.coffee'
ModalStore = require '../stores/ModalStore.coffee'

ModalActions = require '../actions/ModalActions.coffee'

TilesComponent = require './TilesComponent.coffee'
InfoComponent = require './InfoComponent.coffee'
DashboardComponent = require './DashboardComponent.coffee'
ModalOverlayComponent = require './modals/ModalOverlayComponent.coffee'

assign = require 'object-assign'

R = React.DOM

window.Game = Game = React.createClass
    displayName: 'Game'
    mixins: [
        Reflux.connect TileStore, "tiles"
        Reflux.connect ModalStore, "modals"
    ]
    getInitialState: ->
        tiles:
            all: []
            info: {}

        modals: {}

    componentDidMount: ->
        TileStore.update()
        ModalStore.update()

    render: ->
        parent = this

        info = React.createElement InfoComponent,
            key: 'info'
            info: @state.tiles.info

        tiles = React.createElement TilesComponent,
                key: 'tiles'
                tiles: @state.tiles.all

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
            info: @state.tiles.info
            modals: @state.modals

        R.div null, [
            overlays
            boardWrappper
            dashboard
        ]

module.exports = Game