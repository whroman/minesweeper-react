React = require 'react/addons'
Reflux = require 'reflux'
React.initializeTouchEvents true

ReactSlider = React.createFactory require 'react-slider'
R = React.DOM

ModalActions = require '../../actions/ModalActions.coffee'
TilesActions = require '../../actions/TilesActions.coffee'
NewGameActions = require '../../actions/NewGameActions.coffee'

NewGameStore = require '../../stores/NewGameStore.coffee'

map = (v, f, context) ->
    if v && v.map
        return v.map f, context
    return f.call context, v, 0

Slider = React.createClass
    displayName: 'Slider'
    getInitialState: ->
        return value: this.props.defaultValue

    onChange: (value) ->
        this.setState value: value
        console.log 'slider change'
        NewGameActions.change @props.field, value

    render: ->
        ReactSlider React.__spread({
            className: this.props.orientation + '-slider'
            pearling: true
            value: this.state.value
            onChange: this.onChange
        }, this.props), map this.state.value, (value, i) ->
            return R.div {
                key: i
            }, value


ModalOverlay = React.createClass
    displayName: 'ModalNewGame'

    mixins: [
        mixins: [React.addons.LinkedStateMixin] # exposes this.linkState used in render
        Reflux.connect NewGameStore, "data"
    ]

    getInitialState: ->
        data:
            x: 10
            y: 10

    componentDidMount: ->
        NewGameStore.update()

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
        console.log @state.data.x, @state.data.y
        TilesActions.newGame @state.data.x, @state.data.y, 25

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

        R.div key: 'new-game-buttons', buttons

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
            className: 'sliders'
        }, [
            R.div {
                className: 'slider'
                key: 'slider-x'
            }, [
                R.div key: 'slider-x-header', @state.data.x + ' tiles wide'
                React.createElement Slider, {
                    key: 'slider-x-ui'
                    orientation: 'horizontal'
                    field: 'x'
                    min: 5
                    defaultValue: 10
                    max: 20
                }
            ]
            R.div {
                className: 'slider'
                key: 'slider-y'
            }, [
                R.div key: 'slider-y-header', @state.data.y + ' tiles tall'
                React.createElement Slider, {
                    key: 'slider-y-ui'
                    orientation: 'horizontal'
                    field: 'y'
                    min: 5
                    defaultValue: 10
                    max: 20
                }
            ]
        ]

        R.div {
            key: 'new-game-modal'
            className: @getClass()
        }, [
            title
            sliders
            @renderButtons()
        ]

module.exports = ModalOverlay