module.exports = (markup) ->
    if typeof document isnt 'undefined'
        return
    jsdom = require('jsdom').jsdom
    global.document = jsdom(markup || '')
    global.window = document.parentWindow
    global.navigator = userAgent: 'node.js'
