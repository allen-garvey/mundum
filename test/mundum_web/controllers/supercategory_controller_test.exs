defmodule MundumWeb.SupercategoryControllerTest do
  use MundumWeb.ConnCase

  alias Mundum.Editor

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:supercategory) do
    {:ok, supercategory} = Editor.create_supercategory(@create_attrs)
    supercategory
  end

  describe "index" do
    test "lists all supercategories", %{conn: conn} do
      conn = get conn, supercategory_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Supercategories"
    end
  end

  describe "new supercategory" do
    test "renders form", %{conn: conn} do
      conn = get conn, supercategory_path(conn, :new)
      assert html_response(conn, 200) =~ "New Supercategory"
    end
  end

  describe "create supercategory" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, supercategory_path(conn, :create), supercategory: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == supercategory_path(conn, :show, id)

      conn = get conn, supercategory_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Supercategory"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, supercategory_path(conn, :create), supercategory: @invalid_attrs
      assert html_response(conn, 200) =~ "New Supercategory"
    end
  end

  describe "edit supercategory" do
    setup [:create_supercategory]

    test "renders form for editing chosen supercategory", %{conn: conn, supercategory: supercategory} do
      conn = get conn, supercategory_path(conn, :edit, supercategory)
      assert html_response(conn, 200) =~ "Edit Supercategory"
    end
  end

  describe "update supercategory" do
    setup [:create_supercategory]

    test "redirects when data is valid", %{conn: conn, supercategory: supercategory} do
      conn = put conn, supercategory_path(conn, :update, supercategory), supercategory: @update_attrs
      assert redirected_to(conn) == supercategory_path(conn, :show, supercategory)

      conn = get conn, supercategory_path(conn, :show, supercategory)
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, supercategory: supercategory} do
      conn = put conn, supercategory_path(conn, :update, supercategory), supercategory: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Supercategory"
    end
  end

  describe "delete supercategory" do
    setup [:create_supercategory]

    test "deletes chosen supercategory", %{conn: conn, supercategory: supercategory} do
      conn = delete conn, supercategory_path(conn, :delete, supercategory)
      assert redirected_to(conn) == supercategory_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, supercategory_path(conn, :show, supercategory)
      end
    end
  end

  defp create_supercategory(_) do
    supercategory = fixture(:supercategory)
    {:ok, supercategory: supercategory}
  end
end
