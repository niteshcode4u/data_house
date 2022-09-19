defmodule DataHouse.Services.Helper do
  @moduledoc """
  A helper module to handles service/ logic related work common to others
  """

  alias Broadway.Message
  alias DataHouse.Models.Dielectrons
  alias DataHouse.Models.Memes
  alias DataHouse.Models.TwitchData

  @rmq_user Application.compile_env!(:data_house, :rabbit_mq)[:username]
  @rmq_password Application.compile_env!(:data_house, :rabbit_mq)[:password]
  @data_sets [
    dielectrons: ~w(run event e1 px1 py1 pz1 pt1 eta1 phi1 q1 e2 px2 py2 pz2 pt2 eta2 phi2 q2 m)a,
    memes: ~w(meme_id archived_url base_meme_name meme_page_url md5_hash file_size alt_text)a,
    twitchdata:
      ~w(channel watch_time stream_time peak_viewers avg_viewers followers followers_gained views_gained partnered mature language)a
  ]

  @spec get_subscriber_options(any, String.t()) :: [
          {:batchers, [{any, any}, ...]}
          | {:name, any}
          | {:processors, [{any, any}, ...]}
          | {:producers, [{any, any}, ...]},
          ...
        ]
  def get_subscriber_options(module, queue) do
    [
      name: module,
      producers: [
        default: [
          module:
            {BroadwayRabbitMQ.Producer,
             queue: queue,
             connection: [
               username: @rmq_user,
               password: @rmq_password
             ]},
          stages: 1
        ]
      ],
      processors: [
        default: [
          stages: 100
        ]
      ],
      batchers: [
        data_house: [
          batch_size: 100,
          batch_timeout: 10,
          stages: 100
        ],
        default: []
      ]
    ]
  end

  @spec get_parsed_records(:dielectrons | :memes | :twitchdata, binary) :: [...]
  def get_parsed_records(data_set, record) do
    @data_sets[data_set]
    |> senatize_consumed_data(record)
    |> parse_data_types(data_set)
    |> add_timestamps()
  end

  @spec get_filtered_n_formatted_to_insert(Message.t(), :dielectrons | :memes | :twitchdata) ::
          {list, list}
  def get_filtered_n_formatted_to_insert(messages, data_set) do
    {data_sets, list_of_exsting_data} = filter_and_format_data(messages, data_set)

    mysql_data = data_sets |> Map.drop(list_of_exsting_data) |> Map.values()
    redis_data = mysql_data |> Enum.map(&(&1 |> Map.new() |> :erlang.term_to_binary()))

    {mysql_data, redis_data}
  end

  defp senatize_consumed_data(data_set_cols, data) do
    Enum.zip(data_set_cols, String.split(data, ","))
  end

  defp parse_data_types(records, :memes) do
    Enum.map(records, fn
      {key, value} when key in ~w(file_size)a ->
        {key, String.to_integer(value)}

      {key, value} ->
        {key, value}
    end)
  end

  defp parse_data_types(records, :twitchdata) do
    Enum.map(records, fn
      {key, value} when key in ~w(mature partnered)a ->
        {key, parse_to_get_boolean(value)}

      {key, value} when key in ~w(language channel)a ->
        {key, value}

      {key, value} ->
        {key, String.to_integer(value)}
    end)
  end

  defp parse_data_types(records, :dielectrons) do
    Enum.map(records, fn
      {key, value} when key in ~w(event q1 run)a ->
        {key, String.to_integer(value)}

      {key, value} when key in ~w(m)a ->
        {key, value |> String.trim("\n") |> Decimal.new()}

      {key, value} ->
        {key, Decimal.new(value)}
    end)
  end

  defp add_timestamps(records) do
    naive_datetime = NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)
    records ++ [inserted_at: naive_datetime, updated_at: naive_datetime]
  end

  defp parse_to_get_boolean("True"), do: true
  defp parse_to_get_boolean("False"), do: false

  defp filter_and_format_data(messages, :memes) do
    data_sets =
      Map.new(messages, fn %Message{data: data} ->
        {data[:meme_id], data}
      end)

    {data_sets, data_sets |> Map.keys() |> Memes.list_memes_by_meme_id()}
  end

  defp filter_and_format_data(messages, :twitchdata) do
    data_sets =
      Map.new(messages, fn %Message{data: data} ->
        {data[:channel], data}
      end)

    {data_sets, data_sets |> Map.keys() |> TwitchData.list_twitchdata_by_channels()}
  end

  defp filter_and_format_data(messages, :dielectrons) do
    data_sets =
      Map.new(messages, fn %Message{data: data} ->
        {"#{data[:run]}-#{data[:event]}", data}
      end)

    list_of_existing_dielectrons =
      data_sets
      |> Map.keys()
      |> Enum.reduce({[], []}, fn key, {runs, events} ->
        [run, event] = String.split(key, "-")

        {[run | runs], [event | events]}
      end)
      |> Dielectrons.list_dielectrons_by_run_n_event()
      |> Enum.map(fn key ->
        [first, last] = key
        "#{first}-#{last}"
      end)

    {data_sets, list_of_existing_dielectrons}
  end
end
