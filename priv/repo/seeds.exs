# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Murad.Repo.insert!(%Murad.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


alias Murad.{Repo, Accounts.User}


[%{full_name: "Fred Flintstone", email: "fred@gmail.com", monthly_income: 1000},
 %{full_name: "Barney Rubble", email: "barney", monthly_income: 2500}]
|> Enum.map(fn user_data -> User.changeset(%User{}, user_data) end)
|> Enum.each(fn changeset -> Repo.insert!(changeset) end)
