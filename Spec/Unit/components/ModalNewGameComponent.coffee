require 'coffee-script/register'
assert = require('chai').assert
require(process.cwd() + '/Spec/testDOM')('<html><body></body></html>');
React = require 'react/addons'
TestUtils = React.addons.TestUtils

# require(process.cwd() + '/Spec/testDOM')('<html><body><div id="new-game-controller"></div></body></html>');
NewGameComponent = require process.cwd() + '/Resources/coffee/components/modals/ModalNewGameComponent.coffee'


tests = [
    {
        win: false
        loss: false
        show: true
    }
    {
        win: true
        loss: false
        show: true
    }
    {
        win: false
        loss: true
        show: true
    }
]

describe 'ModalNewGameComponent', ->
    NewGameInstances = []

    beforeEach ->
        for testProps in tests
            el = React.createElement NewGameComponent, testProps
            elInDom = TestUtils.renderIntoDocument el
            instances = TestUtils.scryRenderedComponentsWithType elInDom, NewGameComponent
            NewGameInstances.push instances[0]

     afterEach (done) ->
        React.unmountComponentAtNode document.body  # Assuming mounted to document.body
        document.body.innerHTML = ""                # Just to be sure :-P
        setTimeout done
        NewGameInstances = []

    it 'should display only one button if game has been won or lost, two buttons otherwise', ->
        for instance in NewGameInstances
            buttons =  instance.renderButtons()

            expectedBuuttonsLength = 2

            if instance.props.win || instance.props.loss
                expectedBuuttonsLength = 1

            assert.equal buttons.length, expectedBuuttonsLength, instance.props