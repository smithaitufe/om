defmodule Store.Repo.Migrations.CreateAddress do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :last_name, :string, limit: 50, null: false
      add :first_name, :string, limit: 50, null: false
      add :address, :string, null: false      
      add :city_id, references(:cities), null: false
      add :phone_number, :string, limit: 15, null: false
      add :alternative_phone_number, :string, limit: 15
      add :zip_code, :string, limit: 10
      add :billing, :boolean, default: false
      add :default, :boolean, default: false
      add :landmark, :string


      timestamps
    end

    create index(:addresses, [:city_id])
    create index(:addresses, [:user_id])

  end
end
