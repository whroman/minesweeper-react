jest.autoMockOff()

TileModel = require process.cwd() + '/Resources/coffee/models/TileModel.coffee'
tests = require './_tests.coffee'

describe 'TileModel.set', ->

    it 'should properly set given attributes', ->
        for test in tests
            tile = new TileModel(test.attrs)

            for attr of test.attrs
                expect tile.model[attr]
                    .toBe(test.attrs[attr])

    it 'should properly set `.model.uid` based off of `x` and `y` class arguments', ->
        for test in tests
            tile = new TileModel(test.attrs)

            expect tile.model.uid
                .toBe(test.expectedUid)