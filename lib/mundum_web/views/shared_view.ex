defmodule MundumWeb.SharedView do
  use MundumWeb, :view
  import MundumWeb.FormHelpers
  import MundumWeb.PathHelpers
  import MundumWeb.StringHelpers
  import MundumWeb.DateHelpers

    def render("new.html", assigns) do
        conn = assigns[:conn]
        item_name_singular = assigns[:item_name_singular]
      
        assigns = Map.merge(assigns, 
            %{
                title: "Add " <> item_name_singular,
                action: path_for_item(conn, item_name_singular, :create),
                form_type: :create,
            }
         )
      
        render "form_page.html", assigns
    end
    
    def render("edit.html", assigns) do
        conn = assigns[:conn]
        item_name_singular = assigns[:item_name_singular]
        item = assigns[:item]
        item_display_name = assigns[:item_display_name]
        
        assigns = Map.merge(assigns, 
            %{
                title: "Edit " <> item_display_name,
                back_link_title: "Back to " <> item_display_name,
                back_link_path: path_for_item(conn, item_name_singular, :show, item),
                action: path_for_item(conn, item_name_singular, :update, item),
                form_type: :edit,
            }
        )
        
        render "form_page.html", assigns
    end
    
    @doc """
    Displays button with hidden delete form
    required keywords in assigns are: :item_name_singular, :conn, :item
    optional keywords in assigns are: :button_class
    """
    def render("delete_button.html", assigns) do
        delete_path = path_for_item(assigns[:conn], assigns[:item_name_singular], :delete, assigns[:item])
        button_class = case assigns[:button_class] do
            nil -> "btn btn-danger btn-xs"
            button_class -> button_class
        end
        form_for(assigns[:conn], delete_path, [method: "delete", data_form: "delete", class: "delete-form"], fn _f ->
            ~e"""
            <%= submit "Delete", class: button_class %>
            """
        end)
    end
end