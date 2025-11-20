embedded_components {
  id: "sprite"
  type: "sprite"
  data: "default_animation: \"paddle\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/arts/arts.atlas\"\n"
  "}\n"
  ""
  rotation {
    z: 0.70710677
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
  "      y: -2.0\n"
  "    }\n"
  "    rotation {\n"
  "    }\n"
  "    index: 0\n"
  "    count: 3\n"
  "  }\n"
  "  data: 119.49395\n"
  "  data: 47.932953\n"
  "  data: 10.0\n"
  "}\n"
  ""
}
