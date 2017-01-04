export class OrdersSection {
  configureRouter(config) {
    config.map(routes);
  }
  
}

export let routes = [
  { routes: '/', name: 'orders', moduleId: './orders', title: ''},
  { routes: '/:id', name: 'order', moduleId: './order', title: ''}
]
