defmodule MuradWeb.LoanControllerTest do
  use MuradWeb.ConnCase
  import Murad.AccountsFixtures

  @create_attrs %{amount: "120.5", email: "delofeu@gmail.com", term: 5}
  @invalid_attrs %{amount: nil, email: nil, term: nil}

  describe "index" do
    test "lists all loans", %{conn: conn} do
      conn = get(conn, Routes.loan_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Loans"
    end
  end

  describe "new loan" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.loan_path(conn, :new))
      assert html_response(conn, 200) =~ "New Loan"
    end
  end

  describe "create loan success" do
    setup [:create_user]

    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.loan_path(conn, :create), loan: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.loan_path(conn, :show, id)

      conn = get(conn, Routes.loan_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Loan"
    end
  end

  describe "create loan error" do
    setup [:create_user]
    setup [:create_loan]

    test "does not create loan if there is existing one", %{conn: conn} do
      conn = post(conn, Routes.loan_path(conn, :create), loan: @create_attrs)
      assert html_response(conn, 200) =~ "You have requested before. Get Out!"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.loan_path(conn, :create), loan: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Loan"
    end
  end


  defp create_loan(_) do
    loan = loan_fixture()
    %{loan: loan}
  end

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end
end
