jest.autoMockOff()

TilesCollection = require process.cwd() + '/Resources/coffee/collections/TilesCollection.coffee'
tests = require '../../_testGames.coffee'

describe 'TilesCollection.newGame(x, y, mines)', ->
    it 'should create a "board" with correct number of tiles and mines', ->
        for test in tests
            Tiles = new TilesCollection()
            Tiles.newGame test.x, test.y, test.mines

            expect Tiles.all.length
                .toBe test.x * test.y

            expect Tiles.numOfMines
                .toBe test.mines