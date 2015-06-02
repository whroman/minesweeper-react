GameComponent = require './components/GameComponent.coffee'

ViewController = React.createElement GameComponent, null

React.render(
    ViewController,
    document.getElementById 'minesweeper'
)
