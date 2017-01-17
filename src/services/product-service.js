import { get, post, put } from '../utils';

let urls = ['/api/v1/products', '/api/v1/variants']
let url = '';

export class ProductService {
  getProducts(params = null) {
    url = urls[0];
    if (params) url += `?${params}`;
    return get(url);
  }
  getProductById(id) {
    if (!id) throw new Error("Parameter not specified");
    return get(`${urls[0]}/${id}`);

  }
  saveProduct(product) {
    url = urls[0];
    if (!product) throw new Error("Parameter not specified");
    const {id} = product;
    const data = { product: product };
    if (id) return put(`${url}/${id}`, data);
    return post(url, data);
  }

  getProductCategories(params) {
    if (params) return get(`/api/v1/product_categories`);
    return get(`/api/v1/product_categories`);
  }
  getSubProductCategories(productCategoryId) {

  }

  getVariants() {
    url = urls[1];
    return get(url);
  }

}
