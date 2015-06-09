class ModalsCollection
    constructor: () ->
        @show = {}

    set : (name) ->
        this.show[name] = false
        @

    toggle : (name) ->
        @reset()
        for modalName, isBeingShown of @show
            if modalName is name
                @show[modalName] = !isBeingShown

    reset : () ->
        for key, showModal of this.show
            this.show[key] = false
        @

module.exports = ModalsCollection