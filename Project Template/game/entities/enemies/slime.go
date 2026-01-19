components {
  id: "enemy"
  component: "/game/entities/enemies/enemy.script"
  properties {
    id: "enemy_type"
    value: "slime"
    type: PROPERTY_TYPE_HASH
  }
}
embedded_components {
  id: "sprite"
  type: "sprite"
  data: "default_animation: \"slime_down\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/textures/generated/enemies.tilesource\"\n"
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
  "mask: \"wall\"\n"
  "mask: \"player\"\n"
  "mask: \"sword\"\n"
  "embedded_collision_shape {\n"
  "  shapes {\n"
  "    shape_type: TYPE_BOX\n"
  "    position {\n"
  "      y: -1.0\n"
  "    }\n"
  "    rotation {\n"
  "    }\n"
  "    index: 0\n"
  "    count: 3\n"
  "  }\n"
  "  data: 7.739864\n"
  "  data: 4.320692\n"
  "  data: 10.0\n"
  "}\n"
  ""
}
