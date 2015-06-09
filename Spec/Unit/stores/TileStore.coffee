jest.autoMockOff()

React = require 'react/addons'
assign = require 'object-assign'
TestUtils = React.addons.TestUtils

tests = require process.cwd() + '/Spec/Unit/_testGames.coffee'
Store = require process.cwd() + '/Resources/coffee/stores/TileStore.coffee'

freshStores = (cb) ->
    stores = []
    for test in tests
        Store.onNewGame test.x, test.y, test.mines

        if cb
            Store = cb Store, test

        stores.push
            test: test
            all: Store.getAll()
            info: Store.getInfo()
    return stores

describe 'TileStore', ->
    describe 'onNewGame()', ->
        stores = freshStores()
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

    describe 'onTileToggleFlag(uid)', ->
        describe 'updates .numOfFlags property of obj returned by Store.getInfo()', ->
            it 'should update after a single flag', ->
                stores = freshStores (store) ->
                    store.onTileToggleFlag '0-0'
                    store

                for tileStore in stores
                    expect tileStore.info.numOfFlags
                        .toBe 1

            it 'should update after a flag in each corner of board', ->
                stores = freshStores (store, test) ->
                    store.onTileToggleFlag '0-0'
                    store.onTileToggleFlag((test.x - 1) + '-0')
                    store.onTileToggleFlag('0-' + (test.y - 1))
                    store.onTileToggleFlag((test.x - 1) + '-' + (test.y - 1))
                    store

                for tileStore in stores
                    expect tileStore.info.numOfFlags
                        .toBe 4