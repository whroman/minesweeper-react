React = require 'react'

ModalActions = require '../../actions/ModalActions.coffee'
InstructionsComponent = require './ModalInstructionsComponent.coffee'
NewGameComponent = require './ModalNewGameComponent.coffee'

R = React.DOM

ModalOverlay = React.createClass
    displayName: 'ModalOverlay'

    getClass: ->
        if @props.modals and @props.modals.newGame
            return ''
        else if @props.modals and @props.modals.instructions
            return ''
        return 'hide'

    resetHandler: ->
        # Client should not be allowed to exit the modal by clicking the overlay
        #   if the game has been won or lost
        ### istanbul ignore else ###
        if !@props.info.loss && !@props.info.win
            ModalActions.reset()

    render: ->
        overlay = R.div {
            id: 'overlay'
            key: 'overlay'
            className: @getClass()
            onClick: @resetHandler
        }, null

        components = [overlay]

        components.push React.createElement InstructionsComponent, {
            key: 'modal-instructions'
            show: @props.modals.instructions
        }

        components.push React.createElement NewGameComponent, {
            key: 'modal-new-game'
            show: @props.modals.newGame
            win: @props.info.win
            loss: @props.info.loss
        }

        R.div null, components

module.exports = ModalOverlay