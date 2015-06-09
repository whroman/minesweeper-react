jest.autoMockOff()
freshStores = require './_freshStores'

describe 'TileStore.onNewGame()', ->
    stores = freshStores()
    it 'should create correct board', ->
        for tileStore in stores
            expect tileStore.all.length
                .toBe tileStore.test.x * tileStore.test.y

    it 'the game should be neither won or lost', ->
        for tileStore in stores
            expect [tileStore.info.win, tileStore.info.loss]
                .toEqual [false, false]