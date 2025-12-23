components {
  id: "level_maker_3"
  component: "/game/entities/level_maker/level_maker_3.script"
  position {
    x: -1.0541135
    y: -0.036964078
  }
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
