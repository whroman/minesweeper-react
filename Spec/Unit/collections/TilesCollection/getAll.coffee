require 'coffee-script/register'
assert = require('chai').assert
TilesCollection = require process.cwd() + '/Resources/coffee/collections/TilesCollection.coffee'
tests = require '../../_testGames.coffee'
games = []

describe 'TilesCollection.getAll(attrs)', ->
    beforeEach ->
        games = []
        for test in tests
            Tiles = new TilesCollection()
            Tiles.newGame test.x, test.y, test.mines
            games.push {
                args: test
                tiles: Tiles
            }

    it 'should return all tiles with given `x` attr', ->
        for game in games
            numOfTiles = game.tiles.getAll(x: 0).length
            assert.equal numOfTiles, game.args.y

    it 'should return all tiles with given `y` attr', ->
        for game in games
            numOfTiles = game.tiles.getAll(y: 0).length
            assert.equal numOfTiles, game.args.x

    it 'should return all tiles with given `isMine` attr', ->
        for game in games
            numOfMineTiles = game.tiles.getAll(isMine: true).length
            numOfNotMineTiles = game.tiles.getAll(isMine: false).length

            assert.equal numOfMineTiles, game.args.mines

            assert.equal numOfNotMineTiles, game.tiles.all.length - game.args.mines

    it 'should return all tiles with given `isClear` attr', ->
        for game in games
            numOfClearTiles = game.tiles.getAll(isClear: true).length
            numOfNotClearTiles = game.tiles.getAll(isClear: false).length

            assert.equal numOfClearTiles, 0

            assert.equal numOfNotClearTiles, game.tiles.all.length


    it 'should return all tiles with given `isFlagged` attr', ->
        for game in games
            assert.equal game.tiles.getAll(isFlagged: true).length, 0

        for game in games
            assert.equal game.tiles.getAll(isFlagged: false).length, game.tiles.all.length