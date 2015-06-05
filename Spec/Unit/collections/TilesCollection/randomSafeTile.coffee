jest.autoMockOff()

TilesCollection = require process.cwd() + '/Resources/coffee/collections/TilesCollection.coffee'
tests = require '../../_testGames.coffee'

describe 'TilesCollection.randomSafeTile()', ->
    it 'should return a tile that does not contain a mine', ->
        for test in tests
            Tiles = new TilesCollection()
            Tiles.newGame test.x, test.y, test.mines

            safeTile = Tiles.randomSafeTile()

            expect safeTile.model.isMine
                .toBe false