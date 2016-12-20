import { get, post, put } from '../utils';

export class UserService {
  getUsers(params = null) {
    if (params) return get(`/api/v1/users?${params}`);
    return get(`/api/v1/users`);
  }
  getUserById(id) {    
      if (!id) throw new Error("Parameter not specified");
      return get(`/api/v1/users/${id}`);
    
  }
  saveUser(user) {    
      if (!user) throw new Error("Parameter not specified");
      const {id} = user;
      const data = { user: user };
      if (id) return put(`/api/v1/users/${id}`, data);
      return post(`/api/v1/users`, data);
    
  }

  getUserTypes(params){
    if(params) return get(`/api/v1/user_types?${params}`);
    return get(`/api/v1/user_types`);
  }
  getUserTypeById(id){
    if(!id) throw new Error("Id not specified");
    return get(`/api/v1/user_types/${id}`);
  } 

}
