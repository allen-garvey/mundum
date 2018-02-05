defmodule Mundum.Repo.Migrations.CreateExpenses do
  use Ecto.Migration

  def change do
    create table(:expenses) do
      add :amount, :decimal, null: false, precision: 8, scale: 2
      add :description, :text, null: false
      add :date_incurred, :date, null: false
      add :amortize_through, :date
      add :category_id, references(:categories, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:expenses, [:category_id])
  end
end
