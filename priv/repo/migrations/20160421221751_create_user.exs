defmodule Store.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      
      add :user_type_id, references(:user_types), null: false
      add :last_name, :string
      add :first_name, :string
      add :email, :string
      add :hashed_password, :string
      add :code, :string, limit: 50
      add :active, :boolean, default: false
      add :locked, :boolean, default: false
      add :lock_expires_at, :datetime
      add :reset_token, :string
      add :reset_token_created_at, :datetime
      add :reset_token_expires_at, :datetime
      

      timestamps
    end

  end
end
