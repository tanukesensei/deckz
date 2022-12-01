defmodule Deckz.Repo do
  use Ecto.Repo,
    otp_app: :deckz,
    adapter: Ecto.Adapters.Postgres
end
