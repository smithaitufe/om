defmodule Store.Router do
  use Store.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Store do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", Store do
    pipe_through :api

    scope "/v1", V1, as: :v1 do

      resources "address_types", AddressTypeController, except: [:new, :edit]
      resources "item_types", ItemTypeController, except: [:new, :edit]
      resources "invoice_types", InvoiceTypeController, except: [:new, :edit]
      resources "invoice_statuses", InvoiceStatusController, except: [:new, :edit]
      resources "invoices", InvoiceController, except: [:new, :edit]
      resources "properties", PropertyController, except: [:new, :edit]
      resources "prototypes", PrototypeController, except: [:new, :edit]
      resources "prototype_properties", PrototypePropertyController, except: [:new, :edit]
      resources "brands", BrandController, except: [:new, :edit]
      resources "tax_rates", TaxRateController, except: [:new, :edit]
      resources "payment_methods", PaymentMethodController, except: [:new, :edit]
      resources "users", UserController, except: [:new, :edit]
      resources "user_newsletters", UserNewsletter, except: [:new, :edit]
      resources "user_roles", UserRoleController, except: [:new, :edit]
      resources "user_addresses", UserAddressController, except: [:new, :edit]
      resources "user_phones", UserPhoneController, except: [:new, :edit]

      resources "merchants", MerchantController, except: [:new, :edit]
      resources "newsletters", NewsletterController, except: [:new,:edit]

      resources "return_conditions", ReturnConditionController, except: [:new, :edit]
      resources "addresses", AddressController, except: [:new, :edit]

      resources "order_statuses", OrderStatusController, except: [:new, :edit]
      resources "orders", OrderController, except: [:new, :edit]
      resources "order_states", OrderStateController, except: [:new, :edit]

      resources "shipping_categories", ShippingCategoryController, except: [:new, :edit]
      resources "shipping_zones", ShippingZoneController, except: [:new, :edit]
      resources "shipping_methods", ShippingMethodController, except: [:new, :edit]
      resources "tags", TagController, except: [:new, :edit]
      resources "suppliers", SupplierController, except: [:new, :edit]
      resources "variant_suppliers", VariantSupplierController, except: [:new, :edit]
      resources "product_categories", ProductCategoryController, except: [:new, :edit]
      resources "products", ProductController, except: [:new, :edit]
      resources "product_tags", ProductTagController, except: [:new, :edit]
      resources "product_properties", ProductPropertyController, except: [:new, :edit]
      resources "variants", VariantController, except: [:new, :edit]
      resources "variant_properties", VariantPropertyController, except: [:new, :edit]




      resources "roles", RoleController, except: [:new, :edit]




      resources "carts", CartController, except: [:new, :edit]
      resources "cart_items", CartItemController, except: [:new, :edit]

      resources "coupons", CouponController, except: [:new, :edit]



      resources "countries", CountryController, except: [:new, :edit]
      resources "states", StateController, except: [:new, :edit]
      resources "local_government_areas", LocalGovernmentAreaController, except: [:new, :edit]
      resources "cities", CityController, except: [:new, :edit]

      resources "reviews", ReviewController, except: [:new, :edit]

      resources "image_groups", ImageGroupController, except: [:new, :edit]
      resources "product_images", ProductImageController, except: [:new, :edit]


    end
  end
end
