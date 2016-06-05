defmodule Store.Repo.Migrations.CreatePhone do
  use Ecto.Migration

  def change do
    create table(:phones) do
      add :number, :string, limit: 20, null: false
      add :phone_type_id, references(:phone_types)
      add :primary, :boolean, default: false

      timestamps
    end

  end
end
