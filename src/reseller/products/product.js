import { inject } from 'aurelia-framework';
import { ProductService, ShippingService } from '../../services';

@inject(ProductService, ShippingService)
export class Product {
  constructor(productService, shippingService) {
    this.productService = productService;
    this.shippingService = shippingService;
  }
  async activate() {
    let responses = await Promise.all([
      this.productService.getProductCategories(),
      this.shippingService.getShippingCategories()
    ]);

    this.product_categories = responses[0];
    this.shipping_categories = responses[1];
  }
}
