jest.autoMockOff()

ModelTile = require './../../../../Resources/coffee/models/ModelTile.coffee'
tests = require './testStubs.coffee'

describe 'ModelTile.toggleFlag', ->
    it 'should toggle `.model.isFlagged`', ->
        for test in tests
            tile = new ModelTile(test.attrs)
            tile.toggleFlag()
            expect tile.model.isFlagged
                .toBe(!test.attrs.isFlagged)