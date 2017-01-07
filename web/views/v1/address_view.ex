defmodule Store.V1.AddressView do
  use Store.Web, :view

  def render("index.json", %{addresses: addresses}) do
    render_many(addresses, Store.V1.AddressView, "address.json")
  end

  def render("show.json", %{address: address}) do
    render_one(address, Store.V1.AddressView, "address.json")
  end

  def render("address.json", %{address: address}) do

    city = render_one(address.city, Store.V1.CityView, "city.json")
    |> Map.put(:state, render_one(address.city.state, Store.V1.StateView, "state.json"))


     %{id: address.id,
      last_name: address.last_name,
      first_name: address.first_name,
      phone_number: address.phone_number,
      alternative_phone_number: address.alternative_phone_number,
      address: address.address,
      landmark: address.landmark,
      city_id: address.city_id,
      zip_code: address.zip_code,
      default: address.default,
      billing: address.billing,
      user_id: address.user_id
      }
      |> Map.put(:city, city)
  end
end
