defmodule Store.Repo.Migrations.CreateShippingCategory do
  use Ecto.Migration

  def change do
    create table(:shipping_categories) do
      add :name, :string, null: false
      add :description, :string, size: 255

      timestamps
    end

  end
end
