import { inject } from 'aurelia-framework';
import { CartService } from '../../services';

@inject(CartService)
export class Wishlist {
  cart_items = [];
  item_types = [];
  constructor(cartService) {
    this.cartService = cartService;
  }
  activate(params) {
    Promise.all([this.cartService.getCarts(), this.cartService.getItemTypes()]).then(responses => {
      this.cart_items = responses[0][0].cart_items;
      this.item_types = responses[1];
    })
  }
}
