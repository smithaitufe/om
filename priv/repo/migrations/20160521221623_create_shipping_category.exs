defmodule Store.Repo.Migrations.CreateShippingCategory do
  use Ecto.Migration

  def change do
    create table(:shipping_categories) do
      add :name, :string
      add :description, :string

      timestamps
    end

  end
end
