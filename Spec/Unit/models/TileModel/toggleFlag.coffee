jest.autoMockOff()

TileModel = require './../../../../Resources/coffee/models/TileModel.coffee'
tests = require './testStubs.coffee'

describe 'TileModel.toggleFlag', ->
    it 'should toggle `.model.isFlagged`', ->
        for test in tests
            tile = new TileModel(test.attrs)
            tile.toggleFlag()
            expect tile.model.isFlagged
                .toBe(!test.attrs.isFlagged)