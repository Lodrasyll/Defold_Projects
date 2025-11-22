components {
  id: "brick"
  component: "/game/entities/others/brick.script"
  position {
    x: -92.2003
    y: 46.060856
  }
}
embedded_components {
  id: "collisionobject"
  type: "collisionobject"
  data: "type: COLLISION_OBJECT_TYPE_KINEMATIC\n"
  "mass: 0.0\n"
  "friction: 0.1\n"
  "restitution: 0.5\n"
  "group: \"brick\"\n"
  "mask: \"ball\"\n"
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
  "  data: 59.776093\n"
  "  data: 21.237019\n"
  "  data: 10.0\n"
  "}\n"
  ""
}
embedded_components {
  id: "sprite"
  type: "sprite"
  data: "default_animation: \"paddle\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "slice9 {\n"
  "  x: 26.0\n"
  "  z: 23.0\n"
  "}\n"
  "size {\n"
  "  x: 90.0\n"
  "  y: 248.0\n"
  "}\n"
  "size_mode: SIZE_MODE_MANUAL\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/textures/arts.atlas\"\n"
  "}\n"
  ""
  rotation {
    z: 0.70710677
    w: 0.70710677
  }
  scale {
    x: 0.5
    y: 0.5
  }
}
