import { get, post, put } from '../utils';

let urls = ['/api/v1/products', '/api/v1/variants', '/api/v1/option_groups', '/api/v1/options']
let url = '';

export class ProductService {
  getProducts(params = null) {
    url = urls[0];
    if (params) url += `?${params}`;
    return get(url);
  }
  getProductById(id) {
    if (!id) throw new Error("Parameter not specified");
    return get(`${urls[0]}/${id}`);

  }
  saveProduct(product) {
    url = urls[0];
    if (!product) throw new Error("Parameter not specified");
    const {id} = product;
    const data = { product: product };
    if (id) return put(`${url}/${id}`, data);
    return post(url, data);
  }

  getProductCategories(params) {
    if (params) return get(`/api/v1/product_categories`);
    return get(`/api/v1/product_categories`);
  }
  getSubProductCategories(productCategoryId) {

  }

  getVariants() {
    url = urls[1];
    return get(url);
  }



  getOptionGroups(params = null) {
    let url = urls[2]
    if(params) url += `?${params}`;

    return get(url);
  }
  saveOptionGroup(optionGroup) {
    if(!optionGroup) throw new Error("Option group was not specified");
    const data = { option_group: optionGroup};
    const { id } = optionGroup;
    if(id) return put(`${urls[2]}/${id}`, data)
    return post(urls[2], data);
  }
  getOptions(params = null) {
    let url = urls[3]
    if(params) url += `?${params}`;
    return get(url);
  }
  saveOption(option) {
    if(!option) throw new Error("Option was not specified");
    const data = { option: option};
    const { id } = option;
    if(id) return put(`${urls[3]}/${id}`, data)
    return post(urls[3], data);
  }
}
