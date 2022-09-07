defmodule DataHouse.ChannelsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DataHouse.Channels` context.
  """

  @doc """
  Generate a channel.
  """
  def channel_fixture(attrs \\ %{}) do
    {:ok, channel} =
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
      |> DataHouse.Models.Channels.create_channel()

    channel
  end
end
