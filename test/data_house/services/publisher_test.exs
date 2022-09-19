defmodule DataHouse.Services.PublisherTest do
  @moduledoc false
  use DataHouse.DataCase

  alias DataHouse.Models.Dielectrons
  alias DataHouse.Models.Memes
  alias DataHouse.Models.TwitchData
  alias DataHouse.Services.Publisher

  describe "Publisher - get_queue" do
    test "Return dielectrons queue" do
      assert Publisher.dielectrons_queue_name() == "dielectrons"
    end

    test "Return memes queue" do
      assert Publisher.memes_queue_name() == "memes"
    end

    test "Return twitchdata queue" do
      assert Publisher.twitchdata_queue_name() == "twitchdata"
    end
  end

  describe "Publisher.publish/2" do
    test "publish results - twitchdata" do
      # set_up
      twitchdata_record =
        "xQcOW,6196161750,215250,222720,27716,3246298,1734810,93036735,True,False,English"

      assert :ok == Publisher.publish("twitchdata", twitchdata_record)

      Process.sleep(2000)

      assert length(TwitchData.list_twitchdata()) == 1
      assert GenRMQ.Publisher.message_count(Publisher, "twitchdata") == 0
    end

    test "publish results - memes" do
      # set_up
      memes_record =
        "10509464,http://webarchive.loc.gov/all/19960101000000-20160901235959*/http://cdn.meme.am/instances/10509464.jpg,Spiderman Approves,http://memegenerator.net/instance/10509464,5be4b65cc32d3a57be5b6693bb519155,24093,seems legit"

      assert :ok == Publisher.publish("memes", memes_record)

      Process.sleep(2000)

      assert length(Memes.list_memes()) == 1
      assert GenRMQ.Publisher.message_count(Publisher, "memes") == 0
    end

    test "publish results - dielectrons" do
      # set_up
      dielectrons_record =
        "147115,366639895,58.7141,-7.31132,10.531,-57.2974,12.8202,-2.20267,2.17766,1,11.2836,-1.03234,-1.88066,-11.0778,2.14537,-2.34403,-2.07281,-1,8.94841"

      assert :ok == Publisher.publish("dielectrons", dielectrons_record)

      Process.sleep(2000)

      assert length(Dielectrons.list_dielectron()) == 1
      assert GenRMQ.Publisher.message_count(Publisher, "dielectrons") == 0
    end
  end
end
