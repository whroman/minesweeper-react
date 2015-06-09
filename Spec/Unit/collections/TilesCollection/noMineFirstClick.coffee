require 'coffee-script/register'
assert = require('chai').assert
TilesCollection = require process.cwd() + '/Resources/coffee/collections/TilesCollection.coffee'
tests = require '../../_testGames.coffee'

describe 'TilesCollection.noMineFirstClick()', ->
    it 'should unset `isMine` if the given tile has a mine', ->
        for test in tests
            Tiles = new TilesCollection()
            Tiles.newGame test.x, test.y, test.mines

            tileWithMine = Tiles.get(isMine: true)

            Tiles.noMineFirstClick tileWithMine

            assert.equal tileWithMine.model.isMine, false

    it 'should set a random, clear tile as having a mine', ->
        for test in tests
            Tiles = new TilesCollection()
            Tiles.newGame test.x, test.y, test.mines

            tileWithMine = Tiles.get(isMine: true)

            Tiles.noMineFirstClick tileWithMine

            # the same amount of mines should exist on the board as did initially
            assert.equal Tiles.getAll(isMine: true).length, test.mines