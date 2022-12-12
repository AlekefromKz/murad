defmodule WhiteBreadContext do
  use WhiteBread.Context
  use Hound.Helpers


  feature_starting_state fn  ->
    Application.ensure_all_started(:hound)
    %{}
  end

  scenario_starting_state fn _state ->
    Hound.start_session
    %{}
  end

  scenario_finalize fn _status, _state ->
    nil
    # Hound.end_session
  end

  given_ ~r/^the following users are existing$/,
  fn state ->
    {:ok, state}
  end

  and_ ~r/^I want to go to the user create page$/, fn state ->
    navigate_to "/users/new "
    assert visible_in_page? ~r/New User/
    {:ok, state}
  end

  and_ ~r/^I enter the data$/, fn state, %{
    full_name: full_name,
    email: email,
    monthly_income: monthly_income,
    } ->

      fill_field({:id, "full_name"}, full_name)
      fill_field({:id, "email"}, email)
      fill_field({:id, "monthly_income"}, monthly_income)
      {:ok, state}
  end

  when_ ~r/^I summit the booking request$/, fn state ->
    click({:id, "submit_customer"})
    {:ok, state}
  end

  then_ ~r/^I should receive a confirmation message$/, fn state ->
    {:ok, state}
  end
end
