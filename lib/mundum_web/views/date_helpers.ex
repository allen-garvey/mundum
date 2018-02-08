defmodule MundumWeb.DateHelpers do
    @doc """
  	Returns inserted_at date as string for ecto model
  	"""
  	def item_date_created(item) do
  		"#{date_to_iso_string(item.inserted_at)} #{pad_date_digit(item.inserted_at.hour)}:#{pad_date_digit(item.inserted_at.minute)}"
  	end
  	
  	@doc """
  	Returns date as iso_formatted string YYYY-MM-DD
  	"""
  	def date_to_iso_string(date) do
  		"#{date.year}-#{pad_date_digit(date.month)}-#{pad_date_digit(date.day)}"
  	end
  	
  	def pad_date_digit(digit) do
  		Integer.to_string(digit) |> String.pad_leading(2, ["0"])
  	end
end