defmodule DataHouseWeb.DataController do
  use DataHouseWeb, :controller

  @data_sets ~w(dielectrons memes twitchdata)

  def index(conn, %{"query" => data_set} = params) when data_set in @data_sets do
    results = DataHouse.get_data(data_set, params["pagination_offset"])

    conn
    |> put_view(DataHouseWeb.DataView)
    |> render("data.json", %{results: results, topic: data_set})
  end

  def index(conn, _params) do
    conn
    |> put_view(DataHouseWeb.ErrorView)
    |> put_status(:not_found)
    |> render("404.json", %{error: :not_found})
  end
end
