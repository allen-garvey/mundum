defmodule MundumWeb.SupercategoryController do
  use MundumWeb, :controller

  alias Mundum.Editor
  alias Mundum.Editor.Supercategory

  def index(conn, _params) do
    supercategories = Editor.list_supercategories()
    render(conn, "index.html", supercategories: supercategories)
  end

  def new(conn, _params) do
    changeset = Editor.change_supercategory(%Supercategory{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"supercategory" => supercategory_params}) do
    case Editor.create_supercategory(supercategory_params) do
      {:ok, supercategory} ->
        conn
        |> put_flash(:info, "Supercategory created successfully.")
        |> redirect(to: supercategory_path(conn, :show, supercategory))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    supercategory = Editor.get_supercategory!(id)
    render(conn, "show.html", supercategory: supercategory)
  end

  def edit(conn, %{"id" => id}) do
    supercategory = Editor.get_supercategory!(id)
    changeset = Editor.change_supercategory(supercategory)
    render(conn, "edit.html", supercategory: supercategory, changeset: changeset)
  end

  def update(conn, %{"id" => id, "supercategory" => supercategory_params}) do
    supercategory = Editor.get_supercategory!(id)

    case Editor.update_supercategory(supercategory, supercategory_params) do
      {:ok, supercategory} ->
        conn
        |> put_flash(:info, "Supercategory updated successfully.")
        |> redirect(to: supercategory_path(conn, :show, supercategory))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", supercategory: supercategory, changeset: changeset)
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
