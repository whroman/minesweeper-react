jest.autoMockOff()

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
            expect modal
                .toBe false

    it '.reset()', ->
        for key, modal of Modals.show
            Modals.show[key] = true

        Modals.reset()

        expect Modals.show
            .toEqual {
                foo: false
                bar: false
                star: false
            }

    it '.toggle(name)', ->
        Modals.toggle('foo')

        expect Modals.show
            .toEqual {
                foo: true
                bar: false
                star: false
            }

        Modals.toggle('bar')

        expect Modals.show
            .toEqual {
                foo: false
                bar: true
                star: false
            }

        Modals.toggle('star')

        expect Modals.show
            .toEqual {
                foo: false
                bar: false
                star: true
            }