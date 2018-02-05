defmodule Mundum.Editor.Expense do
  use Ecto.Schema
  import Ecto.Changeset
  alias Mundum.Editor.Expense


  schema "expenses" do
    field :amortize_through, :date
    field :amount, :decimal
    field :date_incurred, :date
    field :description, :string
    field :category_id, :id

    timestamps()
  end
  
  @doc """
	Validate that amount is greater than 0
	"""
	def validate_amount(changeset) do
	  amount_key = :amount
		amount = get_field(changeset, amount_key)
    
    if amount <= 0 do
      add_error(changeset, amount_key, "Amount must be greater than 0")
    else
      changeset
    end
	end
	
	@doc """
	Validate that amortize_through either blank, or amortize_through date is at least 1 month greater than date incurred
	"""
	def validate_amortize_through(changeset) do
	  amortize_through_key = :amortize_through
		amortize_through = get_field(changeset, amortize_through_key)
    date_incurred = get_field(changeset, :date_incurred)
    
    if !is_nil(amortize_through) and (amortize_through.year < date_incurred.year or (amortize_through.year == date_incurred.year and amortize_through.month <= date_incurred.month)) do
      add_error(changeset, amortize_through_key, "Amortize through date must be at least 1 month greater than date incurred")
    else
      changeset
    end
	end

  @doc false
  def changeset(%Expense{} = expense, attrs) do
    expense
    |> cast(attrs, [:amount, :description, :date_incurred, :amortize_through, :category_id])
    |> validate_required(required_fields())
    |> validate_amount
    |> validate_amortize_through
  end
  
  def required_fields do
    [:amount, :description, :date_incurred, :category_id]
  end
end
