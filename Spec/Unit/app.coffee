require 'coffee-script/register'
assert = require('chai').assert

require(process.cwd() + '/Spec/testDOM')('<html><body><div id="minesweeper"></div></body></html>');
require process.cwd() + '/Resources/coffee/app.coffee'

describe 'App', ->
    it 'should render', ->
        id = document.getElementById 'wrapper'
        assert.isDefined id
