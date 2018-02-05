defmodule Mundum.Repo.Migrations.CreateSupercategories do
  use Ecto.Migration

  def change do
    create table(:supercategories) do
      add :name, :text, null: false

      timestamps()
    end
    
    create unique_index(:supercategories, [:name])
  end
end
