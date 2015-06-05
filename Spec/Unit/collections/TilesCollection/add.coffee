jest.autoMockOff()

TilesCollection = require process.cwd() + '/Resources/coffee/collections/TilesCollection.coffee'

tests = [
    {
        x: 0
        y: 0
    }
    {
        x: 3
        y: 4
        isClear: true
        isFlagged: true
        isMine: true
    }
    {
        x: 1
        y: 9
        isClear: false
        isFlagged: false
        isMine: true
    }
    {
        x: 35
        y: 46
        isClear: true
        isFlagged: false
        isMine: true
    }
    {
        x: 13
        y: 14
        isClear: false
        isFlagged: true
        isMine: false
    }
]

describe 'TilesCollection.add(tileAttrs)', ->
    it 'should add a tiles to `.all` with the correct attributes', ->
        for test in tests
            Tiles = new TilesCollection()
            tile = Tiles.add test

            for key, val of test
                expect val
                    .toBe tile.model[key]