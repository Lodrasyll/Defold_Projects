components {
  id: "wild"
  component: "/assets/arts/tilemap/wild.tilemap"
}
embedded_components {
  id: "wall_collisionobject"
  type: "collisionobject"
  data: "collision_shape: \"/assets/arts/tilemap/wild.tilemap\"\n"
  "type: COLLISION_OBJECT_TYPE_STATIC\n"
  "mass: 0.0\n"
  "friction: 0.1\n"
  "restitution: 0.5\n"
  "group: \"wall\"\n"
  "mask: \"player\"\n"
  ""
}
