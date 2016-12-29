import { inject, Aurelia } from 'aurelia-framework';
import { Router } from 'aurelia-router';
import { ValidationControllerFactory, ValidationRules } from 'aurelia-validation';
import { BootstrapFormRenderer } from '../../resources/renderers/bootstrap-form-renderer';
import { SessionService } from '../../services';

@inject(Aurelia, Router, ValidationControllerFactory, SessionService)
export class Login {
    id = "smithaitufe@live.com";
    password = "password";

    constructor(aurelia, router, controllerFactory, sessionService) {
        this.aurelia = aurelia;
        this.router = router;
        this.controller = controllerFactory.createForCurrentScope();
        this.controller.addRenderer(new BootstrapFormRenderer());
        this.sessionService = sessionService;


        ValidationRules
            .ensure("id").displayName("Email/Phone No").required().withMessage("${$displayName} is required")
            .ensure("password").required()
            .on(this);
    }

    login() {
        this.sessionService.login(this.id, this.password).then(response => {
            const { user, token } = response;
            console.log(user, token);
            this.sessionService.setToken(token);
            // this.router.navigate("/", { replace: true, trigger: false });
            // this.aurelia.setRoot("private-section/private-section").then(() => { this.router.refreshNavigation(); })
        })
    }
}
