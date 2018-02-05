defmodule MundumWeb.PageController do
  use MundumWeb, :controller

  def index(conn, _params) do
    fields = ["expense", "category", "supercategory"]
    render conn, "index.html", fields: fields
  end
end
