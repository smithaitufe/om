import { inject } from 'aurelia-framework';
import { RouteMapper } from 'aurelia-route-mapper';
import { routes as productsRoutes } from "./products/products-section";
@inject(RouteMapper)
export class ResellerSection {
  constructor(mapper) {
    this.mapper = mapper;
  }
  configureRouter(config) {
    config.map(routes);
  }
}
export let routes = [
  { route: "/", redirect: "products"},
  { route: "/products", name: "products-section", moduleId: "./products/products-section", title: "", nav: false, settings: { childRoutes: productsRoutes}},
];

