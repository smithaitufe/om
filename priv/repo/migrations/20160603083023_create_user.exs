defmodule Store.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :last_name, :string
      add :first_name, :string
      add :email, :string
      add :encrypted_password, :string
      add :active, :boolean, default: false
      add :locked, :boolean, default: false
      add :lock_expires_at, :datetime
      add :reset_token, :string
      add :reset_token_created_at, :datetime
      add :reset_token_expires_at, :datetime
      add :login_attempts, :integer

      timestamps
    end

  end
end
