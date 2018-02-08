defmodule MundumWeb.ExpenseController do
  use MundumWeb, :controller

  alias Mundum.Editor
  alias Mundum.Editor.Expense

  def custom_render(conn, template, assigns) do
    custom_render(conn, view_module(conn), template, assigns)
  end

  def custom_render(conn, view_module, template, assigns) do
    assigns = [{:item_name_singular, "expense"}] ++ assigns
    render(conn, view_module, template, assigns)
  end

  def index(conn, _params) do
    expenses = Editor.list_expenses()
    render(conn, "index.html", expenses: expenses)
  end

  def related_fields do
    categories = Editor.list_categories() |> MundumWeb.CategoryView.map_for_form
    [categories: categories]
  end

  def new_page(conn, changeset, _params) do
    custom_render(conn, "new.html", changeset: changeset, related_fields: related_fields())
  end

  def new(conn, params) do
    changeset = Editor.change_expense(%Expense{})
    new_page(conn, changeset, params)
  end

  def create_succeeded(conn, expense, "true") do
    changeset = Editor.change_quote(%Expense{date_incurred: expense.date_incurred, category_id: expense.category_id})
    new_page(conn, changeset, nil)
  end

  def create_succeeded(conn, expense, _save_another) do
    redirect(conn, to: expense_path(conn, :show, expense))
  end

  def create(conn, %{"expense" => expense_params, "save_another" => save_another}) do
    case Editor.create_expense(expense_params) do
      {:ok, expense} ->
        conn
        |> put_flash(:info, "Expense created successfully.")
        |> create_succeeded(expense, save_another)
      {:error, %Ecto.Changeset{} = changeset} ->
        new_page(conn, changeset, nil)
    end
  end

  def show(conn, %{"id" => id}) do
    expense = Editor.get_expense!(id)
    render(conn, "show.html", expense: expense)
  end

  def edit(conn, %{"id" => id}) do
    expense = Editor.get_expense!(id)
    changeset = Editor.change_expense(expense)
    render(conn, "edit.html", expense: expense, changeset: changeset)
  end

  def update(conn, %{"id" => id, "expense" => expense_params}) do
    expense = Editor.get_expense!(id)

    case Editor.update_expense(expense, expense_params) do
      {:ok, expense} ->
        conn
        |> put_flash(:info, "Expense updated successfully.")
        |> redirect(to: expense_path(conn, :show, expense))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", expense: expense, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    expense = Editor.get_expense!(id)
    {:ok, _expense} = Editor.delete_expense(expense)

    conn
    |> put_flash(:info, "Expense deleted successfully.")
    |> redirect(to: expense_path(conn, :index))
  end
end
