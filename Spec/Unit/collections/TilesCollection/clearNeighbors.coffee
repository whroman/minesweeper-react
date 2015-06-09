assert = require('chai').assert
require 'coffee-script/register'
TilesCollection = require process.cwd() + '/Resources/coffee/collections/TilesCollection.coffee'
tests = require '../../_testGames.coffee'

describe 'TilesCollection.clearNeighbors(tile)', ->
    it 'should clear all neighbors of given tile if it has 0 neighbors with mines', ->
        for test in tests
            # Init
            Tiles = new TilesCollection()
            Tiles.newGame test.x, test.y, test.mines

            for tile in Tiles.all
                tile.model.isMine = false

            for i in [1..test.mines]
                Tiles.all[i].isMine = true

            # Grab safe tile
            safeTiles = Tiles.getAll
                adjacentMines: 0
                isMine: false

            safeTile = safeTiles[0]

            if safeTile
                # Clear safe tile's neighboring tiles
                Tiles.clearNeighbors safeTile
                clearedTiles = Tiles.getAll isClear: true

                tileIsOnEdge = (
                    safeTile.model.x is 0 or
                    safeTile.model.y is 0 or
                    safeTile.model.x is test.x - 1 or
                    safeTile.model.y is test.y - 1
                )

                minNumCleared = 9

                if tileIsOnEdge
                    minNumCleared = 3

                assert.equal clearedTiles.length >= minNumCleared, true