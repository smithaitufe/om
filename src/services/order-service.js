import { get, post, put } from '../utils';

export class OrderService {
  getOrders(params = null) {
    if (params) return get(`/api/v1/orders?${params}`);
    return get(`/api/v1/orders`);
  }
  getOrderById(id) {    
      if (!id) throw new Error("Parameter not specified");
      return get(`/api/v1/orders/${id}`);
    
  }
  saveOrder(order) {    
      if (!order) throw new Error("Parameter not specified");
      const {id} = order;
      const data = { order: order };
      if (id) return put(`/api/v1/orders/${id}`, data);
      return post(`/api/v1/orders`, data);
  }
  
}
