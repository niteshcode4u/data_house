defmodule DataHouse.Services.DataProcessor do
  @moduledoc """
    Module is used to parse csv file and push parsed data to Publisher asynchronously.
  """

  alias DataHouse.Services.Publisher

  @queues %{
    "twitchdata" => Publisher.twitchdata_queue_name(),
    "memes" => Publisher.memes_queue_name(),
    "dielectrons" => Publisher.dielectrons_queue_name()
  }

  @doc """
  Parse CSVs files and prepare data to publish asynchronously.
  file_path(local) & dataset for:

      dielectrons - ["priv/repo/dielectron.csv", "dielectrons"]
      meme - ["priv/repo/memegenerator.csv", "memes"]
      twitchdata - ["priv/repo/twitchdata-update.csv", "twitchdata"]

  Example:

      alias DataHouse.Services.DataProcessor
      DataProcessor.parse_csv("priv/repo/dielectron.csv", "dielectrons")
  """

  @spec parse_csv(String.t(), String.t()) :: list
  def parse_csv(file_path, data_set) do
    file_path
    |> File.stream!()
    |> Stream.drop(1)
    |> Task.async_stream(&push_to_publisher(&1, data_set), max_concurrency: 2)
    |> Enum.to_list()
  end

  defp push_to_publisher(data_to_publish, data_set),
    do: Publisher.publish(@queues[data_set], data_to_publish)
end
