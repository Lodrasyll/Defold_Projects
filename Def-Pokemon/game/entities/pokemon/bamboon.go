components {
  id: "pokemon"
  component: "/game/entities/pokemon/pokemon.script"
  properties {
    id: "name"
    value: "y"
    type: PROPERTY_TYPE_HASH
  }
}
embedded_components {
  id: "sprite_front"
  type: "sprite"
  data: "default_animation: \"bamboon-front\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/arts/textures/pokemon.atlas\"\n"
  "}\n"
  ""
}
embedded_components {
  id: "sprite_back"
  type: "sprite"
  data: "default_animation: \"bamboon-back\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "size {\n"
  "  x: 64.0\n"
  "  y: 64.0\n"
  "}\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/arts/textures/pokemon.atlas\"\n"
  "}\n"
  ""
}
