require 'coffee-script/register'
assert = require('chai').assert
TilesCollection = require process.cwd() + '/Resources/coffee/collections/TilesCollection.coffee'
tests = require '../../_testGames.coffee'

describe 'TilesCollection.clearNeighbors(tile)', ->
    it 'should clear all neighbors if given tile has 0 neighbors with mines', ->
        for test in tests
            # Init
            Tiles = new TilesCollection()
            Tiles.newGame test.x, test.y, test.mines

            for tile in Tiles.all
                tile.model.isMine = false

            for i in [1..test.mines]
                Tiles.all[i].isMine = true

            # Grab safe tile
            safeTile = Tiles.get
                adjacentMines: 0
                isMine: false

            if safeTile
                # Clear safeTile's neighboring tiles, but not safeTile itself
                Tiles.clearNeighbors safeTile

                clearedTiles = Tiles.getAll isClear: true

                tileIsOnCorner = -> (
                    safeTile.model.x is 0 and (
                        safeTile.model.y is 0 or
                        safeTile.model.y is test.y - 1
                    ) or
                    safeTile.model.x is test.x - 1 and (
                        safeTile.model.y is 0 or
                        safeTile.model.y is test.y - 1
                    )
                )

                tileIsOnEdge = -> (
                    safeTile.model.x is 0 or
                    safeTile.model.y is 0 or
                    safeTile.model.x is test.x - 1 or
                    safeTile.model.y is test.y - 1
                )

                minNumCleared = 9

                if tileIsOnCorner()
                    minNumCleared = 4
                else if tileIsOnEdge()
                    minNumCleared = 6

                # clearedTiles.length + 2
                # - One is to simulate isGreaterThan
                # - One is to offset the fact that safeTile itself is not cleared
                assert.isAbove clearedTiles.length + 2,
                    minNumCleared