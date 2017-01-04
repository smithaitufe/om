export class BuyerSection {
  configureRouter(config){
    config.map(routes);
  }
}
export let routes = [
  { route: '/bank-card', name: 'bank-card', moduleId: './bank-card/bank-card', title: 'Bank Card'},
  { route: '/addresses', name: 'addresses', moduleId: './addresses/addresses', title: 'Addresses'},
  { route: '/addresses/:address_id', name: 'address', moduleId: './addresses/address', title: 'Address'}
];
