components {
  id: "room"
  component: "/game/entities/world/room.tilemap"
}
components {
  id: "room_maker"
  component: "/game/entities/world/room_maker.script"
}
embedded_components {
  id: "collisionobject"
  type: "collisionobject"
  data: "collision_shape: \"/game/entities/world/room.tilemap\"\n"
  "type: COLLISION_OBJECT_TYPE_KINEMATIC\n"
  "mass: 0.0\n"
  "friction: 0.1\n"
  "restitution: 0.5\n"
  "group: \"wall\"\n"
  "mask: \"player\"\n"
  "mask: \"enemies\"\n"
  ""
}
