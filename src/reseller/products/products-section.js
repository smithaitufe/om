import { routes as productDetailsRoutes } from "./product-details/product-details-section";
export class ProductsSection {
  configureRouter(config) {
    config.map(routes);
  }
}
export let routes = [
  { route: "/", name: "products", moduleId: "./products", title: "", nav: false},
  { route: "/:product_id", name: "product", moduleId: "./product", title: "", nav: false},
  { route: "/:product_id/details", name: "product-details-section", moduleId: "./product-details/product-details-section", title: "", nav: false, settings: { childRoutes: productDetailsRoutes}},
]
