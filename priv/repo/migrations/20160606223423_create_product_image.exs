defmodule Store.Repo.Migrations.CreateProductImage do
  use Ecto.Migration

  def change do
    create table(:product_images, primary_key: false) do
      add :product_id, references(:products), null: false
      add :image_id, references(:images), primary_key: true, null: false

      timestamps
    end
    create index(:product_images, [:product_id])
    create index(:product_images, [:image_id])

  end
end
