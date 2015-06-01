jest.autoMockOff()

ModelTile = require './../../../../Resources/coffee/models/ModelTile.coffee'
tests = require './testStubs.coffee'

describe 'ModelTile.clear', ->
    it 'should set `.model.isClear` to `true` and `.model.isFlagged` to `false`', ->
        for test in tests
            tile = new ModelTile(test.attrs)
            tile.toggleFlag()
            expect tile.model.isFlagged
                .toBe(!test.attrs.isFlagged)