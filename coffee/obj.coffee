objScene =
    scene: new THREE.Scene()
    renderer: new THREE.WebGLRenderer(antialias: true)
    camera: null
    controls: null

    drawObj: (obj, @domTarget, width, height) ->
        @init(obj, width, height)
        @animate()

    init: (obj, width, height) ->
        @camera = @buildCamera_(width, height)
        @scene.add @camera
        @camera.position.set 0, 150, 400
        @camera.lookAt @scene.position
        @controls = new THREE.OrbitControls(@camera, @renderer.domElement)

        # RENDERER
        @renderer.setSize width, height
        @domTarget.appendChild @renderer.domElement

        # LIGHT
        light = new THREE.PointLight(0xffffff)
        light.position.set 100, 250, 100
        @scene.add light

        # FLOOR
        floorMaterial = new THREE.MeshLambertMaterial(
            color: 0x00FF88
            side: THREE.DoubleSide
        )
        floorGeometry = new THREE.PlaneGeometry(1000, 1000, 10, 10)
        floor = new THREE.Mesh(floorGeometry, floorMaterial)
        floor.position.y = -0.5
        floor.rotation.x = Math.PI / 2
        @scene.add floor

        loader = new THREE.OBJLoader()

        objmesh = loader.parse(obj)
        @setTexture_ objmesh
        objmesh.position.set 0, 1, 0
        objmesh.scale.set 20, 20, 20
        @scene.add objmesh

    animate: ->
        requestAnimationFrame => @animate()
        @renderer.render @scene, @camera
        @controls.update()
        @camera.up = new THREE.Vector3(0, 1, 0)

    #private methods
    buildCamera_: (width, height) ->
        viewAngle = 45
        aspect = width / height
        near = 0.1
        far = 20000
        new THREE.PerspectiveCamera(viewAngle, aspect, near, far)

    setTexture_: (object) ->
        material = new THREE.MeshNormalMaterial()
        object.traverse (child) ->
            child.material = material if child instanceof THREE.Mesh


@drawObj = (obj, domTarget, targetWidth, targetHeight) ->
    objScene.drawObj obj, domTarget, targetWidth, targetHeight