assert = require('chai').assert
require 'coffee-script/register'

freshStores = require './_freshStores'

describe 'TileStore.onNewGame()', ->
    stores = freshStores()
    it 'should create correct board', ->
        for tileStore in stores
            assert.equal tileStore.all.length, tileStore.test.x * tileStore.test.y

    it 'the game should be neither won or lost', ->
        for tileStore in stores
            assert.deepEqual [tileStore.info.win, tileStore.info.loss], [false, false]