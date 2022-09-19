defmodule DataHouse.Services.Subscribers.MemeSubscriber do
  @moduledoc false
  use Broadway

  alias Broadway.Message
  alias DataHouse.Models.Memes
  alias DataHouse.Services.Helper
  alias DataHouse.Services.Publisher

  @spec start_link(any) :: :ignore | {:error, any} | {:ok, pid}
  def start_link(_opts) do
    Broadway.start_link(
      __MODULE__,
      Helper.get_subscriber_options(__MODULE__, Publisher.memes_queue_name())
    )
  end

  @impl true
  def handle_message(_processor, %Message{data: data} = message, _context) do
    parsed_records = Helper.get_parsed_records(:memes, data)
    Message.update_data(message, fn _ -> parsed_records end)
  end

  @impl true
  def handle_batch(_batcher, messages, _batch_info, _context) do
    {mysql_data, redis_data} = Helper.get_filtered_n_formatted_to_insert(messages, :memes)

    Memes.insert_all(mysql_data)
    Redix.command(:redix, ["RPUSH", "memes"] ++ redis_data)

    messages
  end
end
