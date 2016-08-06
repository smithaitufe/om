defmodule Store.V1.UserPhoneView do
  use Store.Web, :view

  def render("index.json", %{user_phones: user_phones}) do
    render_many(user_phones, Store.V1.UserPhoneView, "user_phone.json")
  end

  def render("show.json", %{user_phone: user_phone}) do
    render_one(user_phone, Store.V1.UserPhoneView, "user_phone.json")
  end

  def render("user_phone.json", %{user_phone: user_phone}) do
    %{id: user_phone.id,
      phone_id: user_phone.phone_id,
      user_id: user_phone.user_id}
  end
end
