objScene =
    scene: new THREE.Scene()
    renderer: new THREE.WebGLRenderer(antialias: true)
    camera: null
    controls: null
    segments: 17
    segmentSize: 10


    drawObj: (obj, @domTarget, width, height) ->
        @init(obj, width, height)
        @animate()

    init: (obj, width, height) ->
        @camera = @buildCamera_(width, height)
        @camera.position.set 0, @stageSize(), @stageSize()
        @camera.lookAt @scene.position
        @controls = new THREE.OrbitControls(@camera, @renderer.domElement)
        @renderer.setSize width, height
        @domTarget.appendChild @renderer.domElement
        @add @camera, @buildLight_(), @buildFloor_(), @buildObj_(obj)

    animate: ->
        requestAnimationFrame => @animate()
        @renderer.render @scene, @camera
        @controls.update()
        @camera.up = new THREE.Vector3(0, 1, 0)

    add: (objs...) ->
        for o in objs
            @scene.add o
        return

    #private methods
    buildObj_: (obj) ->
        loader = new THREE.OBJLoader()
        objmesh = loader.parse(obj)
        @setTexture_ objmesh
        bbox = new THREE.Box3()
        objmesh.traverse (child) ->
            return unless child instanceof THREE.Mesh
            child.geometry.computeBoundingBox()
            box = child.geometry.boundingBox
            bbox.min.min box.min
            bbox.max.max box.max
        sides = bbox.max.sub(bbox.min).toArray()
        largetSide = Math.max sides...
        scale = @stageSize() / largetSide
        objmesh.scale.set scale, scale, scale
        objmesh.position.set 0, 1, 0
        objmesh

    stageSize: -> @segmentSize * 7

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


    setTexture_: (object) ->
        material = new THREE.MeshNormalMaterial()
        object.traverse (child) ->
            child.material = material if child instanceof THREE.Mesh


@drawObj = (obj, domTarget, targetWidth, targetHeight) ->
    objScene.drawObj obj, domTarget, targetWidth, targetHeight