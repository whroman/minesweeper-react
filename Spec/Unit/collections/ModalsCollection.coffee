assert = require('chai').assert
require 'coffee-script/register'
ModalsCollection = require process.cwd() + '/Resources/coffee/collections/ModalsCollection.coffee'

describe 'ModalsCollection', ->
    Modals = null

    beforeEach ->
        Modals = new ModalsCollection()
        Modals.set('foo')
        Modals.set('bar')
        Modals.set('star')

    it '.set(name)', ->
        for key, modal of Modals.show
            assert.equal modal, false

    it '.reset()', ->
        for key, modal of Modals.show
            Modals.show[key] = true

        Modals.reset()

        assert.deepEqual Modals.show, {
                foo: false
                bar: false
                star: false
            }

    it '.toggle(name)', ->
        Modals.toggle('foo')

        assert.deepEqual Modals.show, {
                foo: true
                bar: false
                star: false
            }

        Modals.toggle('bar')

        assert.deepEqual Modals.show, {
                foo: false
                bar: true
                star: false
            }

        Modals.toggle('star')

        assert.deepEqual Modals.show, {
                foo: false
                bar: false
                star: true
            }