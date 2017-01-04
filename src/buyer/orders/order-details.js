export class OrderDetails {
  activate(order) {
    this.order = order;
  }
  calculateDetailCost(detail) {
    return detail.quantity * detail.price;
  }
  get detailTotal() {
    return this.order.order_items.map(this.calculateDetailCost).reduce((a, b) => a + b, 0);
  }
}
