contains = (str, search) -> str.indexOf(search) > 0
last = (indexable) -> indexable[indexable.length - 1]
endsWith = (str, search) -> str.search("#{search}$") > 0

isCurrentPageShowingObj = ->
    url = window.location.href
    filename = last(url.split("/"))
    if contains(url, "/blob/") and endsWith(filename, ".obj")
        alert "this page has an obj"
    else 
        alert "this page doesnt have an obj"
    return

initApp = -> isCurrentPageShowingObj()    

$(initApp)
