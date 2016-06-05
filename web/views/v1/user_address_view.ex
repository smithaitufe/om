defmodule Store.V1.UserAddressView do
  use Store.Web, :view

  def render("index.json", %{user_addresses: user_addresses}) do
    %{data: render_many(user_addresses, Store.V1.UserAddressView, "user_address.json")}
  end

  def render("show.json", %{user_address: user_address}) do
    %{data: render_one(user_address, Store.V1.UserAddressView, "user_address.json")}
  end

  def render("user_address.json", %{user_address: user_address}) do
    %{id: user_address.id,
      user_id: user_address.user_id,
      address_id: user_address.address_id,
      address_type_id: user_address.address_type_id,
      default: user_address.default,
      active: user_address.active}
  end
end
