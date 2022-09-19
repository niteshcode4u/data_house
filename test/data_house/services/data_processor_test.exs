defmodule DataHouse.Services.DataProcessorTest do
  use DataHouse.DataCase

  alias DataHouse.Services.DataProcessor

  describe "DataProcessor.parse_csv/2" do
    test "parsed and push successfully when correct data given/twitchdata" do
      # Set up
      twitch_data_file_path = "test/support/data/twitchdata.csv"

      resp = DataProcessor.parse_csv(twitch_data_file_path, "twitchdata")
      assert is_list(resp)

      Process.sleep(2000)

      redis_data = DataHouse.get_data("twitchdata", "0")
      assert length(redis_data) == 9
    end

    test "parsed and push successfully when correct data given/dielectrons" do
      # Set up
      dielectron_file_path = "test/support/data/dielectrons.csv"

      resp = DataProcessor.parse_csv(dielectron_file_path, "dielectrons")
      assert is_list(resp)

      Process.sleep(2000)

      redis_data = DataHouse.get_data("dielectrons", "0")
      assert length(redis_data) == 8
    end

    test "parsed and push successfully when correct data given" do
      # Set up
      memes_file_path = "test/support/data/memes.csv"

      resp = DataProcessor.parse_csv(memes_file_path, "memes")
      assert is_list(resp)

      Process.sleep(2000)

      redis_data = DataHouse.get_data("memes", "0")
      assert length(redis_data) == 8
    end
  end
end
