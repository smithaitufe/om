defmodule Store.V1.AddressTypeView do
  use Store.Web, :view

  def render("index.json", %{address_types: address_types}) do
    %{data: render_many(address_types, Store.V1.AddressTypeView, "address_type.json")}
  end

  def render("show.json", %{address_type: address_type}) do
    %{data: render_one(address_type, Store.V1.AddressTypeView, "address_type.json")}
  end

  def render("address_type.json", %{address_type: address_type}) do
    %{id: address_type.id,
      name: address_type.name}
  end
end
