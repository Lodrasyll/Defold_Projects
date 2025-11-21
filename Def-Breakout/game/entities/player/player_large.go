components {
  id: "player"
  component: "/game/entities/player/player.script"
}
embedded_components {
  id: "sprite"
  type: "sprite"
  data: "default_animation: \"paddle\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "slice9 {\n"
  "  y: 180.0\n"
  "  w: 180.0\n"
  "}\n"
  "size {\n"
  "  x: 90.0\n"
  "  y: 500.0\n"
  "}\n"
  "size_mode: SIZE_MODE_MANUAL\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/textures/arts.atlas\"\n"
  "}\n"
  ""
  rotation {
    z: -0.70710677
    w: 0.70710677
  }
}
embedded_components {
  id: "collisionobject"
  type: "collisionobject"
  data: "type: COLLISION_OBJECT_TYPE_KINEMATIC\n"
  "mass: 0.0\n"
  "friction: 0.1\n"
  "restitution: 0.5\n"
  "group: \"paddle\"\n"
  "mask: \"ball\"\n"
  "embedded_collision_shape {\n"
  "  shapes {\n"
  "    shape_type: TYPE_BOX\n"
  "    position {\n"
  "    }\n"
  "    rotation {\n"
  "    }\n"
  "    index: 0\n"
  "    count: 3\n"
  "  }\n"
  "  data: 247.35178\n"
  "  data: 42.671227\n"
  "  data: 10.0\n"
  "}\n"
  ""
}
