contains = (str, search) -> str.indexOf(search) > 0
last = (indexable) -> indexable[indexable.length - 1]
endsWith = (str, search) -> str.search("#{search}$") > 0

isCurrentPageShowingObj = ->
    url = window.location.href
    filename = last(url.split("/"))
    return contains(url, "/blob/") and endsWith(filename, ".obj")

initApp = ->
    return unless isCurrentPageShowingObj()
    objDataLines = $(".blob-line-code pre .line").map -> $(@).text()
    objData = objDataLines.toArray().join("\n")
    $(".blob-wrapper.js-blob-data").html("<pre>#{objData}</pre>")

$(initApp)
