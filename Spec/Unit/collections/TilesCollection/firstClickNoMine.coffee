jest.autoMockOff()

TilesCollection = require process.cwd() + '/Resources/coffee/collections/TilesCollection.coffee'
tests = require '../../_testGames.coffee'

describe 'TilesCollection.firstClickNoMine()', ->
    it 'should unset `isMine` if the given tile has a mine', ->
        for test in tests
            Tiles = new TilesCollection()
            Tiles.newGame test.x, test.y, test.mines

            tileWithMine = Tiles.get(isMine: true)

            Tiles.noMineFirstClick tileWithMine

            expect tileWithMine.model.isMine
                .toBe false

    it 'should set a random, clear tile as having a mine', ->
        for test in tests
            Tiles = new TilesCollection()
            Tiles.newGame test.x, test.y, test.mines

            tileWithMine = Tiles.get(isMine: true)

            Tiles.noMineFirstClick tileWithMine

            # the same amount of mines should exist on the board as did initially
            expect Tiles.getAll(isMine: true).length
                .toBe test.mines