require 'coffee-script/register'
assert = require('chai').assert

freshStores = require './_freshStores'

describe 'TileStore.onTileClear(uid)', ->
    describe 'updates .numOfUncleared property of obj returned by Store.getInfo()', ->
        it 'should update after a single clear', ->
            stores = freshStores (store) ->
                store.onTileClear '0-0'
                store

            for tileStore in stores
                expectedMinTilesCleared = tileStore.all.length - tileStore.info.numOfMines - 1
                assert.equal expectedMinTilesCleared >= tileStore.info.numOfUncleared, true

        it 'should update after a clear in each corner of board', ->
            stores = freshStores (store, test) ->
                store.onTileClear '0-0'
                store.onTileClear((test.x - 1) + '-0')
                store.onTileClear('0-' + (test.y - 1))
                store.onTileClear((test.x - 1) + '-' + (test.y - 1))
                store

            for tileStore in stores
                expectedMinTilesCleared = tileStore.all.length - tileStore.info.numOfMines - 4
                assert.equal expectedMinTilesCleared >= tileStore.info.numOfUncleared, true

    describe 'updates .loss property of obj returned by Store.getInfo()', ->
        it 'should update if a tile with a mine is cleared', ->
            stores = freshStores (store, test) ->
                tileWithMine = store.get isMine: true
                store.onTileClear tileWithMine.model.uid
                store

            for tileStore in stores
                assert.equal tileStore.info.loss, true

    describe 'updates .win property of obj returned by Store.getInfo()', ->
        it 'should update if all tiles without mines are cleared', ->
            stores = freshStores (store, test) ->
                safeTiles = store.getAll isMine: false
                for safeTile in safeTiles
                    store.onTileClear safeTile.model.uid
                store

            for tileStore in stores
                assert.equal tileStore.info.win, true