import { inject, bindable } from 'aurelia-framework';
import { ValidationControllerFactory, ValidationRules } from 'aurelia-validation';
import { BootstrapFormRenderer } from '../../resources/renderers/bootstrap-form-renderer';


@inject(ValidationControllerFactory)
export class Address {

  entity  = {};
  password_entity = {};

  constructor(controllerFactory){
    this.controller = controllerFactory.createForCurrentScope();
    this.controller.addRenderer(new BootstrapFormRenderer());

    this.address_rules = ValidationRules
    .ensure("last_name").displayName("Last Name").required()
    .ensure("first_name").displayName("First Name").required()
    .ensure("address1").displayName("Address line 1").required()
    .ensure("state_id").displayName("State").required()
    .ensure("local_government_area_id").displayName("Local Government Area").required()
    .ensure("city_id").displayName("City").required()
    .ensure("landmark").displayName("Landmark").required()
    .rules;

  }
  

  submit(){
    this.controller.validate({rule: this.address_rules}).then(response => {
      if(response.valid){
        alert("Address correctly filled");
      }
    })
  }

  
}
