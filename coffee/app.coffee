controls = '
    <div class="js-render-bar render-bar render-bar-with-modes">
    <ul class="js-view-modes render-view-modes">
    <li data-mode="wireframe" class="js-view-mode-item active">Wireframe</li>
    <li data-mode="normal" class="js-view-mode-item">Surface Angle</li>
    <li data-mode="solid" class="js-view-mode-item">Solid</li>
    </ul>
    </div>'

initApp = ->
    console.log "Three.hub loaded"
    objDataLines = $(".blob-line-code pre .line").map -> $(@).text()
    objData = objDataLines.toArray().join("\n")
    el = $(".blob-wrapper.js-blob-data")
    el.html("")
    drawObj(objData, el.get(0), 912, 465)
    el.append(controls)

$(initApp)
