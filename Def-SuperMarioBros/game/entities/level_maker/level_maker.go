components {
  id: "level_maker"
  component: "/game/entities/level_maker/level_maker.script"
  position {
    x: -1.4367841
    y: 0.0314978
  }
}
embedded_components {
  id: "factory_level_maker_tile_top"
  type: "factory"
  data: "prototype: \"/game/entities/tiles/tile_top.go\"\n"
  ""
}
embedded_components {
  id: "factory_level_maker_tile"
  type: "factory"
  data: "prototype: \"/game/entities/tiles/tile.go\"\n"
  ""
}
embedded_components {
  id: "factory_level_maker_sky"
  type: "collectionfactory"
  data: "prototype: \"/game/entities/background/background.collection\"\n"
  ""
}
embedded_components {
  id: "factory_level_maker_reward_brick"
  type: "factory"
  data: "prototype: \"/game/entities/brick/reward_brick.go\"\n"
  ""
}
embedded_components {
  id: "factory_level_maker_pillar"
  type: "factory"
  data: "prototype: \"/game/entities/tiles/pillar.go\"\n"
  ""
}
embedded_components {
  id: "factory_level_maker_flag"
  type: "factory"
  data: "prototype: \"/game/entities/others/flag.go\"\n"
  ""
}
embedded_components {
  id: "factory_level_maker_block"
  type: "factory"
  data: "prototype: \"/game/entities/brick/pyramid_brick.go\"\n"
  ""
}
