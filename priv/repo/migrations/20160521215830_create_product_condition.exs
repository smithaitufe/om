defmodule Store.Repo.Migrations.CreateProductCondition do
  use Ecto.Migration

  def change do
    create table(:product_conditions) do
      add :name, :string, null: false

      timestamps()
    end

  end
end
