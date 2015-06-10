assert = require('chai').assert
require 'coffee-script/register'

modals = ['newGame', 'instructions']
FF = [false, false]

freshStore = (cb) ->
    Store = require process.cwd() + '/Resources/coffee/stores/ModalStore.coffee'
    Store.reset()
    if cb then Store = cb Store
    return Store.show

describe 'ModalStore.onToggle(modalName)', ->
    it 'should set ModalStore.show[modalName] to `true` and other `.show` props to `false`', ->
        for modal in modals
            ModalStore = freshStore (store) ->
                store.onToggle modal
                return store

            assert.equal ModalStore[modal], true

            for otherModal in modals
                if otherModal isnt modal
                    assert.equal ModalStore[otherModal], false

describe 'ModalStore.onReset()', ->
    it 'should set all vals of `.show` object to `false`', ->
        ModalStore = freshStore (store) ->
            for modal of store.show
                store.show[modal] = true
            store.onReset()
            return store

        assert.deepEqual [
            ModalStore.newGame
            ModalStore.instructions
        ], FF

describe 'ModalStore.onChange(modalName)', ->
    it 'if called WITHOUT argument, should set all vals of `.show` object to `false`', ->
        ModalStore = freshStore (store) ->
            for modal of store.show
                store.show[modal] = true
            store.onChange()
            return store

        assert.deepEqual [
            ModalStore.newGame
            ModalStore.instructions
        ], FF

    it 'if called WITH argument, should set `.show[modalName]` to `true`', ->
        for modal in modals
            ModalStore = freshStore (store) ->
                store.onChange modal
                return store

            assert.equal ModalStore[modal], true

            for otherModal in modals
                if otherModal isnt modal
                    assert.equal ModalStore[otherModal], false