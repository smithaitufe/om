defmodule Store.Repo.Migrations.CreateUserType do
  use Ecto.Migration

  def change do
    create table(:user_types) do
      add :name, :string
      add :description, :string
      add :code, :string

      timestamps
    end

  end
end
