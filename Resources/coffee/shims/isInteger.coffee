shim = (value) ->
    return (
        typeof value is "number" and
        isFinite(value) and
        Math.floor(value) is value
    )

isInteger = (forceShim) ->
    if !forceShim and Number.isInteger
        return Number.isInteger
    return shim

module.exports = isInteger