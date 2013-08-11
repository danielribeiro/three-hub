@uicontrols =
    template: '<div class="js-render-bar render-bar render-bar-with-modes" id="three-hub-controls">
        <ul class="js-view-modes render-view-modes">
            <li data-mode="wireframe" class="js-view-mode-item">Wireframe</li>
            <li data-mode="normal" class="js-view-mode-item">Surface Angle</li>
            <li data-mode="solid" class="js-view-mode-item active">Solid</li>
        </ul>
        </div>'


    bindEvents: ->
        el = $("#three-hub-controls")
        el.on "click", ".js-view-mode-item", ->
            el.find(".js-view-mode-item.active").removeClass("active")
            $(@).addClass("active")
            console.log("activating", $(@).data("mode"))
