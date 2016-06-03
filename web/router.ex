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
      resources "properties", PropertyController, except: [:new, :edit]

      resources "prototypes", PrototypeController, except: [:new, :edit]
      resources "prototype_properties", PrototypePropertyController, except: [:new, :edit]

      resources "shipping_categories", ShippingCategoryController, except: [:new, :edit]
      resources "shipping_zones", ShippingZoneController, except: [:new, :edit]
      resources "shipping_methods", ShippingMethodController, except: [:new, :edit]

      resources "suppliers", SupplierController, except: [:new, :edit]
      resources "variant_suppliers", VariantSupplierController, except: [:new, :edit]
      resources "product_categories", ProductCategoryController, except: [:new, :edit]
      resources "products", ProductController, except: [:new, :edit]
      resources "product_properties", ProductPropertyController, except: [:new, :edit]
      resources "variants", VariantController, except: [:new, :edit]
      resources "variant_properties", VariantPropertyController, except: [:new, :edit]


      resources "merchants", MerchantController, except: [:new, :edit]
      resources "newsletters", NewsletterController, except: [:new,:edit]
      resources "users", UserController, except: [:new, :edit]
      resources "roles", RoleController, except: [:new, :edit]

    end
  end
end
