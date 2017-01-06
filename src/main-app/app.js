import { inject } from 'aurelia-framework';
import {ValidationController, validateTrigger} from 'aurelia-validation';
import { RouteMapper } from 'aurelia-route-mapper';
import { institution } from '../settings';
import { SessionService } from '../services';
import { User } from '../user';

import { routes as buyerRoutes } from '../buyer/buyer-section';

@inject(RouteMapper, User, SessionService)
export class App {
  constructor(mapper, user, sessionService){
    this.mapper = mapper;
    this.user = user;
    this.sessionService = sessionService;
  }
  configureRouter(config, router) {
    config.title = institution;
    config.options.pushState = true;
    config.map(routes);
    this.mapper.map(routes);
    this.router = router;
  }

  get isAuthenticated(){
    return this.sessionService.getToken() || false
  }

  async activate(){
    if(this.isAuthenticated){
      return await this.sessionService.getCurrentUser().then(response => {        
        this.user = Object.assign(this.user, {...response})        
      })
    }
  }

  logOut(){
    this.sessionService.logOut().then(() => {
      this.router.navigate("");
    })
  }
}
let routes = [
  { route: [''], name: 'welcome',  moduleId: './welcome/welcome',      nav: true, title: 'Welcome' },
  { route: "/login", name: "login", moduleId: "./login/login", title: "Login", nav: false},
  { route: "/registration", name: "registration", moduleId: "./registration/registration", title: "Registration", nav: false},
  { route: "/cart", name: "cart", moduleId: "./cart/cart", title: "Cart", nav: false},
  { route: "/checkout", name: "checkout", moduleId: "./checkout/checkout", title: "Checkout", nav: false},
  { route: "/buyer", name: "buyer-section", moduleId: "../buyer/buyer-section", title: "Buyer", nav: false, settings: { childRoutes: buyerRoutes}}
]
