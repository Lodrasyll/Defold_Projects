components {
  id: "ship"
  component: "/main/ship/ship.script"
}
embedded_components {
  id: "effect_spr"
  type: "sprite"
  data: "default_animation: \"effect_yellow\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "size {\n"
  "  x: 128.0\n"
  "  y: 128.0\n"
  "}\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/sprites.atlas\"\n"
  "}\n"
  ""
  position {
    x: -45.0
    z: -0.1
  }
  rotation {
    z: -0.70710677
    w: 0.70710677
  }
  scale {
    x: 0.5
    y: 0.5
    z: 0.5
  }
}
embedded_components {
  id: "ship_spr"
  type: "sprite"
  data: "default_animation: \"ship_G\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "size {\n"
  "  x: 128.0\n"
  "  y: 128.0\n"
  "}\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/sprites.atlas\"\n"
  "}\n"
  ""
  rotation {
    z: -0.70710677
    w: 0.70710677
  }
  scale {
    x: 0.5
    y: 0.5
    z: 0.5
  }
}
embedded_components {
  id: "laser_factory"
  type: "factory"
  data: "prototype: \"/main/ship/laser.go\"\n"
  ""
}
