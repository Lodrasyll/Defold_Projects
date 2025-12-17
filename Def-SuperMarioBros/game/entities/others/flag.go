embedded_components {
  id: "sprite"
  type: "sprite"
  data: "default_animation: \"flag_red_a\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/atlas_textures_tilemap/tiles.atlas\"\n"
  "}\n"
  ""
  position {
    y: 384.0
  }
}
embedded_components {
  id: "collisionobject"
  type: "collisionobject"
  data: "type: COLLISION_OBJECT_TYPE_TRIGGER\n"
  "mass: 0.0\n"
  "friction: 0.1\n"
  "restitution: 0.5\n"
  "group: \"flag\"\n"
  "mask: \"player\"\n"
  "embedded_collision_shape {\n"
  "  shapes {\n"
  "    shape_type: TYPE_BOX\n"
  "    position {\n"
  "      y: 384.0\n"
  "    }\n"
  "    rotation {\n"
  "    }\n"
  "    index: 0\n"
  "    count: 3\n"
  "  }\n"
  "  data: 29.135185\n"
  "  data: 30.65209\n"
  "  data: 10.0\n"
  "}\n"
  ""
}
embedded_components {
  id: "sprite1"
  type: "sprite"
  data: "default_animation: \"rope\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "size {\n"
  "  x: 64.0\n"
  "  y: 64.0\n"
  "}\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/atlas_textures_tilemap/tiles.atlas\"\n"
  "}\n"
  ""
  position {
    x: -22.0
    y: 320.0
  }
}
embedded_components {
  id: "sprite2"
  type: "sprite"
  data: "default_animation: \"rope\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "size {\n"
  "  x: 64.0\n"
  "  y: 64.0\n"
  "}\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/atlas_textures_tilemap/tiles.atlas\"\n"
  "}\n"
  ""
  position {
    x: -22.0
    y: 256.0
  }
}
embedded_components {
  id: "sprite3"
  type: "sprite"
  data: "default_animation: \"rope\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "size {\n"
  "  x: 64.0\n"
  "  y: 64.0\n"
  "}\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/atlas_textures_tilemap/tiles.atlas\"\n"
  "}\n"
  ""
  position {
    x: -22.0
    y: 192.0
  }
}
embedded_components {
  id: "sprite4"
  type: "sprite"
  data: "default_animation: \"rope\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "size {\n"
  "  x: 64.0\n"
  "  y: 64.0\n"
  "}\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/atlas_textures_tilemap/tiles.atlas\"\n"
  "}\n"
  ""
  position {
    x: -22.0
    y: 128.0
  }
}
embedded_components {
  id: "sprite5"
  type: "sprite"
  data: "default_animation: \"rope\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "size {\n"
  "  x: 64.0\n"
  "  y: 64.0\n"
  "}\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/atlas_textures_tilemap/tiles.atlas\"\n"
  "}\n"
  ""
  position {
    x: -22.0
    y: 64.0
  }
}
embedded_components {
  id: "sprite6"
  type: "sprite"
  data: "default_animation: \"rope\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "size {\n"
  "  x: 64.0\n"
  "  y: 64.0\n"
  "}\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/atlas_textures_tilemap/tiles.atlas\"\n"
  "}\n"
  ""
  position {
    x: -22.0
  }
}
