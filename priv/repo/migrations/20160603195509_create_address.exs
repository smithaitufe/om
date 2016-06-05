defmodule Store.Repo.Migrations.CreateAddress do
  use Ecto.Migration

  def change do
    create table(:addresses) do

      add :address1, :string, limit: 150, null: false
      add :address2, :string
      add :city, :string, limit: 50
      add :zip_code, :string, limit: 10
      add :state_id, :integer
      add :country_id, :integer

      timestamps
    end

  end
end
