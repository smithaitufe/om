import { get, post, put } from '../utils';

export class CartService {
  getCarts(params = null) {
    if (params) return get(`/api/v1/carts?${params}`);
    return get(`/api/v1/carts`);
  }
  getCartById(id) {    
      if (!id) throw new Error("Parameter not specified");
      return get(`/api/v1/carts/${id}`);    
  }
  saveCart(cart) {    
      if (!cart) throw new Error("Parameter not specified");
      const {id} = cart;
      const data = { cart: cart };
      if (id) return put(`/api/v1/carts/${id}`, data);
      return post(`/api/v1/carts`, data);
  }
}
