defmodule Store.Repo.Migrations.CreateCartItem do
  use Ecto.Migration

  def change do
    create table(:cart_items) do
      add :quantity, :integer, null: false, default: 1
      add :active, :boolean, default: true      
      add :cart_id, references(:carts), null: false
      add :variant_id, references(:variants), null: false
      add :item_type_id, references(:item_types), null: false

      timestamps
    end
    create index(:cart_items, [:cart_id])
    create index(:cart_items, [:variant_id])
    create index(:cart_items, [:item_type_id])

  end
end
