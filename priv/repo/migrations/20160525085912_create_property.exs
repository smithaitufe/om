defmodule Store.Repo.Migrations.CreateProperty do
  use Ecto.Migration

  def change do
    create table(:properties) do
      add :display_name, :string, null: false, size: 150
      add :identifying_name, :string, null: false, size: 150
      add :active, :boolean, default: false
      add :shop_id, references(:shops)

      timestamps
    end

    add index(:properties, [:shop_id])

  end
end
