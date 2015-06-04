React = require 'react/addons'

ModalActions = require '../../actions/ModalActions.coffee'
InstructionsComponent = require './ModalInstructionsComponent.coffee'
NewGameComponent = require './ModalNewGameComponent.coffee'

R = React.DOM

ModalOverlay = React.createClass
    displayName: 'ModalOverlay'

    getClass: ->
        if @props.modals.newGame
            return ''
        else if @props.modals.instructions
            return ''
        return 'hide'

    resetHandler: ->
        if !@props.info.loss && !@props.info.win
            ModalActions.reset()

    instructionsHandler: ->
        ModalActions.toggle 'instructions'

    render: ->
        overlay = R.div {
                id: 'overlay'
                key: 'overlay'
                className: @getClass()
                onClick: @resetHandler
            }, null

        R.div null, [
            overlay
            React.createElement InstructionsComponent, {
                key: 'modal-instructions'
                show: @props.modals.instructions
            }
            React.createElement NewGameComponent, {
                key: 'modal-new-game'
                show: @props.modals.newGame
                win: @props.info.win
                loss: @props.info.loss
            }
        ]

module.exports = ModalOverlay