defmodule Store.Repo.Migrations.CreateOption do
  use Ecto.Migration

  def change do
    create table(:options) do
      add :name, :string, null: false
      add :option_group_id, references(:option_groups, on_delete: :nothing), null: false

      timestamps()
    end
    create index(:options, [:option_group_id])

  end
end
