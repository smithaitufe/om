import { inject } from "aurelia-framework";
import { RouteMapper } from "aurelia-route-mapper";
import { routes as ordersRoutes } from "./orders/orders-section";
import { routes as addressesRoutes } from "./addresses/addresses-section";
@inject(RouteMapper)
export class BuyerSection {

  constructor(mapper) {
    Object.assign(this, mapper);
  }
  configureRouter(config) {
    config.map(routes);
  }
}
export let routes = [
  { route: "", redirect: "profile"},
  { route: "/profile", name: "profile", moduleId: "./profile/profile", title: "Profile"},
  { route: "/bank-card", name: "bank-card", moduleId: "./bank-card/bank-card", title: "Bank Card"},
  { route: "/addresses", name: "addresses-section", moduleId: "./addresses/addresses-section", title: "Addresses", settings: { childRoutes: addressesRoutes}},  
  { route: "/orders", name: "orders-section", moduleId: "./orders/orders-section", title: "Orders", settings: { childRoutes: ordersRoutes}},
  { route: "/wishlist", name: "wishlist", moduleId: "./wishlist/wishlist", title: "Wishlist"}
];
