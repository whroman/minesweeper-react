class ModalsCollection
    constructor: () ->
        @show = {}

    set : (fileName) ->
        this.show[fileName] = false
        @

    toggle : (name) ->
        for modalName, isBeingShown of @show
            if modalName is name
                @show[modalName] = !isBeingShown
            else
                isBeingShown = false

    reset : () ->
        for key, showModal of this.show
            this.show[key] = false
        @

module.exports = ModalsCollection