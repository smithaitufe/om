defmodule Store.Repo.Migrations.CreateProductProperty do
  use Ecto.Migration

  def change do
    create table(:product_properties) do
      add :position, :integer, null: false
      add :description, :string, null: false, size: 255
      add :product_id, references(:products)
      add :property_id, references(:properties)

      timestamps
    end
    create index(:product_properties, [:product_id])
    create index(:product_properties, [:property_id])

  end
end
