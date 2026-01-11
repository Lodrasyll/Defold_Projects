components {
  id: "pokemon"
  component: "/game/entities/pokemon/pokemon.script"
  position {
    x: -13.6637535
    y: -8.053471
  }
  properties {
    id: "name"
    value: "z"
    type: PROPERTY_TYPE_HASH
  }
}
embedded_components {
  id: "sprite"
  type: "sprite"
  data: "default_animation: \"cardiwing-front\"\n"
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
embedded_components {
  id: "sprite_back"
  type: "sprite"
  data: "default_animation: \"cardiwing-back\"\n"
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
