jest.autoMockOff()

React = require 'react/addons'
assign = require 'object-assign'
TestUtils = React.addons.TestUtils

tests = require process.cwd() + '/Spec/Unit/_testGames.coffee'

describe 'TileStore', ->
    Store = require process.cwd() + '/Resources/coffee/stores/TileStore.coffee'
    stores = []
    beforeEach ->
        for test in tests
            Store.onNewGame test.x, test.y, test.mines

            stores.push
                test: test
                all: Store.getAll()
                info: Store.getInfo()

    describe 'onNewGame()', ->
        it 'should create correct board', ->
            for tileStore in stores
                expect tileStore.all.length
                    .toBe tileStore.test.x * tileStore.test.y

        it 'should update values returned by Store.getInfo()', ->
            for tileStore in stores
                expect tileStore.info.win
                    .toBe false

                expect tileStore.info.loss
                    .toBe false

                expect tileStore.info.numOfMines
                    .toBe tileStore.test.mines