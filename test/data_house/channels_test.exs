defmodule DataHouse.ChannelsTest do
  use DataHouse.DataCase

  alias DataHouse.Models.Channels

  describe "channels" do
    alias DataHouse.Schemas.Channel

    import DataHouse.ChannelsFixtures

    @invalid_attrs %{
      avg_viewers: nil,
      channel: nil,
      followers: nil,
      followers_gained: nil,
      language: nil,
      mature: nil,
      partnered: nil,
      peak_viewers: nil,
      stream_time: nil,
      views_gained: nil,
      watch_time: nil
    }

    test "list_channels/0 returns all channels" do
      channel = channel_fixture()
      assert Channels.list_channels() == [channel]
    end

    test "get_channel!/1 returns the channel with given id" do
      channel = channel_fixture()
      assert Channels.get_channel!(channel.id) == channel
    end

    test "create_channel/1 with valid data creates a channel" do
      valid_attrs = %{
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
      }

      assert {:ok, %Channel{} = channel} = Channels.create_channel(valid_attrs)
      assert channel.avg_viewers == 42
      assert channel.channel == "some channel"
      assert channel.followers == 42
      assert channel.followers_gained == 42
      assert channel.language == "some language"
      assert channel.mature == true
      assert channel.partnered == true
      assert channel.peak_viewers == 42
      assert channel.stream_time == 42
      assert channel.views_gained == 42
      assert channel.watch_time == 42
    end

    test "create_channel/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Channels.create_channel(@invalid_attrs)
    end

    test "update_channel/2 with valid data updates the channel" do
      channel = channel_fixture()

      update_attrs = %{
        avg_viewers: 43,
        channel: "some updated channel",
        followers: 43,
        followers_gained: 43,
        language: "some updated language",
        mature: false,
        partnered: false,
        peak_viewers: 43,
        stream_time: 43,
        views_gained: 43,
        watch_time: 43
      }

      assert {:ok, %Channel{} = channel} = Channels.update_channel(channel, update_attrs)
      assert channel.avg_viewers == 43
      assert channel.channel == "some updated channel"
      assert channel.followers == 43
      assert channel.followers_gained == 43
      assert channel.language == "some updated language"
      assert channel.mature == false
      assert channel.partnered == false
      assert channel.peak_viewers == 43
      assert channel.stream_time == 43
      assert channel.views_gained == 43
      assert channel.watch_time == 43
    end

    test "update_channel/2 with invalid data returns error changeset" do
      channel = channel_fixture()
      assert {:error, %Ecto.Changeset{}} = Channels.update_channel(channel, @invalid_attrs)
      assert channel == Channels.get_channel!(channel.id)
    end

    test "delete_channel/1 deletes the channel" do
      channel = channel_fixture()
      assert {:ok, %Channel{}} = Channels.delete_channel(channel)
      assert_raise Ecto.NoResultsError, fn -> Channels.get_channel!(channel.id) end
    end

    test "change_channel/1 returns a channel changeset" do
      channel = channel_fixture()
      assert %Ecto.Changeset{} = Channels.change_channel(channel)
    end
  end
end
