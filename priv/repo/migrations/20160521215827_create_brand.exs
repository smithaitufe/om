defmodule Store.Repo.Migrations.CreateBrand do
  use Ecto.Migration

  def change do
    create table(:brands) do
      add :name, :string, limit: 150, null: false
      add :product_category_id, references(:product_categories, on_delete: :nothing)

      timestamps
    end

    create index(:brands, [:product_category_id])

  end
end
