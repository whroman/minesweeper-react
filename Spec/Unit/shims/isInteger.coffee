require 'coffee-script/register'
assert = require('chai').assert

tests = {}
tests.true = [
    0
    1
    1.0
    11
    111
]

tests.false = [
    0.1
    1.1
    true
    false
    undefined
    null
    Infinity
    '0'
    '1'
    'foo'
    '0.foo'
    'foo.0'
]

shimNative = require(process.cwd() + '/Resources/coffee/shims/isInteger.coffee')()
shim = require(process.cwd() + '/Resources/coffee/shims/isInteger.coffee')(true)

describe 'Number.isInteger shim', ->
    describe 'when .isInteger was already defined', ->

        it 'should return `true` for values that are integers', ->
            for test in tests.true
                o = shimNative test
                assert.isTrue o, test

        it 'should return `false` for values that are not integers', ->
            for test in tests.false
                o = shimNative test
                assert.isFalse o, test

    describe 'when .isInteger was *not* already defined', ->

        it 'should return `true` for values that are integers', ->
            for test in tests.true
                o = shim test
                assert.isTrue o, test

        it 'should return `false` for values that are not integers', ->
            for test in tests.false
                o = shim test
                assert.isFalse o, test

