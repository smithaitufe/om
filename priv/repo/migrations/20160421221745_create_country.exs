defmodule Store.Repo.Migrations.CreateCountry do
  use Ecto.Migration

  def change do
    create table(:countries) do
      add :name, :string, limit: 100, null: false
      add :abbreviation, :string, limit: 5


      timestamps
    end

    create index(:countries, [:name])
    

  end
end
