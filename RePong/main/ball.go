components {
  id: "ball"
  component: "/main/ball.script"
}
components {
  id: "trail_mesh"
  component: "/hyper_trails/models/trail_mesh.mesh"
}
components {
  id: "trail_maker"
  component: "/hyper_trails/trail_maker.script"
  properties {
    id: "trail_tint_color"
    value: "0.0, 1.0, 1.0, 1.0"
    type: PROPERTY_TYPE_VECTOR4
  }
}
embedded_components {
  id: "sprite"
  type: "sprite"
  data: "default_animation: \"ball\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/main/art_src.atlas\"\n"
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
  "group: \"balls\"\n"
  "mask: \"paddles\"\n"
  "mask: \"wall_up\"\n"
  "mask: \"wall_down\"\n"
  "embedded_collision_shape {\n"
  "  shapes {\n"
  "    shape_type: TYPE_BOX\n"
  "    position {\n"
  "      x: -1.0\n"
  "      y: -1.0\n"
  "    }\n"
  "    rotation {\n"
  "    }\n"
  "    index: 0\n"
  "    count: 3\n"
  "  }\n"
  "  data: 30.973724\n"
  "  data: 25.259512\n"
  "  data: 10.0\n"
  "}\n"
  ""
}
