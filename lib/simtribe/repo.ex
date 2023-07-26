defmodule SimTribe.Repo do
  use Ecto.Repo,
    otp_app: :simtribe,
    adapter: Ecto.Adapters.Postgres
end
