defmodule Mundum.Editor.Supercategory do
  use Ecto.Schema
  import Ecto.Changeset
  alias Mundum.Editor.Supercategory


  schema "supercategories" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Supercategory{} = supercategory, attrs) do
    supercategory
    |> cast(attrs, [:name])
    |> validate_required(required_fields())
    |> unique_constraint(:name)
  end
  
  def required_fields do
    [:name]
  end
end
