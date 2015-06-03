ModalActions = require '../../actions/ModalActions.coffee'

R = React.DOM

ModalOverlay = React.createClass
    displayName: 'ModalInstructions'

    getClass: ->
        classes = [
            'message'
        ]

        if !@props.show
            classes.push 'hide'

        classes.join ' '

    clickHandler: ->
        ModalActions.toggle 'instructions'

    render: ->
        description = R.div {
            key: 'instructions-description'
        }, [
            R.div {
                key: 'instructions-header'
                className: 'border-bottom'
            }, 'how to play'

            R.div {
                key: 'instructions-details'
                className: 'border-bottom'
            }, [
                'the game is played by revealing tiles of the grid.'
                'if a selected tile contains a mine, the player loses the game.'
                'otherwise, a digit is revealed in the tile, indicating the number'
                'of mines located in the eight adjacent tiles.'
            ].join ' '

            R.div {
                key: 'instructions-commands'
            },
                R.span {
                    className: 'code'
                }, 'click'
                R.span null,
                    ' to reveal the squares of the grid.'

            R.div {
                className: 'border-bottom'
            }, '(your first click will never land on a mine)'
        ]

        controls = R.div {
            key: 'instructions-controls'
        }, [
                R.span {
                    className: 'code'
                }, 'shift + click'

                R.span null, ' or '

                R.span {
                    className: 'code'
                }, 'alt + click'

                R.span null, ' will "flag" a tile, helping you to remember where you think a mine is hidden'
        ]

        button = R.div {
            key: 'instructions-button'
        },
            R.div {
                className: 'button'
                onClick: @clickHandler
            }, 'got it!'

        R.div {
            key: 'modal'
            className: @getClass()
        }, [
            description
            controls
            button
        ]

module.exports = ModalOverlay