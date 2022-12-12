defmodule MuradWeb.LoanController do
  import Ecto.Query, only: [from: 2]
  use MuradWeb, :controller

  alias Murad.Accounts
  alias Murad.Repo
  require Logger

  def index(conn, _params) do
    loans = Accounts.list_loans()
    render(conn, "index.html", loans: loans)
  end

  def new(conn, _params) do
    changeset = Accounts.change_loan(%Accounts.Loan{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"loan" => loan_params}) do
    
    case Accounts.create_loan(loan_params) do
      {:ok, loan} ->
        conn
        |> put_flash(:info, "Loan created successfully.")
        |> redirect(to: Routes.loan_path(conn, :show, loan))

      {_, %Ecto.Changeset{} = changeset} ->
        conn |> put_flash(:error, "Sorry, you are not eligible for the loan")
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    loan = Accounts.get_loan!(id)
    render(conn, "show.html", loan: loan)
  end

  def edit(conn, %{"id" => id}) do
    loan = Accounts.get_loan!(id)
    changeset = Accounts.change_loan(loan)
    render(conn, "edit.html", loan: loan, changeset: changeset)
  end

  def update(conn, %{"id" => id, "loan" => loan_params}) do
    loan = Accounts.get_loan!(id)

    case Accounts.update_loan(loan, loan_params) do
      {:ok, loan} ->
        conn
        |> put_flash(:info, "Loan updated successfully.")
        |> redirect(to: Routes.loan_path(conn, :show, loan))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", loan: loan, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    loan = Accounts.get_loan!(id)
    {:ok, _loan} = Accounts.delete_loan(loan)

    conn
    |> put_flash(:info, "Loan deleted successfully.")
    |> redirect(to: Routes.loan_path(conn, :index))
  end
end
