import { get, post, put, delete } from '../utils';

export class AddressService {
  getAddresses(params = null) {
    if (params) return get(`/api/v1/addresses?${params}`);
    return get(`/api/v1/addresses`);
  }
  getAddressById(id) {    
      if (!id) throw new Error("Parameter not specified");
      return get(`/api/v1/addresses/${id}`);
    
  }
  saveAddress(address) {    
      if (!address) throw new Error("Parameter not specified");
      const {id} = address;
      const data = { address: address };
      if (id) return put(`/api/v1/addresses/${id}`, data);
      return post(`/api/v1/addresses`, data);
  }
  saveUserAddress(user_id, address_id) {
    if(!user_id) throw new Error("User not specified");
    if(!address_id) throw new Error("Address not specified");
    const data = {user_address: {user_id: user_id, address_id: address_id}};
    return post(`/api/v1/user_addresses`, data);
  }
  deleteUserAddress(user_id, address_id) {
    destroy(`/api/v1/user_addresses`)
  }
  
}
