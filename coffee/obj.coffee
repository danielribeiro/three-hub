@drawObj = (obj, domTarget, targetWidth, targetHeight) ->
  scene = new THREE.Scene()
  camera = null
  renderer = new THREE.WebGLRenderer(antialias: true)
  controls = null

  init = ->
    # CAMERA
    SCREEN_WIDTH = targetWidth
    SCREEN_HEIGHT = targetHeight
    VIEW_ANGLE = 45
    ASPECT = SCREEN_WIDTH / SCREEN_HEIGHT
    NEAR = 0.1
    FAR = 20000
    camera = new THREE.PerspectiveCamera(VIEW_ANGLE, ASPECT, NEAR, FAR)
    scene.add camera
    camera.position.set 0, 150, 400
    camera.lookAt scene.position
    controls = new THREE.OrbitControls(camera, renderer.domElement)
    
    # RENDERER
    renderer.setSize SCREEN_WIDTH, SCREEN_HEIGHT
    domTarget.appendChild renderer.domElement
    
    # LIGHT
    light = new THREE.PointLight(0xffffff)
    light.position.set 100, 250, 100
    scene.add light
    
    # FLOOR
    floorMaterial = new THREE.MeshLambertMaterial(
      color: 0x00FF88
      side: THREE.DoubleSide
    )
    floorGeometry = new THREE.PlaneGeometry(1000, 1000, 10, 10)
    floor = new THREE.Mesh(floorGeometry, floorMaterial)
    floor.position.y = -0.5
    floor.rotation.x = Math.PI / 2
    scene.add floor

    material = new THREE.MeshNormalMaterial()
    loader = new THREE.OBJLoader()
    setTexture = (object) ->
      object.traverse (child) ->
        child.material = material  if child instanceof THREE.Mesh

    objmesh = loader.parse(obj)
    setTexture objmesh
    objmesh.position.set 0, 40, 0
    objmesh.scale.set 20, 20, 20
    scene.add objmesh

  animate = ->
    requestAnimationFrame animate
    renderer.render scene, camera
    controls.update()
    camera.up = new THREE.Vector3(0, 1, 0)
  
  init()
  animate()