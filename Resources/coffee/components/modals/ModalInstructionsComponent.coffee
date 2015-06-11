React = require 'react'
R = React.DOM

ModalActions = require '../../actions/ModalActions.coffee'

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
                key: 'instructions-click'
            },
                R.span {
                    key: 'instructions-click-code'
                    className: 'code'
                }, 'click'
                R.span {
                    key: 'instructions-click-text'
                },
                    ' to reveal the squares of the grid.'

            R.div {
                key: 'instructions-click-hint'
                className: 'border-bottom'
            }, '(your first click will never land on a mine)'
        ]

        controls = R.div {
            key: 'instructions-controls'
        }, [
                R.span {
                    key: 'instructions-controls-code1'
                    className: 'code'
                }, 'shift + click'

                R.span {
                    key: 'instructions-controls-text1'
                }, ' or '

                R.span {
                    key: 'instructions-controls-code2'
                    className: 'code'
                }, 'alt + click'

                R.span {
                    key: 'instructions-controls-text2'
                }, ' will "flag" a tile, helping you to remember where you think a mine is hidden'
        ]

        button = R.div {
            key: 'instructions-button'
        },
            R.div {
                className: 'button'
                onClick: @clickHandler
            }, 'got it!'

        R.div {
            key: 'instructions-modal'
            className: @getClass()
        }, [
            description
            controls
            button
        ]

module.exports = ModalOverlay