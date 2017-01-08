export class VariantsSection {
  configureRouter(config) {
    config.map(routes);
  }
}
export let routes = [
  { route: "/", name: "variants", moduleId: "./variants", title: "", nav: false}
]
