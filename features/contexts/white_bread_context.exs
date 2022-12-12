defmodule WhiteBreadContext do
  use WhiteBread.Context

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

  given_ ~r/^the following users are existing$/, fn state ->
    {:ok, state}
  end

  and_ ~r/^I want to go to the user create page$/, fn state ->
    {:ok, state}
  end

  and_ ~r/^I enter the data$/, fn state ->
    {:ok, state}
  end

  when_ ~r/^I submit the loan request$/, fn state ->
    {:ok, state}
  end

  then_ ~r/^I should receive a confirmation message$/, fn state ->
    {:ok, state}
  end


end
