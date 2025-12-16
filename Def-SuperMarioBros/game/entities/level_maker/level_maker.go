components {
  id: "level_maker"
  component: "/game/entities/level_maker/level_maker.script"
  position {
    x: -1.2958905
    y: 0.11050228
  }
}
embedded_components {
  id: "factory_level_maker_tile_top"
  type: "factory"
  data: "prototype: \"/game/entities/tile/tile_top.go\"\n"
  ""
}
embedded_components {
  id: "factory_level_maker_tile"
  type: "factory"
  data: "prototype: \"/game/entities/tile/tile.go\"\n"
  ""
}
embedded_components {
  id: "factory_level_maker_sky"
  type: "factory"
  data: "prototype: \"/game/entities/tile/background.go\"\n"
  ""
}
