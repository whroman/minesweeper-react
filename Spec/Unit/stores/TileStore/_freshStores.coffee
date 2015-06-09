tests = require process.cwd() + '/Spec/Unit/_testGames.coffee'
Store = require process.cwd() + '/Resources/coffee/stores/TileStore.coffee'

freshStores = (cb) ->
    stores = []
    for test in tests
        Store.onNewGame test.x, test.y, test.mines

        if cb
            Store = cb Store, test

        stores.push
            test: test
            all: Store.getAll()
            info: Store.getInfo()
    return stores

module.exports = freshStores