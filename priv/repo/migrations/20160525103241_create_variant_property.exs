defmodule Store.Repo.Migrations.CreateVariantProperty do
  use Ecto.Migration

  def change do
    create table(:variant_properties) do
      add :description, :string, size: 100, null: false
      add :primary, :boolean, default: false
      add :variant_id, references(:variants)
      add :property_id, references(:properties)

      timestamps
    end
    create index(:variant_properties, [:variant_id])
    create index(:variant_properties, [:property_id])

  end
end
