components {
  id: "player_script"
  component: "/game/entities/player_script.script"
  position {
    x: -53.752865
    y: -8.127389
  }
}
embedded_components {
  id: "sprite_cursor"
  type: "sprite"
  data: "default_animation: \"cursor\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "slice9 {\n"
  "  x: 5.0\n"
  "  y: 5.0\n"
  "  z: 5.0\n"
  "  w: 5.0\n"
  "}\n"
  "size {\n"
  "  x: 80.0\n"
  "  y: 80.0\n"
  "}\n"
  "size_mode: SIZE_MODE_MANUAL\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/textures/main_texture.tilesource\"\n"
  "}\n"
  ""
}
embedded_components {
  id: "sprite_highlight"
  type: "sprite"
  data: "default_animation: \"highlight\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "slice9 {\n"
  "  x: 5.0\n"
  "  y: 5.0\n"
  "  z: 5.0\n"
  "  w: 5.0\n"
  "}\n"
  "size {\n"
  "  x: 80.0\n"
  "  y: 80.0\n"
  "}\n"
  "size_mode: SIZE_MODE_MANUAL\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/textures/main_texture.tilesource\"\n"
  "}\n"
  ""
}
