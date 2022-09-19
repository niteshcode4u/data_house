defmodule DataHouse.DataCase do
  @moduledoc """
  This module defines the setup for tests requiring
  access to the application's data layer.

  You may define functions here to be used as helpers in
  your tests.

  Finally, if the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use DataHouse.DataCase, async: true`, although
  this option is not recommended for other databases.
  """

  use ExUnit.CaseTemplate

  alias DataHouse.Services.Publisher
  alias Ecto.Adapters.SQL.Sandbox

  using do
    quote do
      alias DataHouse.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import DataHouse.DataCase
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

    :ok
  end
end
