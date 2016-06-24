defmodule Store.Repo.Migrations.CreateBrand do
  use Ecto.Migration

  def change do
    create table(:brands) do
      add :name, :string, limit: 150, null: false

      timestamps
    end

  end
end
