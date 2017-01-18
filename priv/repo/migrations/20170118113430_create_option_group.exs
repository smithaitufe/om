defmodule Store.Repo.Migrations.CreateOptionGroup do
  use Ecto.Migration

  def change do
    create table(:option_groups) do
      add :shop_id, references(:shops, on_delete: :nothing)
      add :name, :string, null: false

      timestamps()
    end

    create index(:option_groups, [:shop_id])

  end
end
