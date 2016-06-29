defmodule Store.Repo.Migrations.CreatePhoneType do
  use Ecto.Migration

  def change do
    create table(:phone_types) do
      add :name, :string, limit: 50, null: false

      timestamps
    end

  end
end
