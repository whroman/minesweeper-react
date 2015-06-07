React = require 'react/addons'
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

queue = (fn) -> setTimeout fn, 0

# getState = ->
#     return assign {},
#         getTileStoreState(),
#         getModalStoreState()

# # getTileStoreState = ->
#     all: TileStore.getAll()
#     info: TileStore.getInfo()

# getModalStoreState = ->
#     modals: ModalStore.getAll()

window.Game = Game = React.createClass
    displayName: 'Game'
    mixins: [
        mixins: [React.addons.LinkedStateMixin] # exposes this.linkState used in render
        Reflux.connect TileStore, "tiles"
        Reflux.connect ModalStore, "modals"
    ]
    getInitialState: ->
        tiles:
            value:
                all: []
                info: {}
        modals:
            value: {}

    componentDidMount: ->
        TileStore.update()
    #     TileStore.addChangeListener @_onTileStoreChange
    #     ModalStore.addChangeListener @_onModalStoreChange

    # componentWillUnmount: ->
    #     TileStore.removeChangeListener @_onTileStoreChange
    #     ModalStore.removeChangeListener @_onModalStoreChange

    # _onTileStoreChange: ->
        # tilesState = getTileStoreState()
        # if @state.info.win or @state.info.loss
            # queue -> ModalActions.toggle 'newGame'

    # _onModalStoreChange: ->
        # @setState getModalStoreState()

    render: ->
        parent = this
        console.log parent.linkState('tiles').value.info

        window.foo = ->
            parent.linkState 'tiles'

        info = React.createElement InfoComponent,
            key: 'info'
            info: parent.linkState('tiles').value.info

        tiles = React.createElement TilesComponent,
                key: 'tiles'
                tiles: parent.linkState('tiles').value.all

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
            info: parent.linkState('tiles').value.info
            modals: parent.linkState('modals').value

        R.div null, [
            overlays
            boardWrappper
            dashboard
        ]

module.exports = Game