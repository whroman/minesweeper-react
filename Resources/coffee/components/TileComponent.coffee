TilesActions = require '../actions/TilesActions.coffee'

React = require 'react'
R = React.DOM

Tile = React.createClass
    displayName: 'Tile'

    render: ->
        R.li {
            className: this.getClass(),
            onClick: this.clickHandler
        }, R.span null, @getText()

    clickHandler: ($event) ->
        if !$event
            return TilesActions.tileClear @props.tile.model.uid

        flagKeyWasPressed = (
            $event.shiftKey is true or
            $event.altKey is true
        )

        if flagKeyWasPressed
            return TilesActions.tileToggleFlag @props.tile.model.uid
        else
            return TilesActions.tileClear @props.tile.model.uid

    isFirstColumn: ->
        @props.tile.model.x is 0

    hasBeenFlagged: ->
        @props.tile.model.isClear isnt true and
        @props.tile.model.isFlagged is true

    hasBeenCleared: ->
        @props.tile.model.isClear is true

    hasMine: ->
        @props.tile.model.isMine is true

    shouldDisplayMine: ->
        @hasBeenCleared() and
        @hasMine()

    hasZeroAdjacentMines: ->
        @props.tile.model.adjacentMines is 0 and
        # !@hasMine()
        @hasBeenCleared()

    getText: ->
        text = ''
        # if true
        if @shouldDisplayMine()
            text = 'X'
        else if @hasBeenCleared()
            text = @props.tile.model.adjacentMines
        else if @hasBeenFlagged()
            text = '?'

        text

    getClass: ->
        [
            'tile'
            # 'clear'
            if @isFirstColumn() then 'nth'
            if @hasBeenCleared() then 'clear'
            if @hasBeenFlagged() then 'flagged'
            if @shouldDisplayMine() then 'mine'
            if @hasZeroAdjacentMines() then 'zero'

        ].join(' ')

module.exports = Tile