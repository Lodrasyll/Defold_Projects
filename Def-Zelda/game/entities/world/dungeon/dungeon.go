components {
  id: "dungeon"
  component: "/game/entities/world/dungeon/dungeon.script"
  position {
    x: -0.7810364
    y: -0.5493936
  }
}
components {
  id: "dungeon_map"
  component: "/game/entities/world/dungeon/dungeon_map.tilemap"
}
embedded_components {
  id: "collisionobject"
  type: "collisionobject"
  data: "collision_shape: \"/game/entities/world/dungeon/dungeon_map.tilemap\"\n"
  "type: COLLISION_OBJECT_TYPE_KINEMATIC\n"
  "mass: 0.0\n"
  "friction: 0.1\n"
  "restitution: 0.5\n"
  "group: \"wall\"\n"
  "mask: \"player\"\n"
  "mask: \"enemies\"\n"
  ""
}
