defmodule MundumWeb.Router do
  use MundumWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MundumWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    
    #resources
    resources "/supercategories", SupercategoryController
    resources "/categories", CategoryController
    resources "/expenses", ExpenseController
  end

  # Other scopes may use custom stacks.
  # scope "/api", MundumWeb do
  #   pipe_through :api
  # end
end
