import { inject } from 'aurelia-framework';
import {ValidationController, validateTrigger} from 'aurelia-validation';
import { RouteMapper } from 'aurelia-route-mapper';
import { institution } from '../settings';

import { routes as buyersRoutes } from '../buyers/buyers-section';

@inject(RouteMapper)
export class App {
  constructor(mapper){
    this.mapper = mapper;
  }
  configureRouter(config, router) {
    config.title = institution;
    config.options.pushState = true;
    config.map(routes);
    this.mapper.map(routes);
    this.router = router;
  }
}
let routes = [
  { route: [''], name: 'welcome',  moduleId: './welcome/welcome',      nav: true, title: 'Welcome' },
  { route: "/login", name: "login", moduleId: "./login/login", title: "Login", nav: false},
  { route: "/registration", name: "registration", moduleId: "./registration/registration", title: "Registration", nav: false},
  { route: "/cart", name: "cart", moduleId: "./cart/cart", title: "Cart", nav: false},
  { route: "/checkout", name: "checkout", moduleId: "./checkout/checkout", title: "Checkout", nav: false},
  { route: "/buyer", name: "buyers-section", moduleId: "../buyers/buyers-section", title: "Buyer", nav: false, settings: { childRoutes: buyersRoutes}}
]