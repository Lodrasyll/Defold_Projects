components {
  id: "tile"
  component: "/game/entities/tile/tile.script"
  position {
    x: -53.17197
    y: -4.2678533
  }
}
embedded_components {
  id: "sprite"
  type: "sprite"
  data: "default_animation: \"terrain_grass_block_top\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/atlas&textures/tiles.atlas\"\n"
  "}\n"
  ""
}
embedded_components {
  id: "collisionobject"
  type: "collisionobject"
  data: "type: COLLISION_OBJECT_TYPE_STATIC\n"
  "mass: 0.0\n"
  "friction: 0.1\n"
  "restitution: 0.5\n"
  "group: \"ground\"\n"
  "mask: \"player\"\n"
  "embedded_collision_shape {\n"
  "  shapes {\n"
  "    shape_type: TYPE_BOX\n"
  "    position {\n"
  "      y: -2.0\n"
  "    }\n"
  "    rotation {\n"
  "    }\n"
  "    index: 0\n"
  "    count: 3\n"
  "  }\n"
  "  data: 32.0\n"
  "  data: 30.0\n"
  "  data: 10.0\n"
  "}\n"
  ""
}
