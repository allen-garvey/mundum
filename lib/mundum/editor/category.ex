defmodule Mundum.Editor.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias Mundum.Editor.Category


  schema "categories" do
    field :name, :string
    field :supercategory_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Category{} = category, attrs) do
    category
    |> cast(attrs, [:name, :supercategory_id])
    |> validate_required(required_fields())
    |> unique_constraint(:name)
  end
  
  def required_fields do
    [:name, :supercategory_id]
  end
end
