import { inject } from 'aurelia-framework';
import { Router } from 'aurelia-router';
import { User } from '../../user';

@inject(Router, User)
export class Checkout {
  entity = {};

  constructor(router, user) {
    this.router = router;
    this.user = user;
    console.log(user);
  }
  attached(){
    $(".show-modal").click((e)=> { 
      e.preventDefault();       
      $("#address-modal").modal({backdrop: 'static', keyboard: false});
    });
  }
  activate() {
    //check if the user is logged
    //if not, redirect to login screen and store this url
    //fetch all the items in cart
    //
  }

  submit(){
    //create an order
    //create order items
    //update the total amount for the order
    //determine the total weight
    //stipulate the shipping rate, the vat

    let order = { user_id: this.user.id}

  }
}
