defmodule Store.Repo.Migrations.CreatePrototype do
  use Ecto.Migration

  def change do
    create table(:prototypes) do

      add :name, :string, size: 100, null: false
      add :active, :boolean, default: true, null: false
      add :shop_id, references(:shops, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:prototypes, [:shop_id])
  end
end
