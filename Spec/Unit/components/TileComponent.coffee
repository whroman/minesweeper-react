require 'coffee-script/register'
assert = require('chai').assert
require(process.cwd() + '/Spec/testdom')('<html><body></body></html>');
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
            assert.equal tile.component.getDOMNode().textContent, tile.mock.expected.text

    it 'should contain correct text after being clicked', ->
        for tile in tiles
            TestUtils.Simulate.click tile.component.getDOMNode(), uid: tile.mock.expected.uid

            tileIsMine = !!tile.mock.attrs.isMine

            queue ->
                if tileIsMine
                    assert.equal tile.component.getDOMNode().textContent, 'X'
                else
                    assert.equal tile.component.getDOMNode().textContent, String tile.mock.attrs.adjacentMines

    it 'should contain correct text after being flagged', ->
        for tile in tiles
            TestUtils.Simulate.click tile.component.getDOMNode(),
                uid: tile.mock.expected.uid
                shiftKey: true

            queue ->
                assert.equal tile.component.getDOMNode().textContent, '?'