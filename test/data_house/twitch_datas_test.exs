defmodule DataHouse.TwitchDatasTest do
  use DataHouse.DataCase

  alias DataHouse.TwitchDatas

  describe "twitchdata" do
    alias DataHouse.TwitchDatas.TwitchData

    import DataHouse.TwitchDatasFixtures

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

    test "list_twitchdata/0 returns all twitchdata" do
      twitch_data = twitch_data_fixture()
      assert TwitchDatas.list_twitchdata() == [twitch_data]
    end

    test "get_twitch_data!/1 returns the twitch_data with given id" do
      twitch_data = twitch_data_fixture()
      assert TwitchDatas.get_twitch_data!(twitch_data.id) == twitch_data
    end

    test "create_twitch_data/1 with valid data creates a twitch_data" do
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

      assert {:ok, %TwitchData{} = twitch_data} = TwitchDatas.create_twitch_data(valid_attrs)
      assert twitch_data.avg_viewers == 42
      assert twitch_data.channel == "some channel"
      assert twitch_data.followers == 42
      assert twitch_data.followers_gained == 42
      assert twitch_data.language == "some language"
      assert twitch_data.mature == true
      assert twitch_data.partnered == true
      assert twitch_data.peak_viewers == 42
      assert twitch_data.stream_time == 42
      assert twitch_data.views_gained == 42
      assert twitch_data.watch_time == 42
    end

    test "create_twitch_data/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TwitchDatas.create_twitch_data(@invalid_attrs)
    end

    test "update_twitch_data/2 with valid data updates the twitch_data" do
      twitch_data = twitch_data_fixture()

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

      assert {:ok, %TwitchData{} = twitch_data} =
               TwitchDatas.update_twitch_data(twitch_data, update_attrs)

      assert twitch_data.avg_viewers == 43
      assert twitch_data.channel == "some updated channel"
      assert twitch_data.followers == 43
      assert twitch_data.followers_gained == 43
      assert twitch_data.language == "some updated language"
      assert twitch_data.mature == false
      assert twitch_data.partnered == false
      assert twitch_data.peak_viewers == 43
      assert twitch_data.stream_time == 43
      assert twitch_data.views_gained == 43
      assert twitch_data.watch_time == 43
    end

    test "update_twitch_data/2 with invalid data returns error changeset" do
      twitch_data = twitch_data_fixture()

      assert {:error, %Ecto.Changeset{}} =
               TwitchDatas.update_twitch_data(twitch_data, @invalid_attrs)

      assert twitch_data == TwitchDatas.get_twitch_data!(twitch_data.id)
    end

    test "delete_twitch_data/1 deletes the twitch_data" do
      twitch_data = twitch_data_fixture()
      assert {:ok, %TwitchData{}} = TwitchDatas.delete_twitch_data(twitch_data)
      assert_raise Ecto.NoResultsError, fn -> TwitchDatas.get_twitch_data!(twitch_data.id) end
    end

    test "change_twitch_data/1 returns a twitch_data changeset" do
      twitch_data = twitch_data_fixture()
      assert %Ecto.Changeset{} = TwitchDatas.change_twitch_data(twitch_data)
    end
  end
end
