import { inject, bindable } from 'aurelia-framework';
import { ValidationControllerFactory, ValidationRules } from 'aurelia-validation';
import { BootstrapFormRenderer } from '../../renderers/bootstrap-form-renderer';

@inject(ValidationControllerFactory)
export class Password {
  @bindable entity = {};
  @bindable submitCallback = () => {}

  constructor(controllerFactory){
    this.controller = controllerFactory.createForCurrentScope();
    this.controller.addRenderer(new BootstrapFormRenderer());

    this.password_rules = ValidationRules
    .ensure("old_password").displayName("Current Password").required().matches(/^[A-Z]{1,}$/)
    .ensure("password").displayName("New Password").required()
    .ensure("password_confirmation").displayName("Password Confirmation").required()
    .rules;

    console.log(this.password_rules);





  }
  submit(){
    console.log(this.entity);
    this.controller.validate().then(response => {
      console.log(response);
      if(response.valid){
        this.submitCallback();
      }
    });
  }
}
