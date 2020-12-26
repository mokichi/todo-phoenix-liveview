defmodule TodoPhoenixLiveview.Repo do
  use Ecto.Repo,
    otp_app: :todo_phoenix_liveview,
    adapter: Ecto.Adapters.Postgres
end
