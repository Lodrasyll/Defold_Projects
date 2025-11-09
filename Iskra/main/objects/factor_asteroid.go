components {
  id: "factory_asteroid"
  component: "/main/scripts/factory_asteroid.script"
  position {
    x: 0.27764705
    y: 0.16823529
  }
}
embedded_components {
  id: "factory"
  type: "factory"
  data: "prototype: \"/main/objects/asteroid_l.go\"\n"
  "dynamic_prototype: true\n"
  ""
}
embedded_components {
  id: "collectionproxy"
  type: "collectionproxy"
  data: "collection: \"/main/objects/asteroids.collection\"\n"
  ""
}
