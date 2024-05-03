defmodule Pupa.Repo do
  use Ecto.Repo,
    otp_app: :pupa,
    adapter: Ecto.Adapters.Postgres
end
