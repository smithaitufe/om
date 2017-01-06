export class AddressesSection {
  configureRouter(config) {
    config.map(routes);
  }
}

export let routes = [
  { route: "/", name: "addresses", moduleId: "./addresses", title: ""},
  { route: "/:address_id", name: "address", moduleId: "./address", title: ""},
]
