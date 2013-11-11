// Generated by CoffeeScript 1.6.2
(function() {
  var __slice = [].slice;

  this.objScene = {
    scene: new THREE.Scene(),
    renderer: new THREE.WebGLRenderer({
      antialias: true
    }),
    camera: null,
    controls: null,
    segments: 17,
    segmentSize: 10,
    stageSize: function() {
      return this.segmentSize * 7;
    },
    materials: {
      normal: new THREE.MeshNormalMaterial(),
      solid: new THREE.MeshPhongMaterial({
        color: 0x162f48,
        shininess: 30,
        specular: 0xFFFFFF,
        emissive: 0x162f48
      }),
      wireframe: new THREE.MeshPhongMaterial({
        color: 0x111111,
        shininess: 30,
        specular: 0x111111,
        emissive: 0x162f48,
        wireframe: true
      })
    },
    drawObj: function(obj, domTarget, width, height) {
      this.domTarget = domTarget;
      this.init(obj, width, height);
      return this.animate();
    },
    init: function(obj, width, height) {
      this.camera = this.buildCamera_(width, height);
      this.camera.position.set(0, this.stageSize() / 2, this.stageSize());
      this.camera.lookAt(this.scene.position);
      this.controls = new THREE.OrbitControls(this.camera, this.renderer.domElement);
      this.controls.autoRotateSpeed *= 2;
      this.renderer.setSize(width, height);
      this.domTarget.appendChild(this.renderer.domElement);
      this.obj = this.buildObj_(obj);
      this.add(this.camera, this.buildFloor_(), this.obj);
      this.add.apply(this, this.buildLights_());
      this.lastInteraction = new Date();
      return this.bindEvents_();
    },
    animate: function() {
      var _this = this;
      requestAnimationFrame(function() {
        return _this.animate();
      });
      this.renderer.render(this.scene, this.camera);
      if ((this.lastInteraction != null) && new Date() - this.lastInteraction > 3000) {
        this.controls.autoRotate = true;
      }
      this.controls.update();
      return this.camera.up = new THREE.Vector3(0, 1, 0);
    },
    add: function() {
      var o, objs, _i, _len;
      objs = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      for (_i = 0, _len = objs.length; _i < _len; _i++) {
        o = objs[_i];
        this.scene.add(o);
      }
    },
    setMaterial: function(kind) {
      var material;
      material = this.materials[kind];
      if (material == null) {
        throw new Error("Unknown material: " + kind);
      }
      return this.setObject3DMaterial_(this.obj, material);
    },
    buildObj_: function(obj) {
      var loader, object3d, scale;
      loader = new THREE.OBJLoader();
      object3d = loader.parse(obj);
      this.setObject3DMaterial_(object3d, this.materials.solid);
      scale = this.findObjectScale(object3d);
      object3d.scale.set(scale, scale, scale);
      object3d.position.set(0, 1, 0);
      return object3d;
    },
    findObjectScale: function(object3d) {
      var bbox, largetSide, sides;
      bbox = this.getBoundingBox_(object3d);
      sides = bbox.max.sub(bbox.min).toArray();
      largetSide = Math.max.apply(Math, sides);
      return this.stageSize() / largetSide;
    },
    getBoundingBox_: function(object3d) {
      return new THREE.Box3().setFromObject(object3d);
    },
    buildCamera_: function(width, height) {
      var aspect, far, near, viewAngle;
      viewAngle = 45;
      aspect = width / height;
      near = 0.1;
      far = 20000;
      return new THREE.PerspectiveCamera(viewAngle, aspect, near, far);
    },
    buildLights_: function() {
      var light, lights, side, x, y, z, _i, _len, _ref, _ref1;
      lights = [];
      side = this.stageSize();
      _ref = [[-1, 0, 0], [1, 0, 0], [0, 0, 1], [0, 0, -1], [0, -1, 0], [0, 2, 0]];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        _ref1 = _ref[_i], x = _ref1[0], y = _ref1[1], z = _ref1[2];
        light = new THREE.PointLight(0xffffff, 1.3);
        light.position.set(x * side, y * side, z * side);
        lights.push(light);
      }
      return lights;
    },
    buildFloor_: function() {
      var floor, sideLength;
      sideLength = this.segments * this.segmentSize / 2;
      floor = new THREE.GridHelper(sideLength, this.segmentSize);
      floor.position.y = -0.5;
      return floor;
    },
    setObject3DMaterial_: function(object3d, material) {
      return object3d.traverse(function(child) {
        if (child instanceof THREE.Mesh) {
          return child.material = material;
        }
      });
    },
    bindEvents_: function() {
      var el, updateInteraction,
        _this = this;
      el = $(this.renderer.domElement);
      updateInteraction = function() {
        _this.controls.autoRotate = false;
        return _this.lastInteraction = new Date();
      };
      el.mousedown(function() {
        _this.controls.autoRotate = false;
        return _this.lastInteraction = null;
      });
      el.mouseup(updateInteraction);
      return el.on('mousewheel DOMMouseScroll', updateInteraction);
    }
  };

}).call(this);