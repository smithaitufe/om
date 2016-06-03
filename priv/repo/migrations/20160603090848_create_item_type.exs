defmodule Store.Repo.Migrations.CreateItemType do
  use Ecto.Migration

  def change do
    create table(:item_types) do
      add :name, :string, null: false, limit: 30

      timestamps
    end

  end
end
