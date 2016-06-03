defmodule Store.Repo.Migrations.CreateNewsletter do
  use Ecto.Migration

  def change do
    create table(:newsletters) do
      add :name, :string
      add :autosubscribe, :boolean, default: false

      timestamps
    end

  end
end
