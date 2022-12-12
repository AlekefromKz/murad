defmodule Murad.Repo do
  use Ecto.Repo,
    otp_app: :murad,
    adapter: Ecto.Adapters.Postgres
end
