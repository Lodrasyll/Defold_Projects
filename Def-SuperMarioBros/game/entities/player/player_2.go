components {
  id: "player"
  component: "/game/entities/player/player.script"
}
embedded_components {
  id: "sprite"
  type: "sprite"
  data: "default_animation: \"idle\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/atlas_textures_tilesource/knight.tilesource\"\n"
  "}\n"
  ""
  scale {
    x: 3.0
    y: 3.0
  }
}
embedded_components {
  id: "collisionobject"
  type: "collisionobject"
  data: "type: COLLISION_OBJECT_TYPE_KINEMATIC\n"
  "mass: 0.0\n"
  "friction: 0.0\n"
  "restitution: 0.5\n"
  "group: \"player\"\n"
  "mask: \"flag\"\n"
  "mask: \"ground\"\n"
  "mask: \"pillars\"\n"
  "mask: \"items\"\n"
  "mask: \"bricks\"\n"
  "mask: \"enemies\"\n"
  "mask: \"rewards\"\n"
  "mask: \"keys\"\n"
  "embedded_collision_shape {\n"
  "  shapes {\n"
  "    shape_type: TYPE_SPHERE\n"
  "    position {\n"
  "      y: -10.0\n"
  "    }\n"
  "    rotation {\n"
  "    }\n"
  "    index: 0\n"
  "    count: 1\n"
  "  }\n"
  "  data: 22.72805\n"
  "}\n"
  ""
}
