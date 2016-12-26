import { get, post, put } from '../utils';

export class VariantService {
  getVariants(params = null) {
    if (params) return get(`/api/v1/variants?${params}`);
    return get(`/api/v1/variants`);
  }
  getVariantById(id) {    
      if (!id) throw new Error("Parameter not specified");
      return get(`/api/v1/variants/${id}`);
    
  }
  saveVariant(variant) {    
      if (!variant) throw new Error("Parameter not specified");
      const {id} = variant;
      const data = { variant: variant };
      if (id) return put(`/api/v1/variants/${id}`, data);
      return post(`/api/v1/variants`, data);
  }
}
