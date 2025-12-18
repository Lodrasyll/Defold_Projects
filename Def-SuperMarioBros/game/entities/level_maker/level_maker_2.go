components {
  id: "level_maker_2"
  component: "/game/entities/level_maker/level_maker_2.script"
  position {
    x: -1.4779736
    y: 0.11145374
  }
}
components {
  id: "level_2"
  component: "/game/entities/tilemap/level_2.tilemap"
  position {
    z: 0.1
  }
}
embedded_components {
  id: "collisionobject"
  type: "collisionobject"
  data: "collision_shape: \"/game/entities/tilemap/level_2.tilemap\"\n"
  "type: COLLISION_OBJECT_TYPE_STATIC\n"
  "mass: 0.0\n"
  "friction: 0.1\n"
  "restitution: 0.5\n"
  "group: \"ground\"\n"
  "mask: \"player\"\n"
  "mask: \"enemies\"\n"
  ""
}
embedded_components {
  id: "factory_level_maker_flag"
  type: "factory"
  data: "prototype: \"/game/entities/others/flag.go\"\n"
  ""
}
embedded_components {
  id: "factory_level_maker_reward_brick"
  type: "factory"
  data: "prototype: \"/game/entities/brick/reward_brick.go\"\n"
  ""
}
embedded_components {
  id: "factory_level_maker_sky"
  type: "collectionfactory"
  data: "prototype: \"/game/entities/background/background.collection\"\n"
  ""
}
