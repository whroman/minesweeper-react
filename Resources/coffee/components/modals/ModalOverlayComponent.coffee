ModalActions = require '../../actions/ModalActions.coffee'
ModalInstructionsComponent = require './ModalInstructionsComponent.coffee'

R = React.DOM

ModalOverlay = React.createClass
    displayName: 'ModalOverlay'

    getClass: ->
        console.log (@props.modals)
        console.log @props.info.loss, @props.info.win
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
            React.createElement ModalInstructionsComponent, null
        ]

module.exports = ModalOverlay