components {
  id: "asteroid_factory"
  component: "/main/asteroid/asteroid_factory.script"
  position {
    x: -0.80941176
    y: -0.027058823
  }
}
embedded_components {
  id: "factory"
  type: "factory"
  data: "prototype: \"/main/asteroid/asteroid_l.go\"\n"
  "dynamic_prototype: true\n"
  ""
}
embedded_components {
  id: "collectionproxy"
  type: "collectionproxy"
  data: "collection: \"/main/asteroid/asteroids.collection\"\n"
  ""
}
