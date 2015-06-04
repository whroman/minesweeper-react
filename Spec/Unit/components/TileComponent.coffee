jest.autoMockOff()

React = require 'react/addons'
TestUtils = React.addons.TestUtils

tests = require process.cwd() + '/Spec/Unit/_testTiles.coffee'
queue = (fn) -> setTimeout fn, 0

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

    it 'should contain correct text after being clicked', ->
        for tile in tiles
            TestUtils.Simulate.click tile.component.getDOMNode(), uid: tile.mock.expected.uid

            tileIsMine = !!tile.mock.attrs.isMine

            queue ->
                if tileIsMine
                    expect tile.component.getDOMNode().textContent
                        .toBe 'X'
                else
                    expect tile.component.getDOMNode().textContent
                        .toBe String tile.mock.attrs.adjacentMines

    it 'should contain correct text after being flagged', ->
        for tile in tiles
            TestUtils.Simulate.click tile.component.getDOMNode(),
                uid: tile.mock.expected.uid
                shiftKey: true

            queue ->
                expect tile.component.getDOMNode().textContent
                    .toBe '?'