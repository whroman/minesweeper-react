R = React.DOM

ModalOverlay = React.createClass
    displayName: 'ModalOverlay'

    getClass: ->
        console.log @props.info.loss, @props.info.win
        if @props.info.loss or @props.info.win
            return ''
        return 'hide'


    render: ->
        R.div {
            id: 'overlay'
            className: @getClass()
        }, null

module.exports = ModalOverlay