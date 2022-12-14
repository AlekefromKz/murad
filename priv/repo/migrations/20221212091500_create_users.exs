defmodule Murad.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :full_name, :string
      add :email, :string
      add :monthly_income, :decimal

      timestamps()
    end
  end
end
