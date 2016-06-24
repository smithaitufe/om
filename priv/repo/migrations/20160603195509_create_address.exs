defmodule Store.Repo.Migrations.CreateAddress do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :last_name, :string, limit: 50, null: false
      add :first_name, :string, limit: 50, null: false
      add :address1, :string, null: false
      add :address2, :string
      add :city_id, references(:cities), null: false
      add :phone_number, :string, limit: 15, null: false
      add :alternative_phone_number, :string, limit: 15
      add :zip_code, :string, limit: 10
      add :address_type_id, references(:address_types)
      add :default, :boolean, default: false


      timestamps
    end

    create index(:addresses, [:city_id])

  end
end
