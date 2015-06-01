Tiles = require './components/Tiles.coffee'
Tile = require './components/Tile.coffee'

stubs = [1,2,3]

React.render React.createElement(Tiles, data: stubs),
    document.getElementById 'game'
