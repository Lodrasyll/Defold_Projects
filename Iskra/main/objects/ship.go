components {
  id: "ship"
  component: "/main/scripts/ship.script"
}
embedded_components {
  id: "ship_spr"
  type: "sprite"
  data: "default_animation: \"ship\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/sprites.atlas\"\n"
  "}\n"
  ""
  rotation {
    z: -0.70710677
    w: 0.70710677
  }
}
embedded_components {
  id: "attack_range"
  type: "collisionobject"
  data: "type: COLLISION_OBJECT_TYPE_KINEMATIC\n"
  "mass: 0.0\n"
  "friction: 0.1\n"
  "restitution: 0.5\n"
  "group: \"attack_range\"\n"
  "mask: \"asteroid\"\n"
  "mask: \"enemy\"\n"
  "embedded_collision_shape {\n"
  "  shapes {\n"
  "    shape_type: TYPE_SPHERE\n"
  "    position {\n"
  "    }\n"
  "    rotation {\n"
  "    }\n"
  "    index: 0\n"
  "    count: 1\n"
  "  }\n"
  "  data: 1215.9564\n"
  "}\n"
  ""
}
embedded_components {
  id: "ship_collision"
  type: "collisionobject"
  data: "type: COLLISION_OBJECT_TYPE_KINEMATIC\n"
  "mass: 0.0\n"
  "friction: 0.1\n"
  "restitution: 0.5\n"
  "group: \"ship\"\n"
  "mask: \"asteroid\"\n"
  "mask: \"enemy\"\n"
  "embedded_collision_shape {\n"
  "  shapes {\n"
  "    shape_type: TYPE_BOX\n"
  "    position {\n"
  "      x: -326.0\n"
  "      y: 2.0\n"
  "    }\n"
  "    rotation {\n"
  "    }\n"
  "    index: 0\n"
  "    count: 3\n"
  "  }\n"
  "  shapes {\n"
  "    shape_type: TYPE_BOX\n"
  "    position {\n"
  "      x: 87.0\n"
  "      y: 316.0\n"
  "    }\n"
  "    rotation {\n"
  "    }\n"
  "    index: 3\n"
  "    count: 3\n"
  "  }\n"
  "  shapes {\n"
  "    shape_type: TYPE_BOX\n"
  "    position {\n"
  "      x: 87.0\n"
  "      y: -309.0\n"
  "    }\n"
  "    rotation {\n"
  "    }\n"
  "    index: 6\n"
  "    count: 3\n"
  "  }\n"
  "  shapes {\n"
  "    shape_type: TYPE_BOX\n"
  "    position {\n"
  "      x: 862.0\n"
  "      y: -316.0\n"
  "    }\n"
  "    rotation {\n"
  "    }\n"
  "    index: 9\n"
  "    count: 3\n"
  "  }\n"
  "  shapes {\n"
  "    shape_type: TYPE_BOX\n"
  "    position {\n"
  "      x: 862.0\n"
  "      y: 316.0\n"
  "    }\n"
  "    rotation {\n"
  "    }\n"
  "    index: 12\n"
  "    count: 3\n"
  "  }\n"
  "  shapes {\n"
  "    shape_type: TYPE_BOX\n"
  "    position {\n"
  "      x: -776.0\n"
  "      y: 313.0\n"
  "    }\n"
  "    rotation {\n"
  "    }\n"
  "    index: 15\n"
  "    count: 3\n"
  "  }\n"
  "  shapes {\n"
  "    shape_type: TYPE_BOX\n"
  "    position {\n"
  "      x: -776.0\n"
  "      y: -319.0\n"
  "    }\n"
  "    rotation {\n"
  "    }\n"
  "    index: 18\n"
  "    count: 3\n"
  "  }\n"
  "  data: 509.2828\n"
  "  data: 148.52109\n"
  "  data: 10.0\n"
  "  data: 509.2828\n"
  "  data: 127.01485\n"
  "  data: 10.0\n"
  "  data: 509.2828\n"
  "  data: 127.01485\n"
  "  data: 10.0\n"
  "  data: 261.21182\n"
  "  data: 61.157322\n"
  "  data: 10.0\n"
  "  data: 261.21182\n"
  "  data: 61.157322\n"
  "  data: 10.0\n"
  "  data: 351.64346\n"
  "  data: 101.547424\n"
  "  data: 10.0\n"
  "  data: 351.64346\n"
  "  data: 101.547424\n"
  "  data: 10.0\n"
  "}\n"
  ""
}
embedded_components {
  id: "factory_laser"
  type: "factory"
  data: "prototype: \"/main/objects/laser.go\"\n"
  ""
}
embedded_components {
  id: "effect_spr_1"
  type: "sprite"
  data: "default_animation: \"effect_yellow\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/sprites.atlas\"\n"
  "}\n"
  ""
  position {
    x: -998.0
  }
  rotation {
    z: -0.70710677
    w: 0.70710677
  }
  scale {
    x: 2.18428
    y: 2.71297
  }
}
embedded_components {
  id: "effect_spr_2"
  type: "sprite"
  data: "default_animation: \"effect_yellow\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "size {\n"
  "  x: 128.0\n"
  "  y: 128.0\n"
  "}\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/sprites.atlas\"\n"
  "}\n"
  ""
  position {
    x: -1298.0
    y: 315.0
  }
  rotation {
    z: -0.70710677
    w: 0.70710677
  }
  scale {
    x: 1.464282
    y: 2.71297
  }
}
embedded_components {
  id: "effect_spr_3"
  type: "sprite"
  data: "default_animation: \"effect_yellow\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "size {\n"
  "  x: 128.0\n"
  "  y: 128.0\n"
  "}\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/sprites.atlas\"\n"
  "}\n"
  ""
  position {
    x: -1298.0
    y: -318.0
  }
  rotation {
    z: -0.70710677
    w: 0.70710677
  }
  scale {
    x: 1.464282
    y: 2.71297
  }
}
embedded_components {
  id: "factory"
  type: "factory"
  data: "prototype: \"/main/objects/laser.go\"\n"
  ""
}
