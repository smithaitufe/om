import { inject } from 'aurelia-framework';
import { ProductService } from '../../../../services';
import { User } from '../../../../user';

@inject(User, ProductService)
export class Variants {
  entity = {};

  constructor(user, productService) {
    this.user = user;
    this.productService = productService;
  }
  async activate(params) {
    this.params = params;
    let response = await this.productService.getVariants();
    this.variants = response;
  }
  
}
