module.exports = [
    {
        attrs:
            x: 0
            y: 0

        expectedUid: '0-0'

        event:
            shiftKey: false
            altKey: true
    },
    {
        attrs:
            x: 10
            y: 1
            isMine: true
            isClear: true
            isFlagged: false
            adjacentMines: 3

        event:
            shiftKey: true
            altKey: false

        expectedUid: '10-1'
    },
    {
        attrs:
            x: 1
            y: 11
            isMine: false
            isClear: false
            isFlagged: true
            adjacentMines: 6

        event:
            shiftKey: false
            altKey: false

        expectedUid: '1-11'
    },
    {
        attrs:
            x: 11
            y: 11
            isMine: false
            isClear: true
            isFlagged: false
            adjacentMines: 4

        event:
            shiftKey: true
            altKey: true

        expectedUid: '11-11'
    },
]