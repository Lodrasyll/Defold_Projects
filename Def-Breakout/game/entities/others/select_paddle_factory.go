components {
  id: "select_scene"
  component: "/game/entities/others/select_scene.script"
  position {
    x: -0.101802886
    y: 0.2855769
  }
}
embedded_components {
  id: "collectionproxy"
  type: "collectionproxy"
  data: "collection: \"/scenes/select_scene/select_paddle.collection\"\n"
  ""
}
embedded_components {
  id: "factory"
  type: "factory"
  data: "prototype: \"/game/entities/player/player.go\"\n"
  "dynamic_prototype: true\n"
  ""
}
