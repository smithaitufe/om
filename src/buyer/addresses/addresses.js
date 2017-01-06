import { inject } from 'aurelia-framework';
import { RouteMapper } from 'aurelia-route-mapper';
import { AddressService } from '../../services';

@inject(RouteMapper, AddressService)
export class Addresses {
  addresses = [];
  constructor(mapper, addressService){
    this.mapper = mapper;
    this.addressService = addressService;
  }
  activate(){
    this.addressService.getAddresses().then(response => this.addresses = response);
  }
  remove(address) {

  }
  delete(address) {
    alert('address ' + address.id + ' deleted');
  }
}
