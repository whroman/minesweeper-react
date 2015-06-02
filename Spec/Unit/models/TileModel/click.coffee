jest.autoMockOff()

TileModel = require './../../../../Resources/coffee/models/TileModel.coffee'
tests = require './testStubs.coffee'

describe 'TileModel.click($event)', ->
    it 'should call `.toggleFlag()` if `$event` has `.shiftKey` OR `.altKey` set to `true`', ->
        for test in tests
            if test.event.shiftKey or test.event.altKey
                tile = new TileModel(test.attrs)
                spyOn tile, 'toggleFlag'
                tile.click test.event
                expect tile.toggleFlag
                    .toHaveBeenCalled()

    it 'should call `.clear()` if `$event` has `.shiftKey` AND `.altKey` set to `false`', ->
        for test in tests
            if !test.event.shiftKey and !test.event.altKey
                tile = new TileModel(test.attrs)
                spyOn tile, 'clear'
                tile.click()
                expect tile.clear
                    .toHaveBeenCalled()