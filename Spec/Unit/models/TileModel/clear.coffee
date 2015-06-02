jest.autoMockOff()

TileModel = require './../../../../Resources/coffee/models/TileModel.coffee'
tests = require './testStubs.coffee'

describe 'TileModel.clear', ->
    it 'should set `.model.isClear` to `true` and `.model.isFlagged` to `false`', ->
        for test in tests
            tile = new TileModel(test.attrs)
            tile.toggleFlag()
            expect tile.model.isFlagged
                .toBe(!test.attrs.isFlagged)