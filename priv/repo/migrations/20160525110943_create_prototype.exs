defmodule Store.Repo.Migrations.CreatePrototype do
  use Ecto.Migration

  def change do
    create table(:prototypes) do
      add :name, :string, size: 100, null: false
      add :active, :boolean, default: true, null: false

      timestamps
    end

  end
end
