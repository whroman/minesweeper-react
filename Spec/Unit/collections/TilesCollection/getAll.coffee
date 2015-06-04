jest.autoMockOff()

TilesCollection = require process.cwd() + '/Resources/coffee/collections/TilesCollection.coffee'
tests = require './_testGameInits.coffee'
games = []

describe 'TilesCollection.getAll(attrs)', ->
    beforeEach ->
        games = []
        for test in tests
            Tiles = new TilesCollection()
            Tiles.newGame test.x, test.y, test.mines
            games.push {
                args: test
                tiles: Tiles
            }

    it 'returns all tiles with given `x` attr', ->
        for game in games
            numOfTiles = game.tiles.getAll(x: 0).length
            expect numOfTiles
                .toBe game.args.y

    it 'returns all tiles with given `y` attr', ->
        for game in games
            numOfTiles = game.tiles.getAll(y: 0).length
            expect numOfTiles
                .toBe game.args.x

    it 'returns all tiles with given `isMine` attr', ->
        for game in games
            numOfMineTiles = game.tiles.getAll(isMine: true).length
            numOfNotMineTiles = game.tiles.getAll(isMine: false).length

            expect numOfMineTiles
                .toBe game.args.mines

            expect numOfNotMineTiles
                .toBe game.tiles.all.length - game.args.mines

    it 'returns all tiles with given `isClear` attr', ->
        for game in games
            numOfClearTiles = game.tiles.getAll(isClear: true).length
            numOfNotClearTiles = game.tiles.getAll(isClear: false).length

            expect numOfClearTiles
                .toBe 0

            expect numOfNotClearTiles
                .toBe game.tiles.all.length


    it 'returns all tiles with given `isFlagged` attr', ->
        for game in games
            expect game.tiles.getAll(isFlagged: true).length
                .toBe 0

        for game in games
            expect game.tiles.getAll(isFlagged: false).length
                .toBe game.tiles.all.length