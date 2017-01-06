import { inject } from 'aurelia-framework';
import { OrderService } from '../../services';

@inject(OrderService)
export class Orders {
  constructor(orderService) {
    this.orderService = orderService;
  }
  activate() {
    this.orderService.getOrders().then(response => { this.orders = response });
  }

}
