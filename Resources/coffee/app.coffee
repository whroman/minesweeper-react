React = require 'react/addons'

GameComponent = require './components/GameComponent.coffee'

ViewController = React.createElement GameComponent, null

React.render(
    ViewController,
    document.getElementById 'minesweeper'
)

console.log 'asdfds'