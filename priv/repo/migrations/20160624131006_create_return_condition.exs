defmodule Store.Repo.Migrations.CreateReturnCondition do
  use Ecto.Migration

  def change do
    create table(:return_conditions) do
      add :label, :string, null: false
      add :description, :string, null: false

      timestamps
    end

  end
end
