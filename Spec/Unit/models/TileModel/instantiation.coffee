require 'coffee-script/register'
assert = require('chai').assert
TileModel = require process.cwd() + '/Resources/coffee/models/TileModel.coffee'

describe 'TileModel instantiation', ->
    it 'should require `x` and `y` as properties of instantiation argument object', ->
        assert.throw -> new TileModel()