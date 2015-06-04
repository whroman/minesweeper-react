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
            x: 9
            y: 1
            isMine: true
            isClear: true
            isFlagged: false
            adjacentMines: 3

        event:
            shiftKey: true
            altKey: false

        expected:
            uid: '9-1'
            text: 'X'

    },
    {
        attrs:
            x: 1
            y: 9
            isMine: false
            isClear: false
            isFlagged: true
            adjacentMines: 6

        event:
            shiftKey: false
            altKey: false

        expected:
            uid: '1-9'
            text: '?'
    },
    {
        attrs:
            x: 9
            y: 9
            isMine: false
            isClear: true
            isFlagged: false
            adjacentMines: 4

        event:
            shiftKey: true
            altKey: true

        expected:
            uid: '9-9'
            text: '4'
    },
]