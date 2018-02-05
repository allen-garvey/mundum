defmodule Mundum.EditorTest do
  use Mundum.DataCase

  alias Mundum.Editor

  describe "supercategories" do
    alias Mundum.Editor.Supercategory

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def supercategory_fixture(attrs \\ %{}) do
      {:ok, supercategory} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Editor.create_supercategory()

      supercategory
    end

    test "list_supercategories/0 returns all supercategories" do
      supercategory = supercategory_fixture()
      assert Editor.list_supercategories() == [supercategory]
    end

    test "get_supercategory!/1 returns the supercategory with given id" do
      supercategory = supercategory_fixture()
      assert Editor.get_supercategory!(supercategory.id) == supercategory
    end

    test "create_supercategory/1 with valid data creates a supercategory" do
      assert {:ok, %Supercategory{} = supercategory} = Editor.create_supercategory(@valid_attrs)
      assert supercategory.name == "some name"
    end

    test "create_supercategory/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Editor.create_supercategory(@invalid_attrs)
    end

    test "update_supercategory/2 with valid data updates the supercategory" do
      supercategory = supercategory_fixture()
      assert {:ok, supercategory} = Editor.update_supercategory(supercategory, @update_attrs)
      assert %Supercategory{} = supercategory
      assert supercategory.name == "some updated name"
    end

    test "update_supercategory/2 with invalid data returns error changeset" do
      supercategory = supercategory_fixture()
      assert {:error, %Ecto.Changeset{}} = Editor.update_supercategory(supercategory, @invalid_attrs)
      assert supercategory == Editor.get_supercategory!(supercategory.id)
    end

    test "delete_supercategory/1 deletes the supercategory" do
      supercategory = supercategory_fixture()
      assert {:ok, %Supercategory{}} = Editor.delete_supercategory(supercategory)
      assert_raise Ecto.NoResultsError, fn -> Editor.get_supercategory!(supercategory.id) end
    end

    test "change_supercategory/1 returns a supercategory changeset" do
      supercategory = supercategory_fixture()
      assert %Ecto.Changeset{} = Editor.change_supercategory(supercategory)
    end
  end

  describe "categories" do
    alias Mundum.Editor.Category

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def category_fixture(attrs \\ %{}) do
      {:ok, category} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Editor.create_category()

      category
    end

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert Editor.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Editor.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      assert {:ok, %Category{} = category} = Editor.create_category(@valid_attrs)
      assert category.name == "some name"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Editor.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      assert {:ok, category} = Editor.update_category(category, @update_attrs)
      assert %Category{} = category
      assert category.name == "some updated name"
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Editor.update_category(category, @invalid_attrs)
      assert category == Editor.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Editor.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Editor.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Editor.change_category(category)
    end
  end

  describe "expenses" do
    alias Mundum.Editor.Expense

    @valid_attrs %{amortize_through: ~D[2010-04-17], amount: "120.5", date_incurred: ~D[2010-04-17], description: "some description"}
    @update_attrs %{amortize_through: ~D[2011-05-18], amount: "456.7", date_incurred: ~D[2011-05-18], description: "some updated description"}
    @invalid_attrs %{amortize_through: nil, amount: nil, date_incurred: nil, description: nil}

    def expense_fixture(attrs \\ %{}) do
      {:ok, expense} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Editor.create_expense()

      expense
    end

    test "list_expenses/0 returns all expenses" do
      expense = expense_fixture()
      assert Editor.list_expenses() == [expense]
    end

    test "get_expense!/1 returns the expense with given id" do
      expense = expense_fixture()
      assert Editor.get_expense!(expense.id) == expense
    end

    test "create_expense/1 with valid data creates a expense" do
      assert {:ok, %Expense{} = expense} = Editor.create_expense(@valid_attrs)
      assert expense.amortize_through == ~D[2010-04-17]
      assert expense.amount == Decimal.new("120.5")
      assert expense.date_incurred == ~D[2010-04-17]
      assert expense.description == "some description"
    end

    test "create_expense/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Editor.create_expense(@invalid_attrs)
    end

    test "update_expense/2 with valid data updates the expense" do
      expense = expense_fixture()
      assert {:ok, expense} = Editor.update_expense(expense, @update_attrs)
      assert %Expense{} = expense
      assert expense.amortize_through == ~D[2011-05-18]
      assert expense.amount == Decimal.new("456.7")
      assert expense.date_incurred == ~D[2011-05-18]
      assert expense.description == "some updated description"
    end

    test "update_expense/2 with invalid data returns error changeset" do
      expense = expense_fixture()
      assert {:error, %Ecto.Changeset{}} = Editor.update_expense(expense, @invalid_attrs)
      assert expense == Editor.get_expense!(expense.id)
    end

    test "delete_expense/1 deletes the expense" do
      expense = expense_fixture()
      assert {:ok, %Expense{}} = Editor.delete_expense(expense)
      assert_raise Ecto.NoResultsError, fn -> Editor.get_expense!(expense.id) end
    end

    test "change_expense/1 returns a expense changeset" do
      expense = expense_fixture()
      assert %Ecto.Changeset{} = Editor.change_expense(expense)
    end
  end
end
