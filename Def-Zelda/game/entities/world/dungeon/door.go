components {
  id: "door"
  component: "/game/entities/world/dungeon/door.script"
  position {
    x: -7.3414593
    y: -0.9846047
  }
}
embedded_components {
  id: "sprite"
  type: "sprite"
  data: "default_animation: \"\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/arts/textures/door.atlas\"\n"
  "}\n"
  ""
}
