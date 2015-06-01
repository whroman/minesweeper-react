jest.autoMockOff()

ModelTile = require './../../../../Resources/coffee/models/ModelTile.coffee'

describe 'ModelTile instantiation', ->
    it 'should require `x` and `y` as properties of instantiation argument object', ->
        expect( ->
            new ModelTile()
        ).toThrow()