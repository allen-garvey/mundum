defmodule MundumWeb.ExpenseView do
  use MundumWeb, :view
  
  def render("new.html", assigns) do
    assigns = Map.merge(assigns, shared_form_assigns(assigns))
    render MundumWeb.SharedView, "new.html", assigns
  end

  def render("edit.html", assigns) do
    assigns = Map.merge(assigns, 
      %{
        item: assigns[:expense],
        item_display_name: to_s(assigns[:expense])
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
  
  def to_s(_expense) do
    "Expense"
  end
  
  def item_columns(_conn, expense) do
    [
        {"date", MundumWeb.SharedView.date_to_iso_string(expense.date_incurred)},
        {"amount", expense.amount},
        {"description", expense.description},
        {"category", MundumWeb.CategoryView.to_s(expense.category)}, 
    ]
  end
  
  
  def form_fields(related_fields) do
    [
        {:amount, :number, nil},
        {:description, :string, nil},
        {:category_id, :select, related_fields[:categories]},
        {:date_incurred, :date, nil},
        {:amortize_through, :date, nil},
    ]
  end
end
