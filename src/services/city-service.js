import { get, post, put } from '../utils';

export class CityService {
  getCities(params = null) {
    if (params) return get(`/api/v1/cities?${params}`);
    return get(`/api/v1/cities`);
  }
  getCityById(id) {    
      if (!id) throw new Error("Parameter not specified");
      return get(`/api/v1/cities/${id}`);
    
  }
  saveCity(city) {    
      if (!city) throw new Error("Parameter not specified");
      const {id} = city;
      const data = { city: city };
      if (id) return put(`/api/v1/cities/${id}`, data);
      return post(`/api/v1/cities`, data);
    
  }
}
