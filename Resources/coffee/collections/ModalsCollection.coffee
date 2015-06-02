class ModalsCollection
    constructor: () ->
        @show: {}

    set : (fileNames) ->
        for fileName in fileNames
            this.show[fileName] = false
        @

    toggle : (name) ->
        if (this.show[name] == true)
            this.show[name] = false
        else
            this.show[name] = true
        @

    reset : () ->
        for key, showModal of this.show
            this.show[key] = false
        @