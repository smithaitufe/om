import { inject } from 'aurelia-framework';
import { ProductCategoryService } from '../../services';
@inject(ProductCategoryService)
export class Welcome {
  
  product_categories = [];
  parent_product_categories = [];
  
  constructor(productCategoryService){
    this.productCategoryService = productCategoryService;
  }
  activate(){
    this.productCategoryService.getProductCategories().then(response => { 
      this.product_categories = response;
      this.parent_product_categories = response.filter(product_category => product_category.parent_id === null);      
    })
  }

  productCategoryMouseOverChanged(item) {
    let li = `#product-category-${item.id}`;    
    let height = $(li).parent('ul').css('height');
    $("body .sub-product-categories-container").css({"display": "block", "height": height})
    this.product_category = item;
    this.sub_product_categories = this.product_categories.filter(product_category => product_category.parent_id === item.id)
  }
  hideSubProductCategoriesContainer(){
    // $("body .sub-product-categories-container").css({"display": "none"});
  }

}
