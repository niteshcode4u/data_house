defmodule DataHouseWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use DataHouseWeb.ConnCase, async: true`, although
  this option is not recommended for other databases.
  """

  use ExUnit.CaseTemplate

  alias DataHouse.Services.Publisher
  alias Ecto.Adapters.SQL.Sandbox

  using do
    quote do
      # Import conveniences for testing with connections
      import Plug.Conn
      import Phoenix.ConnTest
      import DataHouseWeb.ConnCase

      alias DataHouseWeb.Router.Helpers, as: Routes

      # The default endpoint for testing
      @endpoint DataHouseWeb.Endpoint
    end
  end

  setup tags do
    pid = Sandbox.start_owner!(DataHouse.Repo, shared: not tags[:async])

    on_exit(fn ->
      Sandbox.stop_owner(pid)

      Redix.command!(:redix, ["FLUSHALL"])

      queues = [
        Publisher.dielectrons_queue_name(),
        Publisher.memes_queue_name(),
        Publisher.twitchdata_queue_name()
      ]

      Enum.each(queues, fn queue ->
        GenRMQ.Publisher.purge(Publisher, queue)
      end)
    end)

    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
