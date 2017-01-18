import { inject } from 'aurelia-framework';
import { User } from '../../user';
import { ProductService } from '../../services';

@inject(User, ProductService)
export class Prototype {
  entity = {
    name: null,
    properties: [],
    options: []
  }

  constructor(user, productService) {
    this.user = user;
    this.productService = productService;
  }

  async activate(params) {
    this.properties = [
            {name: 'My Option', id:  '4'},
            {name: 'Some Value', id:  '1212'},
            {name: 'Select Me!', id:  '12'},
        ];
     this.options = [
            {name: 'My Option', id:  '4'},
            {name: 'Some Value', id:  '1212'},
            {name: 'Select Me!', id:  '12'},
        ];

        let responses = await Promise.all([
        this.productService.getOptions()
        ]);
        
        this.options = responses[0];
  }
  
}
