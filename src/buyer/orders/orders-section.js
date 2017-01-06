export class OrdersSection {
  configureRouter(config) {
    config.map(routes);
  }  
}

export let routes = [
  { route: "/", name: "orders", moduleId: "./orders", title: ""},
  { route: "/:id", name: "order", moduleId: "./order", title: ""}
]
