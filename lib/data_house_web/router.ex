defmodule DataHouseWeb.Router do
  use DataHouseWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", DataHouseWeb do
    pipe_through :api

    get "/data", DataController, :index
  end
end
