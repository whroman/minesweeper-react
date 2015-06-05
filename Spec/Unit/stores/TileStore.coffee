jest.autoMockOff()

React = require 'react/addons'
TestUtils = React.addons.TestUtils

tests = require process.cwd() + '/Spec/Unit/_testGames.coffee'

describe 'TileStore', ->
    it 'newGame()', ->
        for test in tests
            tiles = require process.cwd() + '/Resources/coffee/stores/TileStore.coffee'
            tiles.newGame test.x, test.y, test.mine

            expect tiles.getAll().length