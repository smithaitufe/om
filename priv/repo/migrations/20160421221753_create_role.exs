defmodule Store.Repo.Migrations.CreateRole do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :name, :string, limit: 30, null: false, unique: true

      timestamps
    end

  end
end
