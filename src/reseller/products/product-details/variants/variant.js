import { inject } from 'aurelia-framework';
import { ValidationControllerFactory, ValidationRules } from 'aurelia-validation';
import { BootstrapFormRenderer } from '../../../../resources/renderers/bootstrap-form-renderer';
import { ProductService } from '../../../../services';

import { User } from '../../../../user';

@inject(ValidationControllerFactory, User, ProductService)
export class Variant {
  entity = {};

  constructor(controllerFactory, user, productService) {
    this.controller = controllerFactory.createForCurrentScope();
    this.controller.addRenderer(new BootstrapFormRenderer());

    this.user = user;
    this.productService = productService;

    this.variant_rules = ValidationRules
    .ensure("name").displayName("Name").required()
    .ensure("sku").displayName("SKU").required()
    .ensure("price").displayName("Price").required().matches(/^[+-]?((\.\d+)|(\d+(\.\d+)?))$/)
    .ensure("weight").displayName("Weight").required().matches(/^((\.\d+)|(\d+(\.\d+)?))$/)
    .rules;

  }
  async activate(params) {
    this.params = params;
    let response = await this.productService.getVariants();
    this.variants = response;
  }
  submit() {
    this.controller.validate().then(response => {
      if(response.valid) {
        
      }
    })
  }
}
