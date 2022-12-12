defmodule Murad.Repo.Migrations.CreateLoans do
  use Ecto.Migration

  def change do
    create table(:loans) do
      add :email, :string
      add :amount, :decimal
      add :term, :integer
      add :interest_ratio, :decimal
      add :monthly_amount, :decimal

      timestamps()
    end
  end
end
