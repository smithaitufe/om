export class ImagesSection {
  configureRouter(config) {
    config.map(routes);
  }
}
export let routes = [
  { route: "/", name: "images", moduleId: "./images", title: "", nav: false},
  { route: "/:image_id", name: "image", moduleId: "./image", title: "", nav: false}
]
