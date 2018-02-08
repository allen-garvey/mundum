defmodule MundumWeb.CategoryController do
  use MundumWeb, :controller

  alias Mundum.Editor
  alias Mundum.Editor.Category
  
  def custom_render(conn, template, assigns) do
    custom_render(conn, view_module(conn), template, assigns)
  end

  def custom_render(conn, view_module, template, assigns) do
    assigns = [{:item_name_singular, "category"}] ++ assigns
    render(conn, view_module, template, assigns)
  end

  def index(conn, _params) do
    categories = Editor.list_categories()
    render(conn, "index.html", categories: categories)
  end
  
  def related_fields do
    supercategories = Editor.list_supercategories() |> MundumWeb.SupercategoryView.map_for_form
    [supercategories: supercategories]
  end

  def new_page(conn, changeset, _params) do
    custom_render(conn, "new.html", changeset: changeset, related_fields: related_fields())
  end

  def new(conn, params) do
    changeset = Editor.change_category(%Category{})
    new_page(conn, changeset, params)
  end
  
  def create_succeeded(conn, category, "true") do
    changeset = Editor.change_category(%Category{supercategory_id: category.supercategory_id})
    new_page(conn, changeset, nil)
  end

  def create_succeeded(conn, category, _save_another) do
    redirect(conn, to: category_path(conn, :show, category))
  end

  def create(conn, %{"category" => category_params, "save_another" => save_another}) do
    case Editor.create_category(category_params) do
      {:ok, category} ->
        conn
        |> put_flash(:info, "#{MundumWeb.CategoryView.to_s(category)} created successfully.")
        |> create_succeeded(category, save_another)
      {:error, %Ecto.Changeset{} = changeset} ->
        new_page(conn, changeset, nil)
    end
  end

  def show(conn, %{"id" => id}) do
    category = Editor.get_category!(id)
    render(conn, "show.html", category: category)
  end

  def edit(conn, %{"id" => id}) do
    category = Editor.get_category!(id)
    changeset = Editor.change_category(category)
    render(conn, "edit.html", category: category, changeset: changeset)
  end

  def update(conn, %{"id" => id, "category" => category_params}) do
    category = Editor.get_category!(id)

    case Editor.update_category(category, category_params) do
      {:ok, category} ->
        conn
        |> put_flash(:info, "Category updated successfully.")
        |> redirect(to: category_path(conn, :show, category))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", category: category, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    category = Editor.get_category!(id)
    {:ok, _category} = Editor.delete_category(category)

    conn
    |> put_flash(:info, "Category deleted successfully.")
    |> redirect(to: category_path(conn, :index))
  end
end
