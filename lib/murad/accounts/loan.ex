defmodule Murad.Accounts.Loan do
  use Ecto.Schema
  alias Murad.Accounts
  import Ecto.Query, only: [from: 2]
  import Ecto.Changeset
  alias Murad.Repo
  require Logger

  schema "loans" do
    field :amount, :decimal
    field :email, :string
    field :term, :integer

    field :interest_ratio, :decimal, default: 0.0
    field :monthly_amount, :decimal, default: 0.0

    timestamps()
  end

  @spec changeset(
          {map, map}
          | %{
              :__struct__ => atom | %{:__changeset__ => map, optional(any) => any},
              optional(atom) => any
            },
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  @doc false
  def changeset(loan, attrs) do
    loan
    |> cast(attrs, [:email, :amount, :term, :monthly_amount, :interest_ratio])
    |> validate_required([:email, :amount, :term])
    |> validate_number(:term, less_than: 15, greater_than: 0)
    |> validate_email()
    |> validate_no_active_loan()
    |> validate_monthly_salary()
  end

  defp validate_email(changeset) do
    email = get_field(changeset, :email)

    case email != nil do
      true -> query = from o in Accounts.User, where: o.email == ^email
        case Repo.exists?(query) do
          false -> add_error(changeset, :email, "Such user does not exist")
          _ -> changeset
        end
      _ -> changeset
    end
  end


  defp validate_no_active_loan(changeset) do
    email = get_field(changeset, :email)

    case email != nil do
      true -> query = from o in Accounts.Loan, where: o.email == ^email
        case Repo.exists?(query) do
          true -> add_error(changeset, :email, "You have requested before. Get Out!")
          _ -> changeset
        end
      _ -> changeset
    end
  end


  defp validate_monthly_salary(changeset) do
    term = get_field(changeset, :term)
    amount = get_field(changeset, :amount)
    email = get_field(changeset, :email)

    case term != nil do
      true ->
        interest_ratio = if term > 10 do
          5.0
        else
          if term > 5 do
            3.5
          else
            2.5
          end
        end

        amount_float = Float.parse(to_string(amount)) |> elem(0)
        total_amount = amount_float + (amount_float * interest_ratio / 100)

        query = from o in Accounts.User, where: o.email == ^email, select: o.monthly_income
        monthly_income = Float.parse(to_string(hd(Repo.all(query)))) |> elem(0)

        monthly_amount = total_amount / (term * 12)
        Logger.error(changeset)
        Logger.error(changeset)
        Logger.error(changeset)
        Logger.error(changeset)
        put_change(changeset, :interest_ratio, interest_ratio)
        put_change(changeset, :monthly_amount, monthly_amount)

        Logger.error(changeset)
        Logger.error(changeset)
        Logger.error(changeset)
        Logger.error(changeset)


        case monthly_amount > monthly_income * 0.4 do
          true -> add_error(changeset, :amount, "You can't pay more than 40 % of your salary")
          _ -> changeset

        end
      _ -> changeset
    end
  end
end
