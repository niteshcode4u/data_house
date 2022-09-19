defmodule DataHouse.TwitchData.Fixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DataHouse.TwitchDatas` context.
  """

  alias DataHouse.Models.TwitchData

  @doc """
  Generate a twitch_data.
  """
  def twitch_data_fixture(attrs \\ %{}) do
    {:ok, twitch_data} =
      attrs
      |> Enum.into(%{
        avg_viewers: 42,
        channel: "some channel",
        followers: 42,
        followers_gained: 42,
        language: "some language",
        mature: true,
        partnered: true,
        peak_viewers: 42,
        stream_time: 42,
        views_gained: 42,
        watch_time: 42
      })
      |> TwitchData.create_twitch_data()

    twitch_data
  end
end
