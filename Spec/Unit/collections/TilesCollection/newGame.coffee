assert = require('chai').assert
require 'coffee-script/register'
TilesCollection = require process.cwd() + '/Resources/coffee/collections/TilesCollection.coffee'
tests = require '../../_testGames.coffee'

describe 'TilesCollection.newGame(x, y, mines)', ->
    it 'should create a "board" with correct number of tiles and mines', ->
        for test in tests
            Tiles = new TilesCollection()
            Tiles.newGame test.x, test.y, test.mines

            assert.equal Tiles.all.length, test.x * test.y

            assert.equal Tiles.numOfMines, test.mines