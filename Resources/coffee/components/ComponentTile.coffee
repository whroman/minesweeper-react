R = React.DOM

Tile = React.createClass
    displayName: 'Tile'

    componentDidMount: ->
        @props.tile.model.index = @props.index

    render: ->
        R.li {
            className: this.getClass(),
            onClick: this.clickHandler
        }, R.span null, @getText()

    toggleFlag: ->
        @setState isFlagged: !@props.tile.model.isFlagged

    clear: ->
        @setState(
            @setState isClear: true
            @setState isFlagged: false
        )

    clickHandler: ($event) ->
        this.props.tile.click($event)

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