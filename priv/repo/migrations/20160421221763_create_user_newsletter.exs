defmodule Store.Repo.Migrations.CreateUserNewsletter do
  use Ecto.Migration

  def change do
    create table(:user_newsletters) do
      add :user_id, references(:users), null: false
      add :newsletter_id, references(:newsletters), null: false

      timestamps
    end
    create index(:user_newsletters, [:user_id])
    create index(:user_newsletters, [:newsletter_id])

  end
end
