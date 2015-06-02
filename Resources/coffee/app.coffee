ComponentTiles = require './components/TilesComponent.coffee'

ViewController = React.createElement ComponentTiles, null

React.render(
    ViewController,
    document.getElementById 'game'
)
