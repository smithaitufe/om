import { inject } from 'aurelia-framework';
import { ProductCategoryService } from '../../services';
@inject(ProductCategoryService)
export class Welcome{
  
  product_categories = [];
  
  constructor(productCategoryService){
    this.productCategoryService = productCategoryService;
  }
  activate(){
    this.productCategoryService.getProductCategories().then(response => { this.product_categories = response; })
  }

}
