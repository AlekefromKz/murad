defmodule Murad.AccountsTest do
  use Murad.DataCase

  alias Murad.Accounts

  describe "users" do
    alias Murad.Accounts.User

    import Murad.AccountsFixtures

    @invalid_attrs %{email: nil, full_name: nil, monthly_income: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{email: "some email", full_name: "some full_name", monthly_income: "120.5"}

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.email == "some email"
      assert user.full_name == "some full_name"
      assert user.monthly_income == Decimal.new("120.5")
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{email: "some updated email", full_name: "some updated full_name", monthly_income: "456.7"}

      assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
      assert user.email == "some updated email"
      assert user.full_name == "some updated full_name"
      assert user.monthly_income == Decimal.new("456.7")
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "loans" do
    alias Murad.Accounts.Loan

    import Murad.AccountsFixtures

    @invalid_attrs %{amount: nil, email: nil, term: nil}

    test "list_loans/0 returns all loans" do
      loan = loan_fixture()
      assert Accounts.list_loans() == [loan]
    end

    test "get_loan!/1 returns the loan with given id" do
      loan = loan_fixture()
      assert Accounts.get_loan!(loan.id) == loan
    end

    test "create_loan/1 with valid data creates a loan" do
      valid_attrs = %{amount: "120.5", email: "some email", term: 42}

      assert {:ok, %Loan{} = loan} = Accounts.create_loan(valid_attrs)
      assert loan.amount == Decimal.new("120.5")
      assert loan.email == "some email"
      assert loan.term == 42
    end

    test "create_loan/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_loan(@invalid_attrs)
    end

    test "update_loan/2 with valid data updates the loan" do
      loan = loan_fixture()
      update_attrs = %{amount: "456.7", email: "some updated email", term: 43}

      assert {:ok, %Loan{} = loan} = Accounts.update_loan(loan, update_attrs)
      assert loan.amount == Decimal.new("456.7")
      assert loan.email == "some updated email"
      assert loan.term == 43
    end

    test "update_loan/2 with invalid data returns error changeset" do
      loan = loan_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_loan(loan, @invalid_attrs)
      assert loan == Accounts.get_loan!(loan.id)
    end

    test "delete_loan/1 deletes the loan" do
      loan = loan_fixture()
      assert {:ok, %Loan{}} = Accounts.delete_loan(loan)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_loan!(loan.id) end
    end

    test "change_loan/1 returns a loan changeset" do
      loan = loan_fixture()
      assert %Ecto.Changeset{} = Accounts.change_loan(loan)
    end
  end
end
