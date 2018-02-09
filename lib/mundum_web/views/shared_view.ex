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
end