defmodule Store.Repo.Migrations.CreateProperty do
  use Ecto.Migration

  def change do
    create table(:properties) do
      add :display_name, :string
      add :identifying_name, :string
      add :active, :boolean, default: false

      timestamps
    end

  end
end
