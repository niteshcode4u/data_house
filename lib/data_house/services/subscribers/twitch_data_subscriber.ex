defmodule DataHouse.Services.Subscribers.TwitchdataSubscriber do
  @moduledoc false
  use Broadway

  alias Broadway.Message
  alias DataHouse.Models.TwitchData
  alias DataHouse.Services.Helper
  alias DataHouse.Services.Publisher

  @spec start_link(any) :: :ignore | {:error, any} | {:ok, pid}
  def start_link(_opts) do
    Broadway.start_link(
      __MODULE__,
      Helper.get_subscriber_options(__MODULE__, Publisher.twitchdata_queue_name())
    )
  end

  @impl true
  @spec handle_message(any, Broadway.Message.t(), any) :: Broadway.Message.t()
  def handle_message(_processor, %Message{data: data} = message, _context) do
    parsed_records = Helper.get_parsed_records(:twitchdata, data)
    Message.update_data(message, fn _ -> parsed_records end)
  end

  @impl true
  def handle_batch(_batcher, messages, _batch_info, _context) do
    {mysql_data, redis_data} = Helper.get_filtered_n_formatted_to_insert(messages, :twitchdata)

    TwitchData.insert_all(mysql_data)
    Redix.command(:redix, ["RPUSH", "twitchdata"] ++ redis_data)

    messages
  end
end
