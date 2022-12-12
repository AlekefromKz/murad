defmodule Murad.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Murad.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "delofeu@gmail.com",
        full_name: "Delofeu Tumasi",
        monthly_income: "1000"
      })
      |> Murad.Accounts.create_user()

    user
  end

  @doc """
  Generate a loan.
  """
  def loan_fixture(attrs \\ %{}) do
    {:ok, loan} =
      attrs
      |> Enum.into(%{
        amount: "120.5",
        email: "delofeu@gmail.com",
        term: 10
      })
      |> Murad.Accounts.create_loan()

    loan
  end
end
