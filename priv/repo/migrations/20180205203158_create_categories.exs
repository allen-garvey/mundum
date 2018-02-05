defmodule Mundum.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :text, null: false
      add :supercategory_id, references(:supercategories, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:categories, [:supercategory_id])
    create unique_index(:categories, [:name])
  end
end
