ModalActions = require '../../actions/ModalActions.coffee'

R = React.DOM

ModalOverlay = React.createClass
    displayName: 'ModalInstructions'

    getClass: ->
        classes = [
            'message'
        ]

        if !@props.modals.instructions
            classes.push 'hide'

        classes.join ' '

    clickHandler: ->
        ModalActions.toggle 'instructions'

    render: ->
        R.div {
            key: 'modal'
            className: @getClass()
        }, [
            description
            controls
            R.div null,
                R.div {
                    className: 'button'
                    onClick: @clickHandler
                }, 'got it!'
        ]

module.exports = ModalOverlay