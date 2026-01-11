components {
  id: "pokemon"
  component: "/game/entities/pokemon/pokemon.script"
  position {
    x: -24.431877
    y: -17.192802
  }
  properties {
    id: "name"
    value: "y"
    type: PROPERTY_TYPE_HASH
  }
}
embedded_components {
  id: "sprite"
  type: "sprite"
  data: "default_animation: \"agnite-front\"\n"
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
  data: "default_animation: \"agnite-back\"\n"
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
