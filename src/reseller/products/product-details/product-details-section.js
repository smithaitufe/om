export class ProductDetailsSection {
 configureRouter(config)  {
   config.map(routes);
 }
}
export let routes = [
  { route: "/", name: "product-details", moduleId: "./product-details", title: "", nav: false},
  { route: "/variants", name: "variants-section", moduleId: "./variants/variants-section", title: "Variants", nav: false},
  { route: "/images", name: "images-section", moduleId: "./images/images-section", title: "", nav: false}
]
