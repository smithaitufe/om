import { get, post, put } from '../utils';

export class StateService {
  getStates(params = null) {
    if (params) return get(`/api/v1/states?${params}`);
    return get(`/api/v1/states`);
  }
  getStateById(id) {    
      if (!id) throw new Error("Parameter not specified");
      return get(`/api/v1/states/${id}`);
    
  }
  saveState(state) {    
      if (!state) throw new Error("Parameter not specified");
      const {id} = state;
      const data = { state: state };
      if (id) return put(`/api/v1/states/${id}`, data);
      return post(`/api/v1/states`, data);
  }
}
