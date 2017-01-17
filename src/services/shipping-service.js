import { get, post, put } from '../utils';

export class ShippingService {
  getShippingCategories(params = null) {
    let url = `/api/v1/products`;
    if (params) return get(`${url}?${params}`);
    return get(url);
  }
  
}
