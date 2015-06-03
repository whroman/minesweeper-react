ModalActions = require '../../actions/ModalActions.coffee'
TilesActions = require '../../actions/TilesActions.coffee'

R = React.DOM

ModalOverlay = React.createClass
    displayName: 'ModalNewGame'

    getClass: ->
        classes = [
            'message'
        ]

        if !@props.show
            classes.push 'hide'

        classes.join ' '

    getTitleText: ->
        if @props.show and !@props.win and !@props.loss
            return 'new game?'
        else if @props.win and !@props.loss
            return 'you won!'
        else if !@props.win and !@props.win
            return 'you lost...'

    clickHandlerNewGame: ->
        TilesActions.newGame()

    clickHandlerExitModal: ->
        ModalActions.reset()

    renderButtons: ->
        buttons = [
            R.div {
                className: 'button'
                onClick: @clickHandlerNewGame
            }, 'start!'
        ]

        if !@props.loss
            buttons.push R.div {
                className: 'button'
                onClick: @clickHandlerExitModal
            }, 'resume!'

        R.div null, buttons

    render: ->
        title = R.div null,
            R.div {
                className: 'border-bottom'
            },
                R.div {
                    className: 'title'
                }, @getTitleText()

        R.div {
            key: 'modal'
            className: @getClass()
        }, [
            title
            @renderButtons()
        ]

module.exports = ModalOverlay