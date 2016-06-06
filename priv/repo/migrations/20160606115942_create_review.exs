defmodule Store.Repo.Migrations.CreateReview do
  use Ecto.Migration

  def change do
    create table(:reviews) do
      add :comment, :text
      add :rating, :integer
      add :user_id, references(:users), null: false
      add :product_id, references(:products), null: false

      timestamps
    end
    create index(:reviews, [:user_id])
    create index(:reviews, [:product_id])

  end
end
