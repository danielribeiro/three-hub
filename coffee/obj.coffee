@objScene =
    scene: new THREE.Scene()
    renderer: new THREE.WebGLRenderer(antialias: true)
    camera: null
    controls: null
    segments: 17
    segmentSize: 10
    stageSize: -> @segmentSize * 7

    materials:
        normal: new THREE.MeshNormalMaterial()
        solid: new THREE.MeshLambertMaterial(color: 0x4183C4, side: THREE.DoubleSide)
        wireframe: new THREE.MeshBasicMaterial(color: 0x111111, wireframe: true)


    drawObj: (obj, @domTarget, width, height) ->
        @init(obj, width, height)
        @animate()

    init: (obj, width, height) ->
        @camera = @buildCamera_(width, height)
        @camera.position.set 0, @stageSize() / 2, @stageSize()
        @camera.lookAt @scene.position
        @controls = new THREE.OrbitControls(@camera, @renderer.domElement)
        @renderer.setSize width, height
        @domTarget.appendChild @renderer.domElement
        @obj = @buildObj_(obj)
        @add @camera, @buildLight_(), @buildFloor_(), @obj

    animate: ->
        requestAnimationFrame => @animate()
        @renderer.render @scene, @camera
        @controls.update()
        @camera.up = new THREE.Vector3(0, 1, 0)

    add: (objs...) ->
        for o in objs
            @scene.add o
        return

    setMaterial: (kind) ->
        material = @materials[kind]
        throw new Error("Unknown material: #{kind}") unless material?
        @setObject3DMaterial_(@obj, material)

    #private methods
    buildObj_: (obj) ->
        loader = new THREE.OBJLoader()
        object3d = loader.parse(obj)
        @setObject3DMaterial_ object3d, @materials.solid
        scale = @findObjectScale object3d
        object3d.scale.set scale, scale, scale
        object3d.position.set 0, 1, 0
        object3d

    findObjectScale: (object3d) ->
        bbox = @getBoundingBox_(object3d)
        sides = bbox.max.sub(bbox.min).toArray()
        largetSide = Math.max sides...
        return @stageSize() / largetSide

    getBoundingBox_: (object3d) ->
        boundingBox = new THREE.Box3()
        object3d.traverse (child) ->
            return unless child instanceof THREE.Mesh
            child.geometry.computeBoundingBox()
            box = child.geometry.boundingBox
            boundingBox.min.min box.min
            boundingBox.max.max box.max
        boundingBox

    buildCamera_: (width, height) ->
        viewAngle = 45
        aspect = width / height
        near = 0.1
        far = 20000
        new THREE.PerspectiveCamera(viewAngle, aspect, near, far)

    buildLight_: ->
        light = new THREE.PointLight(0xffffff)
        light.position.set 100, 250, 100
        light

    buildFloor_: ->
        floorMaterial = new THREE.MeshBasicMaterial(color: 0x000000, wireframe: true)
        sideLength = @segments * @segmentSize
        floorGeometry = new THREE.PlaneGeometry(sideLength, sideLength, @segments, @segments)
        floor = new THREE.Mesh(floorGeometry, floorMaterial)
        floor.position.y = -0.5
        floor.rotation.x = Math.PI / 2
        floor


    setObject3DMaterial_: (object3d, material) ->
        object3d.traverse (child) ->
            child.material = material if child instanceof THREE.Mesh



@drawObj = (obj, domTarget, targetWidth, targetHeight) ->
    objScene.drawObj obj, domTarget, targetWidth, targetHeight
