import { inject, bindable } from 'aurelia-framework';
import { ValidationControllerFactory, ValidationRules, validateTrigger } from 'aurelia-validation';
import { BootstrapFormRenderer } from '../../resources/renderers/bootstrap-form-renderer';
import { AddressService, StateService, CityService } from '../../services';
import { User } from '../../user';

@inject(ValidationControllerFactory, User, AddressService, StateService, CityService)
export class Address {

  states = [];  
  cities = [];
  

  entity  = {};
  password_entity = {};

  constructor(controllerFactory, user, addressService, stateService, cityService){
    this.controller = controllerFactory.createForCurrentScope();
    this.controller.validateTrigger = validateTrigger.manual;
    this.controller.addRenderer(new BootstrapFormRenderer());
    
    this.user = user;
    this.addressService = addressService;
    this.stateService = stateService;
    this.cityService = cityService;

    this.address_rules = ValidationRules
    .ensure("last_name").displayName("Last Name").required()
    .ensure("first_name").displayName("First Name").required()
    .ensure("address").displayName("Address").required()
    .ensure("phone_number").displayName("Phone Number").required()
    .ensure("state").displayName("State").required()    
    .ensure("city_id").displayName("City").required()   
    .rules;

  }

  async activate(params){
    const { address_id } = params;    
    let responses = await Promise.all([
      this.stateService.getStates(),
      this.cityService.getCities()
    ]);
    this.states = responses[0];
    this.cities = responses[1];

    if(address_id && address_id.toLowerCase() !== "new") {
      this.addressService.getAddressById(address_id).then(response => {
        this.entity = response;
        this.entity = Object.assign(this.entity, {state: this.getStateById(this.getCityById(this.entity.city_id).state_id)})
      });
    }else{      
      const { first_name, last_name, id } = this.user;
      this.entity = Object.assign(this.entity, {first_name: first_name, last_name: last_name, user_id: id});
    }   
  }
  
  getStateById(id){    
    return this.states.filter(state => state.id == id).pop();
  }
  getCityById(id){
    return this.cities.filter(city => city.id == id).pop();
  }
  stateChanged() {
    const { state } = this.entity;
    this.entity = Object.assign(this.entity, {cities: this.cities.filter(city => city.state_id == state.id)});
  }
  

  submit(){
    this.controller.validate({object: this.entity, rules: this.address_rules}).then(response => {
      if(response.valid){
        delete this.entity["state"];
        this.addressService.saveAddress(this.entity).then((response)=>{});
      }
    })
  }

  
}
