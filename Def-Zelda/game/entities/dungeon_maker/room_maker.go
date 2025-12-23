components {
  id: "room"
  component: "/game/entities/dungeon_maker/room.tilemap"
}
components {
  id: "room_maker"
  component: "/game/entities/dungeon_maker/room_maker.script"
  position {
    x: 863.32446
    y: 988.7452
  }
}
embedded_components {
  id: "collisionobject"
  type: "collisionobject"
  data: "collision_shape: \"/game/entities/dungeon_maker/room.tilemap\"\n"
  "type: COLLISION_OBJECT_TYPE_KINEMATIC\n"
  "mass: 0.0\n"
  "friction: 0.1\n"
  "restitution: 0.5\n"
  "group: \"wall\"\n"
  "mask: \"player\"\n"
  ""
}
