defmodule MundumWeb.SupercategoryController do
  use MundumWeb, :controller

  alias Mundum.Editor
  alias Mundum.Editor.Supercategory
  
  def custom_render(conn, template, assigns) do
    custom_render(conn, view_module(conn), template, assigns)
  end

  def custom_render(conn, view_module, template, assigns) do
    assigns = [{:item_name_singular, "supercategory"}] ++ assigns
    render(conn, view_module, template, assigns)
  end

  def index(conn, _params) do
    supercategories = Editor.list_supercategories()
    render(conn, "index.html", supercategories: supercategories)
  end

  def new(conn, _params) do
    changeset = Editor.change_supercategory(%Supercategory{})
    new_page(conn, changeset)
  end

  def new_page(conn, changeset) do
    custom_render(conn, "new.html", changeset: changeset)
  end
  
  def edit_page(conn, changeset, supercategory) do
    custom_render(conn, "edit.html", changeset: changeset, item: supercategory)
  end
  
  def create_succeeded(conn, _supercategory, "true") do
    changeset = Editor.change_supercategory(%Supercategory{})
    new_page(conn, changeset)
  end

  def create_succeeded(conn, supercategory, _save_another) do
    redirect(conn, to: supercategory_path(conn, :show, supercategory))
  end

  def create(conn, %{"supercategory" => supercategory_params, "save_another" => save_another}) do
    case Editor.create_supercategory(supercategory_params) do
      {:ok, supercategory} ->
        conn
        |> put_flash(:info, "#{MundumWeb.SupercategoryView.to_s(supercategory)} created successfully.")
        |> create_succeeded(supercategory, save_another)
      {:error, %Ecto.Changeset{} = changeset} ->
        new_page(conn, changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    supercategory = Editor.get_supercategory!(id)
    render(conn, "show.html", supercategory: supercategory)
  end

  def edit(conn, %{"id" => id}) do
    supercategory = Editor.get_supercategory!(id)
    changeset = Editor.change_supercategory(supercategory)
    edit_page(conn, changeset, supercategory)
  end

  def update(conn, %{"id" => id, "supercategory" => supercategory_params}) do
    supercategory = Editor.get_supercategory!(id)

    case Editor.update_supercategory(supercategory, supercategory_params) do
      {:ok, supercategory} ->
        conn
        |> put_flash(:info, "#{MundumWeb.SupercategoryView.to_s(supercategory)} updated successfully.")
        |> redirect(to: supercategory_path(conn, :show, supercategory))
      {:error, %Ecto.Changeset{} = changeset} ->
        edit_page(conn, changeset, supercategory)
    end
  end

  def delete(conn, %{"id" => id}) do
    supercategory = Editor.get_supercategory!(id)
    {:ok, _supercategory} = Editor.delete_supercategory(supercategory)

    conn
    |> put_flash(:info, "Supercategory deleted successfully.")
    |> redirect(to: supercategory_path(conn, :index))
  end
end
