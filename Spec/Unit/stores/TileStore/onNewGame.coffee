jest.autoMockOff()
freshStores = require './_freshStores'

describe 'TileStore.onNewGame()', ->
    stores = freshStores()
    it 'should create correct board', ->
        for tileStore in stores
            expect tileStore.all.length
                .toBe tileStore.test.x * tileStore.test.y