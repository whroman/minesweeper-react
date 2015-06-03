class ModalsCollection
    constructor: () ->
        @show = {}

    set : (fileName) ->
        this.show[fileName] = false
        @

    toggle : (name) ->
        for modalName, isBeingShown of @show
            console.log modalName, name, isBeingShown
            if modalName is name
                @show[modalName] = !isBeingShown
            else
                isBeingShown = false
            console.log modalName, name, isBeingShown

        console.log this.show[name]

    reset : () ->
        for key, showModal of this.show
            this.show[key] = false
        @

module.exports = ModalsCollection