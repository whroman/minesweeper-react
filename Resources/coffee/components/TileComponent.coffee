TileActions = require '../actions/TileActions.coffee'

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
            return TileActions.clear @props.tile.model.uid

        flagKeyWasPressed = (
            $event.shiftKey is true or
            $event.altKey is true
        )

        if flagKeyWasPressed
            return TileActions.toggleFlag @props.tile.model.uid
        else
            return TileActions.clear @props.tile.model.uid

    isFirstColumn: ->
        this.props.tile.model.x is 0

    hasBeenFlagged: ->
        this.props.tile.model.isClear isnt true and
        this.props.tile.model.isFlagged is true

    hasBeenCleared: ->
        this.props.tile.model.isClear is true

    hasMine: ->
        this.props.tile.model.isMine is true

    shouldDisplayMine: ->
        @hasMine() and
        @hasBeenCleared()

    hasZeroAdjacentMines: ->
        @props.tile.model.adjacentMines is 0 and
        !@hasMine()
        # @hasBeenCleared()

    getText: ->
        text = @props.tile.model.adjacentMines
        if @hasBeenFlagged()
            text = '?'
        else if @shouldDisplayMine()
            text = 'X'
        text

    getClass: ->
        [
            'tile'
            if @isFirstColumn() then 'nth'
            if @hasBeenCleared() then 'clear'
            if @hasBeenFlagged() then 'flagged'
            if @shouldDisplayMine() then 'mine'
            if @hasZeroAdjacentMines() then 'clear zero'

        ].join(' ')

module.exports = Tile