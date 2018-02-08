defmodule MundumWeb.PathHelpers do
	use Phoenix.HTML
	
    @doc """
  	Used to generate name for path helper function
  	"""
	def item_path_func_name(item_name_singular) do
		String.to_atom(String.replace(item_name_singular, " ", "_") <> "_path")
	end

	@doc """
  	Returns path for item
  	(e.g. :index, :show, :new)
  	"""
	def path_for_item(conn, item_name_singular, path_atom) do
		apply(MundumWeb.Router.Helpers, item_path_func_name(item_name_singular), [conn, path_atom])
	end

	@doc """
  	Returns path for item instance
  	(e.g. :edit and :show)
  	"""
	def path_for_item(conn, item_name_singular, path_atom, item_instance) do
		apply(MundumWeb.Router.Helpers, item_path_func_name(item_name_singular), [conn, path_atom, item_instance])
	end
	
	@doc """
  	Used to turn a url that might be nil into a link
  	"""
  	def linkify(nil) do
  		nil
  	end
  	
  	def linkify(url) do
  		link(url, to: url)
  	end
end