module.exports = [
    {
        attrs:
            x: 0
            y: 0
            adjacentMines: 0

        event:
            shiftKey: false
            altKey: true

        expected:
            uid: '0-0'
            text: ''
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

        expected:
            uid: '10-1'
            text: 'X'

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

        expected:
            uid: '1-11'
            text: '?'
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

        expected:
            uid: '11-11'
            text: '4'
    },
]