defmodule Store.V1.UserView do
  use Store.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, Store.V1.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, Store.V1.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      last_name: user.last_name,
      first_name: user.first_name,
      email: user.email,
      encrypted_password: user.encrypted_password,
      active: user.active,
      locked: user.locked,
      lock_expires_at: user.lock_expires_at,
      reset_token: user.reset_token,
      reset_token_created_at: user.reset_token_created_at,
      reset_token_expires_at: user.reset_token_expires_at,
      login_attempts: user.login_attempts}
  end
end
