components {
  id: "dungeon"
  component: "/game/entities/world/dungeon/dungeon.script"
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
  "mask: \"enemies\"\n"
  "mask: \"player\"\n"
  ""
}
embedded_components {
  id: "player_factory"
  type: "factory"
  data: "prototype: \"/game/entities/player/player.go\"\n"
  ""
}
embedded_components {
  id: "door_factory"
  type: "factory"
  data: "prototype: \"/game/entities/player/player.go\"\n"
  ""
}
embedded_components {
  id: "switch_factory"
  type: "factory"
  data: "prototype: \"/game/entities/world/dungeon/switch.go\"\n"
  ""
}
embedded_components {
  id: "ghost_factory"
  type: "factory"
  data: "prototype: \"/game/entities/enemies/ghost.go\"\n"
  ""
}
embedded_components {
  id: "slime_factory"
  type: "factory"
  data: "prototype: \"/game/entities/enemies/slime.go\"\n"
  ""
}
embedded_components {
  id: "skeleton_factory"
  type: "factory"
  data: "prototype: \"/game/entities/enemies/skeleton.go\"\n"
  ""
}
