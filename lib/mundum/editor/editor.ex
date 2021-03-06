defmodule Mundum.Editor do
  @moduledoc """
  The Editor context.
  """

  import Ecto.Query, warn: false
  alias Mundum.Repo

  alias Mundum.Editor.Supercategory

  @doc """
  Returns the list of supercategories.

  ## Examples

      iex> list_supercategories()
      [%Supercategory{}, ...]

  """
  def list_supercategories do
    Repo.all(from(Supercategory, order_by: :name))
  end

  @doc """
  Gets a single supercategory.

  Raises `Ecto.NoResultsError` if the Supercategory does not exist.

  ## Examples

      iex> get_supercategory!(123)
      %Supercategory{}

      iex> get_supercategory!(456)
      ** (Ecto.NoResultsError)

  """
  def get_supercategory!(id), do: Repo.get!(Supercategory, id)

  @doc """
  Creates a supercategory.

  ## Examples

      iex> create_supercategory(%{field: value})
      {:ok, %Supercategory{}}

      iex> create_supercategory(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_supercategory(attrs \\ %{}) do
    %Supercategory{}
    |> Supercategory.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a supercategory.

  ## Examples

      iex> update_supercategory(supercategory, %{field: new_value})
      {:ok, %Supercategory{}}

      iex> update_supercategory(supercategory, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_supercategory(%Supercategory{} = supercategory, attrs) do
    supercategory
    |> Supercategory.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Supercategory.

  ## Examples

      iex> delete_supercategory(supercategory)
      {:ok, %Supercategory{}}

      iex> delete_supercategory(supercategory)
      {:error, %Ecto.Changeset{}}

  """
  def delete_supercategory(%Supercategory{} = supercategory) do
    Repo.delete(supercategory)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking supercategory changes.

  ## Examples

      iex> change_supercategory(supercategory)
      %Ecto.Changeset{source: %Supercategory{}}

  """
  def change_supercategory(%Supercategory{} = supercategory) do
    Supercategory.changeset(supercategory, %{})
  end

  alias Mundum.Editor.Category

  @doc """
  Returns the list of categories.

  ## Examples

      iex> list_categories()
      [%Category{}, ...]

  """
  def list_categories do
    Repo.all(from(Category, order_by: :name))
  end

  @doc """
  Gets a single category.

  Raises `Ecto.NoResultsError` if the Category does not exist.

  ## Examples

      iex> get_category!(123)
      %Category{}

      iex> get_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_category!(id), do: Repo.get!(Category, id)

  @doc """
  Creates a category.

  ## Examples

      iex> create_category(%{field: value})
      {:ok, %Category{}}

      iex> create_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a category.

  ## Examples

      iex> update_category(category, %{field: new_value})
      {:ok, %Category{}}

      iex> update_category(category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_category(%Category{} = category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Category.

  ## Examples

      iex> delete_category(category)
      {:ok, %Category{}}

      iex> delete_category(category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_category(%Category{} = category) do
    Repo.delete(category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking category changes.

  ## Examples

      iex> change_category(category)
      %Ecto.Changeset{source: %Category{}}

  """
  def change_category(%Category{} = category) do
    Category.changeset(category, %{})
  end

  alias Mundum.Editor.Expense

  @doc """
  Returns the list of expenses.

  ## Examples

      iex> list_expenses()
      [%Expense{}, ...]

  """
  def list_expenses do
    Repo.all(from(Expense, order_by: [desc: :date_incurred, desc: :id]))
  end

  @doc """
  Gets a single expense.

  Raises `Ecto.NoResultsError` if the Expense does not exist.

  ## Examples

      iex> get_expense!(123)
      %Expense{}

      iex> get_expense!(456)
      ** (Ecto.NoResultsError)

  """
  def get_expense!(id), do: Repo.get!(Expense, id)

  @doc """
  Creates a expense.

  ## Examples

      iex> create_expense(%{field: value})
      {:ok, %Expense{}}

      iex> create_expense(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_expense(attrs \\ %{}) do
    %Expense{}
    |> Expense.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a expense.

  ## Examples

      iex> update_expense(expense, %{field: new_value})
      {:ok, %Expense{}}

      iex> update_expense(expense, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_expense(%Expense{} = expense, attrs) do
    expense
    |> Expense.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Expense.

  ## Examples

      iex> delete_expense(expense)
      {:ok, %Expense{}}

      iex> delete_expense(expense)
      {:error, %Ecto.Changeset{}}

  """
  def delete_expense(%Expense{} = expense) do
    Repo.delete(expense)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking expense changes.

  ## Examples

      iex> change_expense(expense)
      %Ecto.Changeset{source: %Expense{}}

  """
  def change_expense(%Expense{} = expense) do
    Expense.changeset(expense, %{})
  end
end
