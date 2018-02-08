defmodule MundumWeb.FormHelpers do
    use Phoenix.HTML
  
    @doc """
  	Used for forms to determine if required
  	"""
  	def field_required?(field_atom, required_fields) do
  		required_fields |> Enum.member?(field_atom)
  	end
  	
  	def field_required_label_class(true) do
  		"required"
  	end
  	
  	def field_required_label_class(false) do
  		""
  	end
  	
	def form_item_label(f, field, required_fields) do
		label f, field, class: "control-label " <> field_required_label_class(field_required?(field, required_fields))
	end
	
	def form_input(f, :string, field, required_fields, nil) do
		text_input(f, field, class: "form-control", required: field_required?(field, required_fields))
	end
	
	def form_input(f, :number, field, required_fields, nil) do
		number_input(f, field, class: "form-control", required: field_required?(field, required_fields))
	end
	
	def form_input(f, :text, field, required_fields, nil) do
		textarea(f, field, class: "form-control", required: field_required?(field, required_fields), cols: 80, rows: 10)
	end
	
	def form_input(f, :date, field, required_fields, nil) do
		date_select(f, field, class: "form-control", required: field_required?(field, required_fields), year: [options: 2016..DateTime.utc_now.year], builder: fn b ->
		   ~e"""
		    Date: <%= b.(:month, []) %> / <%= b.(:day, []) %> / <%= b.(:year, []) %>
		    """ 
		    end
		 )
	end
	
	def form_input(f, :select, field, required_fields, items) do
		select(f, field, items, class: "form-control", required: field_required?(field, required_fields))
	end
end