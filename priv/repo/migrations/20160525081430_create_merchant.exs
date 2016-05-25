defmodule Store.Repo.Migrations.CreateMerchant do
  use Ecto.Migration

  def change do
    create table(:merchants) do
      add :name, :string
      add :phone_number, :string
      add :email, :string

      timestamps
    end

  end
end
