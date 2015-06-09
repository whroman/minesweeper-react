assert = require('chai').assert
require 'coffee-script/register'
TileModel = require process.cwd() + '/Resources/coffee/models/TileModel.coffee'
tests = require process.cwd() + '/Spec/Unit/_testTiles.coffee'

describe 'TileModel.set', ->

    it 'should properly set given attributes', ->
        for test in tests
            tile = new TileModel(test.attrs)

            for attr of test.attrs
                assert.equal tile.model[attr], test.attrs[attr]

    it 'should properly set `.model.uid` based off of `x` and `y` class arguments', ->
        for test in tests
            tile = new TileModel(test.attrs)

            assert.equal tile.model.uid, test.expected.uid