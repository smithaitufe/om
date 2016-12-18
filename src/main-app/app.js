import { inject } from 'aurelia-framework';
import {ValidationController, validateTrigger} from 'aurelia-validation';
import { RouteMapper } from 'aurelia-route-mapper';
import { brand } from '../settings';

@inject(RouteMapper)
export class App {
  constructor(mapper){
    this.mapper = mapper;
  }
  configureRouter(config, router) {
    config.title = brand;
    config.options.pushState = true;
    config.map(routes);
    this.mapper.map(routes);
    this.router = router;
  }
}
let routes = [
  { route: ['/', '/welcome'], name: 'welcome',  moduleId: './welcome/welcome',      nav: true, title: 'Welcome' },
  { route: "/login", name: "login", moduleId: "./login/login", title: "Login", nav: false}
]
