defmodule WhiteBreadContext do
  use WhiteBread.Context
  use Hound.Helpers
  alias Murad.{Repo, Accounts.User}
  use Ecto.Schema
  alias Murad.Accounts
  import Ecto.Query, only: [from: 2]
  import Ecto.Changeset
  alias Murad.Repo
  require Logger

  feature_starting_state fn  ->
    Application.ensure_all_started(:hound)
    %{}
  end
  scenario_starting_state fn _state ->
    Hound.start_session
    %{}
  end
  scenario_finalize fn _status, _state ->
    # Hound.end_session
    nil
  end

  given_ ~r/^the following users are existing$/, fn state, %{table_data: table}  ->
    table
    |> Enum.map(fn user -> User.changeset(%User{}, user) end)
    |> Enum.each(fn changeset ->
        query = from o in User, where: o.email == ^changeset.changes.email
        case Repo.exists?(query) do
          false -> Repo.insert!(changeset)
          _ -> nil
        end
      end
    )
    {:ok, state}
  end

  and_ ~r/^I want to go to the loan request page$/, fn state ->
    navigate_to "/loans/new"
    {:ok, state}
  end

  and_ ~r/^I want to request loan for "(?<email>[^"]+)" of "(?<amount>[^"]+)" euro for "(?<term>[^"]+)" years$/,
  fn state, %{email: email, amount: amount,term: term} ->
    fill_field({:id, "email"}, email)
      fill_field({:id, "amount"}, amount)
      fill_field({:id, "term"}, term)
    {:ok, state}
  end

  when_ ~r/^I submit the loan request$/, fn state ->
    {:ok, state}
  end

  then_ ~r/^I should receive a confirmation message$/, fn state ->
    {:ok, state}
  end
end
