defmodule Store.V1.ReturnAuthorizationView do
  use Store.Web, :view

  def render("index.json", %{return_authorizations: return_authorizations}) do
    %{data: render_many(return_authorizations, Store.V1.ReturnAuthorizationView, "return_authorization.json")}
  end

  def render("show.json", %{return_authorization: return_authorization}) do
    %{data: render_one(return_authorization, Store.V1.ReturnAuthorizationView, "return_authorization.json")}
  end

  def render("return_authorization.json", %{return_authorization: return_authorization}) do
    %{id: return_authorization.id,
      number: return_authorization.number,
      amount: return_authorization.amount,
      restocking_fee: return_authorization.restocking_fee,
      order_id: return_authorization.order_id,
      created_by: return_authorization.created_by,
      active: return_authorization.active}
  end
end
