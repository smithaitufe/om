import { get, post, put, destroy, doEncrypt, doDecrypt } from '../utils'
import { interswitch, tokenName } from '../settings'
export class SessionService {  
  setCurrentRole(value){
    localStorage.setItem("access", doEncrypt(JSON.stringify(value), "session"))
  }
  getCurrentRole(){
    let value = localStorage.getItem("access");
    if(value){
      return JSON.parse(doDecrypt(value, "session"));
    }
    return null;
  }
  setCurrentUser(value){
     localStorage.setItem("person", doEncrypt(JSON.stringify(value), "session"))
  }
  getCurrentUser(){
    let value = localStorage.getItem("person");
    if(value){
      return new Promise(resolve => resolve(JSON.parse(doDecrypt(value, "session"))));
    }
    return get(`/api/v1/current_user`)
  }

  login(id, password){
    const data = {session: { id: id, password: password }}      
    this.clearSession(tokenName);        
    return post(`/api/v1/sessions`, data)        
  }
  logOut(){    
    return destroy('/api/v1/sessions').then((response) => {
        if(response.ok){            
          this.clearSession(tokenName);
        }
    })
  }
  setToken(token){
    localStorage.setItem(tokenName, token);
  }
  getToken(){
    return localStorage.getItem(tokenName)
  }
  clearSession(name){    
    if (localStorage.getItem(name) || localStorage.getItem(name) !== null) {        
      delete localStorage[name];   
    }    
  }
}
