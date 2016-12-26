import { get, post, put } from '../utils';

export class LGAService {
  getLGAs(params = null) {
    if (params) return get(`/api/v1/local_government_areas?${params}`);
    return get(`/api/v1/local_government_areas`);
  }
  getLGAById(id) {    
      if (!id) throw new Error("Parameter not specified");
      return get(`/api/v1/local_government_areas/${id}`);
    
  }
  saveLGA(localGovernmentArea) {    
      if (!localGovernmentArea) throw new Error("Parameter not specified");
      const {id} = localGovernmentArea;
      const data = { local_government_area: localGovernmentArea };
      if (id) return put(`/api/v1/local_government_areas/${id}`, data);
      return post(`/api/v1/local_government_areas`, data);
  }
}
