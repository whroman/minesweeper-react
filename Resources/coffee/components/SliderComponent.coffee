React = require 'react/addons'
ReactSlider = React.createFactory require 'react-slider'

NewGameActions = require '../actions/NewGameActions.coffee'

SliderComponent = React.createClass
    displayName: 'Slider'
    getInitialState: ->
        data:
            value: this.props.defaultValue

    onChange: (value) ->
        this.setState
            data:
                value: value

        NewGameActions.change @props.field, value

    render: ->
        value = @props.value || @state.data.value

        ReactSlider React.__spread({
            className: this.props.orientation + '-slider'
            pearling: true
            value: value
            onChange: this.onChange
        }, this.props), null

module.exports = SliderComponent