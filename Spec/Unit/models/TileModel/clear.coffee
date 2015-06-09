require 'coffee-script/register'
assert = require('chai').assert
TileModel = require process.cwd() + '/Resources/coffee/models/TileModel.coffee'
tests = require process.cwd() + '/Spec/Unit/_testTiles.coffee'

describe 'TileModel.clear', ->
    it 'should set `.model.isClear` to `true` and `.model.isFlagged` to `false`', ->
        for test in tests
            tile = new TileModel(test.attrs)
            tile.toggleFlag()
            assert.equal tile.model.isFlagged, !test.attrs.isFlagged