React = require 'react/addons'

GameComponent = require './components/GameComponent.coffee'

ViewController = React.createElement GameComponent, id: 'wrapper'

React.render(
    ViewController,
    document.getElementById 'minesweeper'
)