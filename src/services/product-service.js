import { get, post, put } from '../utils';

export class ProductService {
  getProducts(params = null) {
    if (params) return get(`/api/v1/products?${params}`);
    return get(`/api/v1/products`);
  }
  getProductById(id) {    
      if (!id) throw new Error("Parameter not specified");
      return get(`/api/v1/products/${id}`);
    
  }
  saveProduct(product) {    
      if (!product) throw new Error("Parameter not specified");
      const {id} = product;
      const data = { product: product };
      if (id) return put(`/api/v1/products/${id}`, data);
      return post(`/api/v1/products`, data);
  }
}
