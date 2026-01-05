components {
  id: "door"
  component: "/game/entities/world/dungeon/door.script"
}
embedded_components {
  id: "sprite"
  type: "sprite"
  data: "default_animation: \"top_locked\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/arts/textures/door.atlas\"\n"
  "}\n"
  ""
}
