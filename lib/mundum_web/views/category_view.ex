defmodule MundumWeb.CategoryView do
  use MundumWeb, :view
  
  def render("new.html", assigns) do
    assigns = Map.merge(assigns, shared_form_assigns(assigns))
    render MundumWeb.SharedView, "new.html", assigns
  end

  def render("edit.html", assigns) do
    assigns = Map.merge(assigns, 
      %{
        item: assigns[:category],
        item_display_name: to_s(assigns[:category])
      }
    ) |> Map.merge(shared_form_assigns(assigns))
    render MundumWeb.SharedView, "edit.html", assigns
  end

  def shared_form_assigns(assigns) do
    %{
        required_fields: Mundum.Editor.Category.required_fields(), 
        form_fields: form_fields(assigns[:related_fields])
      }
  end
  
  def to_s(category) do
    category.name
  end
  
  @doc """
  Maps a list of categories into tuples, used for forms
  """
  def map_for_form(categories) do
    Enum.map(categories, &{to_s(&1), &1.id})
  end
  
  def item_columns(_conn, category) do
    [
      {"name", category.name},
      {"supercategory", MundumWeb.SupercategoryView.to_s(category.supercategory)}, 
    ]
  end
  
  
  def form_fields(related_fields) do
    [
      {:name, :string, nil},
      {:supercategory_id, :select, related_fields[:supercategories]},
    ]
  end
  
end
