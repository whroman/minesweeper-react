jest.autoMockOff()
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
                expect maxAmountOfUnclearedTiles >= tileStore.info.numOfUncleared
                    .toBe true

        it 'should not lose the game, according to TileStore.getInfo().loss', ->
            for tileStore in stores
                expect tileStore.info.loss
                    .toBe false

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
                expect tileStore.info.win
                    .toBe true

        it 'changes should appear in TileStore.getInfo().loss', ->
            for tileStore in stores
                expect tileStore.info.loss
                    .toBe false

        it 'changes should appear in TileStore.getInfo().numOfUncleared', ->
            for tileStore in stores
                expect tileStore.info.numOfUncleared
                    .toBe 0