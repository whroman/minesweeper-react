jest.autoMockOff()

React = require 'react/addons'
TestUtils = React.addons.TestUtils

tests = require process.cwd() + '/Spec/Unit/_testTiles.coffee'

TileModel = require process.cwd() + '/Resources/coffee/models/TileModel.coffee'
TileComponent = require process.cwd() + '/Resources/coffee/components/TileComponent.coffee'

describe 'TileComponent', ->
    tiles = []

    beforeEach ->
        for test in tests
            model = new TileModel test.attrs

            tileEl = React.createElement TileComponent, {
                    tile: model
                }

            tileInDom = TestUtils.renderIntoDocument tileEl
            component =  TestUtils.findRenderedDOMComponentWithTag tileInDom, 'li'
            tiles.push
                mock: test
                component: component

    it 'should contain correct text after init', ->
        for tile in tiles
            expect tile.component.getDOMNode().textContent
                .toBe tile.mock.expected.text