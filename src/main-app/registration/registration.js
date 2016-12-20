import { inject } from 'aurelia-framework';
import { ValidationControllerFactory, ValidationRules } from 'aurelia-validation';
import { BootstrapFormRenderer } from '../../resources/renderers/bootstrap-form-renderer';

@inject(ValidationControllerFactory)
export class Registration {
  entity = {};
  constructor(controllerFactory){
    this.controller = controllerFactory.createForCurrentScope();
    this.controller.addRenderer(new BootstrapFormRenderer());

    ValidationRules
    .ensure("last_name").displayName("Last Name").required()
    .ensure("first_name").displayName("First Name").required()
    .ensure("email").displayName("Email").required()
    .ensure("phone_number").displayName("Phone Number").required()
    .ensure("password").displayName("Password").required()
    .ensure("password_confirmation").displayName("Password Confirmation").required().satisfies((src, obj)=>src == obj.password).withMessage("Passwords mismatch")
    .on(this.entity)

  }
  register(){
    this.controller.validate().then(response => {
      if(response.valid){
        //register
      }
    })
  }
}
