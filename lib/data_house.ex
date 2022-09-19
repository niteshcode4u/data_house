defmodule DataHouse do
  @moduledoc """
  DataHouse keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  @pagination_limit 99

  @spec get_data(String.t(), number()) :: list
  def get_data(key, pagination_offset) do
    pagination_offset =
      if is_nil(pagination_offset), do: 0, else: String.to_integer(pagination_offset)

    {:ok, records} =
      Redix.command(:redix, [
        "LRANGE",
        "#{key}",
        pagination_offset,
        pagination_offset + @pagination_limit
      ])

    format_fetched_records(key, records)
  end

  defp format_fetched_records("twitchdata", records) do
    Enum.map(records, fn record -> :erlang.binary_to_term(record) end)
  end

  defp format_fetched_records("memes", records) do
    Enum.map(records, fn record -> :erlang.binary_to_term(record) end)
  end

  defp format_fetched_records("dielectrons", records) do
    Enum.map(records, fn record -> :erlang.binary_to_term(record) end)
  end
end
