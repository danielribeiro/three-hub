@drawCube = (domTarget, targetWidth, targetHeight) ->
  container = undefined
  stats = undefined
  camera = undefined
  scene = undefined
  renderer = undefined
  cube = undefined
  plane = undefined
  targetRotation = 0
  targetRotationOnMouseDown = 0
  mouseX = 0
  mouseXOnMouseDown = 0
  windowHalfX = targetWidth / 2
  windowHalfY = targetHeight / 2

  init = ->
    container = document.createElement("div")
    domTarget.appendChild container
    info = document.createElement("div")
    info.style.position = "absolute"
    info.style.top = "10px"
    info.style.width = "100%"
    info.style.textAlign = "center"
    info.innerHTML = "Drag to spin the cube"
    container.appendChild info
    camera = new THREE.PerspectiveCamera(70, targetWidth / targetHeight, 1, 1000)
    camera.position.y = 150
    camera.position.z = 500
    scene = new THREE.Scene()
    
    # Cube
    geometry = new THREE.CubeGeometry(200, 200, 200)
    i = 0

    while i < geometry.faces.length
      geometry.faces[i].color.setHex Math.random() * 0xffffff
      i++
    material = new THREE.MeshBasicMaterial(vertexColors: THREE.FaceColors)
    cube = new THREE.Mesh(geometry, material)
    cube.position.y = 150
    scene.add cube
    
    # Plane
    geometry = new THREE.PlaneGeometry(200, 200)
    geometry.applyMatrix new THREE.Matrix4().makeRotationX(-Math.PI / 2)
    material = new THREE.MeshBasicMaterial(color: 0xe0e0e0)
    plane = new THREE.Mesh(geometry, material)
    scene.add plane
    renderer = new THREE.CanvasRenderer()
    renderer.setSize targetWidth, targetHeight
    container.appendChild renderer.domElement
    stats = new Stats()
    stats.domElement.style.position = "absolute"
    stats.domElement.style.top = "0px"
    container.appendChild stats.domElement
    document.addEventListener "mousedown", onDocumentMouseDown, false
    document.addEventListener "touchstart", onDocumentTouchStart, false
    document.addEventListener "touchmove", onDocumentTouchMove, false
    
    #
    window.addEventListener "resize", onWindowResize, false
  onWindowResize = ->
    windowHalfX = targetWidth / 2
    windowHalfY = targetHeight / 2
    camera.aspect = targetWidth / targetHeight
    camera.updateProjectionMatrix()
    renderer.setSize targetWidth, targetHeight

  #
  onDocumentMouseDown = (event) ->
    event.preventDefault()
    document.addEventListener "mousemove", onDocumentMouseMove, false
    document.addEventListener "mouseup", onDocumentMouseUp, false
    document.addEventListener "mouseout", onDocumentMouseOut, false
    mouseXOnMouseDown = event.clientX - windowHalfX
    targetRotationOnMouseDown = targetRotation
  onDocumentMouseMove = (event) ->
    mouseX = event.clientX - windowHalfX
    targetRotation = targetRotationOnMouseDown + (mouseX - mouseXOnMouseDown) * 0.02
  onDocumentMouseUp = (event) ->
    document.removeEventListener "mousemove", onDocumentMouseMove, false
    document.removeEventListener "mouseup", onDocumentMouseUp, false
    document.removeEventListener "mouseout", onDocumentMouseOut, false
  onDocumentMouseOut = (event) ->
    document.removeEventListener "mousemove", onDocumentMouseMove, false
    document.removeEventListener "mouseup", onDocumentMouseUp, false
    document.removeEventListener "mouseout", onDocumentMouseOut, false
  onDocumentTouchStart = (event) ->
    if event.touches.length is 1
      event.preventDefault()
      mouseXOnMouseDown = event.touches[0].pageX - windowHalfX
      targetRotationOnMouseDown = targetRotation
  onDocumentTouchMove = (event) ->
    if event.touches.length is 1
      event.preventDefault()
      mouseX = event.touches[0].pageX - windowHalfX
      targetRotation = targetRotationOnMouseDown + (mouseX - mouseXOnMouseDown) * 0.05

  animate = ->
    requestAnimationFrame animate
    render()
    stats.update()
  render = ->
    plane.rotation.y = cube.rotation.y += (targetRotation - cube.rotation.y) * 0.05
    renderer.render scene, camera

  init()
  animate()
