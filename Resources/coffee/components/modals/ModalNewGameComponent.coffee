React = require 'react'
Reflux = require 'reflux'
React.initializeTouchEvents true

R = React.DOM

ModalActions = require '../../actions/ModalActions.coffee'
TilesActions = require '../../actions/TilesActions.coffee'
NewGameStore = require '../../stores/NewGameStore.coffee'
SliderComponent = require '../SliderComponent.coffee'

ModalOverlay = React.createClass
    displayName: 'ModalNewGame'

    mixins: [Reflux.connect NewGameStore, "data"]

    getInitialState: ->
        data:
            x:
                value: 10
            y:
                value: 10
            mines:
                min: 10
                max: 50
                value: 25

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
        else if !@props.win and @props.loss
            return 'you lost...'

    clickHandlerNewGame: ->
        TilesActions.newGame @state.data.x.value, @state.data.y.value, @state.data.mines.value

    clickHandlerExitModal: ->
        ModalActions.reset()

    renderButtons: ->
        buttons = [
            R.div {
                key: 'new-game-start'
                className: 'button'
                onClick: @clickHandlerNewGame
            }, 'start!'
        ]

        if !@props.loss and !@props.win
            buttons.push R.div {
                key: 'new-game-resume'
                className: 'button'
                onClick: @clickHandlerExitModal
            }, 'resume...'

        buttons

    render: ->
        title = R.div {
                key: 'new-game-title-wrapper'
                className: 'border-bottom'
            },
                R.div {
                    key: 'new-game-title'
                    className: 'title'
                }, @getTitleText()

        sliders = R.div {
            key: 'slider'
            className: 'sliders'
        }, [
            R.div {
                key: 'slider-x'
                className: 'slider'
            }, [
                R.div key: 'slider-x-header', @state.data.x.value + ' tiles wide'
                React.createElement SliderComponent, {
                    key: 'slider-x-ui'
                    orientation: 'horizontal'
                    field: 'x'
                    min: 5
                    defaultValue: 10
                    max: 20
                }
            ]
            R.div {
                key: 'slider-y'
                className: 'slider'
            }, [
                R.div key: 'slider-y-header', @state.data.y.value + ' tiles tall'
                React.createElement SliderComponent, {
                    key: 'slider-y-ui'
                    orientation: 'horizontal'
                    field: 'y'
                    min: 5
                    defaultValue: 10
                    max: 20
                }
            ]
            R.div {
                key: 'slider-mines'
                className: 'slider'
            }, [
                R.div key: 'slider-mines-header', @state.data.mines.value + ' mines'
                React.createElement SliderComponent, {
                    key: 'slider-mines-ui'
                    orientation: 'horizontal'
                    field: 'mines'
                    min: @state.data.mines.min
                    defaultValue: @state.data.mines.value
                    value: @state.data.mines.value
                    max: @state.data.mines.max
                }
            ]
        ]

        R.div {
            key: 'new-game-modal'
            className: @getClass()
        }, [
            title
            sliders
            R.div key: 'new-game-buttons', @renderButtons()
        ]

module.exports = ModalOverlay