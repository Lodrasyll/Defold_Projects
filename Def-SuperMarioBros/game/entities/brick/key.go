components {
  id: "key"
  component: "/game/entities/brick/key.script"
  position {
    x: -115.33896
    y: 28.002758
  }
}
embedded_components {
  id: "sprite"
  type: "sprite"
  data: "default_animation: \"key_yellow\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/atlas_textures_tilemap/tiles.atlas\"\n"
  "}\n"
  ""
}
embedded_components {
  id: "collisionobject"
  type: "collisionobject"
  data: "type: COLLISION_OBJECT_TYPE_TRIGGER\n"
  "mass: 0.0\n"
  "friction: 0.1\n"
  "restitution: 0.5\n"
  "group: \"keys\"\n"
  "mask: \"player\"\n"
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
  "  data: 24.453543\n"
  "  data: 15.092431\n"
  "  data: 10.0\n"
  "}\n"
  ""
}
