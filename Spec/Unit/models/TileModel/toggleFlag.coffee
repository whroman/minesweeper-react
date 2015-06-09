assert = require('chai').assert
require 'coffee-script/register'
TileModel = require process.cwd() + '/Resources/coffee/models/TileModel.coffee'
tests = require process.cwd() + '/Spec/Unit/_testTiles.coffee'

describe 'TileModel.toggleFlag', ->
    it 'should toggle `.model.isFlagged`', ->
        for test in tests
            tile = new TileModel(test.attrs)
            tile.toggleFlag()
            assert.equal tile.model.isFlagged, !test.attrs.isFlagged