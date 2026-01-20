components {
  id: "piece_scr"
  component: "/game/entities/gameobj/piece_scr.script"
  position {
    x: 35.105457
    y: -5.003728
  }
}
embedded_components {
  id: "sprite"
  type: "sprite"
  data: "default_animation: \"1\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "slice9 {\n"
  "  x: 10.0\n"
  "  y: 10.0\n"
  "  z: 10.0\n"
  "  w: 10.0\n"
  "}\n"
  "size {\n"
  "  x: 200.0\n"
  "  y: 200.0\n"
  "}\n"
  "size_mode: SIZE_MODE_MANUAL\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/textures/generated/my_default.tilesource\"\n"
  "}\n"
  ""
}
embedded_components {
  id: "label"
  type: "label"
  data: "size {\n"
  "  x: 48.0\n"
  "  y: 48.0\n"
  "}\n"
  "text: \"1\"\n"
  "font: \"/assets/fonts/Koulen.font\"\n"
  "material: \"/builtins/fonts/label-df.material\"\n"
  ""
}
embedded_components {
  id: "collisionobject"
  type: "collisionobject"
  data: "type: COLLISION_OBJECT_TYPE_KINEMATIC\n"
  "mass: 0.0\n"
  "friction: 0.1\n"
  "restitution: 0.5\n"
  "group: \"draggable\"\n"
  "mask: \"cursor\"\n"
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
  "  data: 100.0\n"
  "  data: 100.0\n"
  "  data: 10.0\n"
  "}\n"
  ""
}
embedded_components {
  id: "pos"
  type: "label"
  data: "size {\n"
  "  x: 48.0\n"
  "  y: 48.0\n"
  "}\n"
  "text: \"1\"\n"
  "font: \"/assets/fonts/Koulen.font\"\n"
  "material: \"/builtins/fonts/label-df.material\"\n"
  ""
  position {
    y: -38.0
  }
  scale {
    x: 0.5
    y: 0.5
  }
}
