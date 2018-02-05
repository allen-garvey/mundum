defmodule MundumWeb.SupercategoryView do
  use MundumWeb, :view
  
  def render("new.html", assigns) do
    assigns = Map.merge(assigns, shared_form_assigns())
    render MundumWeb.SharedView, "new.html", assigns
  end

  def render("edit.html", assigns) do
    assigns = Map.merge(assigns, 
      %{
        item: assigns[:supercategory],
        item_display_name: to_s(assigns[:supercategory])
      }
    ) |> Map.merge(shared_form_assigns())
    render MundumWeb.SharedView, "edit.html", assigns
  end

  def shared_form_assigns() do
    %{
        required_fields: Mundum.Editor.Supercategory.required_fields(), 
        form_fields: form_fields()
      }
  end
  
  def to_s(supercategory) do
    supercategory.name
  end
  
  @doc """
  Maps a list of categories into tuples, used for forms
  """
  def map_for_form(supercategories) do
    Enum.map(supercategories, &{to_s(&1), &1.id})
  end
  
  def item_columns(_conn, supercategory) do
    [
      {"name", supercategory.name},
    ]
  end
  
  
  def form_fields() do
    [
      {:name, :string, nil},
    ]
  end
end
