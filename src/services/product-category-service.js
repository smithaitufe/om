import { get, post, put } from '../utils';

export class ProductCategoryService {
  getProductCategories(params){
    if(params) return get(`/api/v1/product_categories`);
    return get(`/api/v1/product_categories`);
  }
  getSubProductCategories(productCategoryId){
    
  }

}
