defmodule Store.V1.AddressView do
  use Store.Web, :view

  def render("index.json", %{addresses: addresses}) do
    %{data: render_many(addresses, Store.V1.AddressView, "address.json")}
  end

  def render("show.json", %{address: address}) do
    %{data: render_one(address, Store.V1.AddressView, "address.json")}
  end

  def render("address.json", %{address: address}) do
    %{id: address.id,
      address1: address.address1,
      address2: address.address2,
      city: address.city,
      zip_code: address.zip_code,
      state_id: address.state_id,
      country_id: address.country_id}
  end
end
