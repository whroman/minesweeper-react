assert = require('chai').assert
require 'coffee-script/register'

freshStores = require './_freshStores'

describe 'TileStore.onClearSafeRandomTile()', ->
    describe 'when called once', ->
        stores = []

        beforeEach ->
            stores = freshStores (store, test) ->
                store.onClearSafeRandomTile()
                store

        it 'changes should appear in TileStore.getInfo().numOfUncleared', ->
            for tileStore in stores
                maxAmountOfUnclearedTiles = tileStore.all.length - tileStore.test.mines - 1
                assert.equal maxAmountOfUnclearedTiles >= tileStore.info.numOfUncleared, true

        it 'should not lose the game, according to TileStore.getInfo().loss', ->
            for tileStore in stores
                assert.equal tileStore.info.loss, false

    describe 'when called until game all tiles without mines have been cleared', ->
        stores = []

        beforeEach ->
            stores = freshStores (store, test) ->
                clearedTile = store.onClearSafeRandomTile()
                while clearedTile
                    clearedTile = store.onClearSafeRandomTile()
                store

        it 'changes should appear in TileStore.getInfo().win', ->
            for tileStore in stores
                assert.equal tileStore.info.win, true

        it 'changes should appear in TileStore.getInfo().loss', ->
            for tileStore in stores
                assert.equal tileStore.info.loss, false

        it 'changes should appear in TileStore.getInfo().numOfUncleared', ->
            for tileStore in stores
                assert.equal tileStore.info.numOfUncleared, 0