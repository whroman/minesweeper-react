jest.autoMockOff()
freshStores = require './_freshStores'

describe 'TileStore.onTileToggleFlag(uid)', ->
    describe 'updates .numOfFlags property of obj returned by Store.getInfo()', ->
        it 'should update after a single flag', ->
            stores = freshStores (store) ->
                store.onTileToggleFlag '0-0'
                store

            for tileStore in stores
                expect tileStore.info.numOfFlags
                    .toBe 1

        it 'should update after a flag in each corner of board', ->
            stores = freshStores (store, test) ->
                store.onTileToggleFlag '0-0'
                store.onTileToggleFlag((test.x - 1) + '-0')
                store.onTileToggleFlag('0-' + (test.y - 1))
                store.onTileToggleFlag((test.x - 1) + '-' + (test.y - 1))
                store

            for tileStore in stores
                expect tileStore.info.numOfFlags
                    .toBe 4