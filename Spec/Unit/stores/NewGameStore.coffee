assert = require('chai').assert
require 'coffee-script/register'

modals = ['newGame', 'instructions']
FF = [false, false]

NewGameStore = require process.cwd() + '/Resources/coffee/stores/NewGameStore.coffee'

clone = (obj) ->
    JSON.parse JSON.stringify obj

defaultData = clone NewGameStore.data

tests = [5, 15, 20, 25]

getStore = ->
    NewGameStore.data = clone defaultData
    NewGameStore

describe 'NewGameStore.onChange(key, val)', ->
    it 'should correctly set values onto `store.data.x.value`', ->
        for test in tests
            Store = getStore()
            Store.onChange 'x', test

            assert.equal Store.data.x.value, test
            assert.notEqual Store.data.mines.min, defaultData.mines.min
            assert.notEqual Store.data.mines.max, defaultData.mines.max

    it 'should correctly set values onto `store.data.y.value`', ->
        for test in tests
            Store = getStore()
            Store.onChange 'y', test
            assert.equal Store.data.y.value, test
            assert.notEqual Store.data.mines.min, defaultData.mines.min
            assert.notEqual Store.data.mines.max, defaultData.mines.max

    it 'should correctly set values onto `store.data.mines.value`', ->
        for test in tests
            Store = getStore()
            Store.onChange 'mines', test
            assert.equal Store.data.mines.value, test

    it 'should fail if given incorrect `key`', ->
        Store = getStore()
        assert.throw ->
            Store.onChange 'foo', 10