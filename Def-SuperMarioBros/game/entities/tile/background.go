embedded_components {
  id: "sprite_cloud"
  type: "sprite"
  data: "default_animation: \"background_clouds\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/atlas&textures/backgrounds.atlas\"\n"
  "}\n"
  ""
  position {
    y: 256.0
    z: 0.1
  }
}
embedded_components {
  id: "sprite_tree"
  type: "sprite"
  data: "default_animation: \"background_color_trees\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "size {\n"
  "  x: 256.0\n"
  "  y: 256.0\n"
  "}\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/atlas&textures/backgrounds.atlas\"\n"
  "}\n"
  ""
  position {
    z: 0.2
  }
}
embedded_components {
  id: "sprite_sky"
  type: "sprite"
  data: "default_animation: \"background_solid_sky\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "size {\n"
  "  x: 256.0\n"
  "  y: 256.0\n"
  "}\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/atlas&textures/backgrounds.atlas\"\n"
  "}\n"
  ""
  position {
    y: 512.0
    z: 0.1
  }
}
