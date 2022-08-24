defmodule DataHouse.Repo do
  use Ecto.Repo,
    otp_app: :data_house,
    adapter: Ecto.Adapters.MyXQL
end
