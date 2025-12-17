components {
  id: "slime"
  component: "/game/entities/enemies/slime.script"
  position {
    x: -0.19
    y: -0.0375
  }
}
embedded_components {
  id: "sprite"
  type: "sprite"
  data: "default_animation: \"slime_walk\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/atlas_textures_tilemap/enemies.atlas\"\n"
  "}\n"
  ""
}
embedded_components {
  id: "collisionobject"
  type: "collisionobject"
  data: "type: COLLISION_OBJECT_TYPE_KINEMATIC\n"
  "mass: 0.0\n"
  "friction: 0.1\n"
  "restitution: 0.5\n"
  "group: \"enemies\"\n"
  "mask: \"player\"\n"
  "mask: \"ground\"\n"
  "mask: \"pillars\"\n"
  "embedded_collision_shape {\n"
  "  shapes {\n"
  "    shape_type: TYPE_BOX\n"
  "    position {\n"
  "      y: -13.0\n"
  "    }\n"
  "    rotation {\n"
  "    }\n"
  "    index: 0\n"
  "    count: 3\n"
  "  }\n"
  "  data: 23.671926\n"
  "  data: 15.54082\n"
  "  data: 10.6\n"
  "}\n"
  ""
}
