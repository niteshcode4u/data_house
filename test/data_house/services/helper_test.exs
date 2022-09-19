defmodule DataHouse.Services.HelperTest do
  @moduledoc false
  use DataHouse.DataCase

  alias DataHouse.Services.Helper
  alias DataHouse.Services.Publisher
  alias DataHouse.Services.Subscribers.DielectronSubscriber
  alias DataHouse.Services.Subscribers.MemeSubscriber
  alias DataHouse.Services.Subscribers.TwitchdataSubscriber

  describe "Helper.get_subscriber_options/2" do
    test "successfully returns options for all queues" do
      dielectrons_opts =
        Helper.get_subscriber_options(DielectronSubscriber, Publisher.dielectrons_queue_name())

      memes_opts = Helper.get_subscriber_options(MemeSubscriber, Publisher.memes_queue_name())

      twitch_data_opts =
        Helper.get_subscriber_options(TwitchdataSubscriber, Publisher.twitchdata_queue_name())

      assert dielectrons_opts == [
               name: DataHouse.Services.Subscribers.DielectronSubscriber,
               producers: [
                 default: [
                   module:
                     {BroadwayRabbitMQ.Producer,
                      [
                        queue: "dielectrons",
                        connection: [username: "guest", password: "guest"]
                      ]},
                   stages: 1
                 ]
               ],
               processors: [default: [stages: 100]],
               batchers: [
                 data_house: [batch_size: 100, batch_timeout: 10, stages: 100],
                 default: []
               ]
             ]

      assert memes_opts == [
               name: DataHouse.Services.Subscribers.MemeSubscriber,
               producers: [
                 default: [
                   module:
                     {BroadwayRabbitMQ.Producer,
                      [queue: "memes", connection: [username: "guest", password: "guest"]]},
                   stages: 1
                 ]
               ],
               processors: [default: [stages: 100]],
               batchers: [
                 data_house: [batch_size: 100, batch_timeout: 10, stages: 100],
                 default: []
               ]
             ]

      assert twitch_data_opts == [
               name: DataHouse.Services.Subscribers.TwitchdataSubscriber,
               producers: [
                 default: [
                   module:
                     {BroadwayRabbitMQ.Producer,
                      [queue: "twitchdata", connection: [username: "guest", password: "guest"]]},
                   stages: 1
                 ]
               ],
               processors: [default: [stages: 100]],
               batchers: [
                 data_house: [batch_size: 100, batch_timeout: 10, stages: 100],
                 default: []
               ]
             ]
    end
  end

  describe "Helper.get_parsed_records/2" do
    test "successfully returns parsed response for provided queue/dielectrons" do
      # set_up
      dielectrons_record =
        "147115,367825395,27.8812,11.939,-18.3462,17.2696,21.8888,0.724032,-0.993887,1,12.9218,-5.0263,11.6026,2.66263,12.6445,0.20905,1.9796,-1,34.2685"

      assert [
               run: 147_115,
               event: 367_825_395,
               e1: _e1,
               px1: _px1,
               py1: _py1,
               pz1: _pz1,
               pt1: _pt1,
               eta1: _eta1,
               phi1: _phi1,
               q1: 1,
               e2: _e2,
               px2: _px2,
               py2: _py2,
               pz2: _pz2,
               pt2: _pt2,
               eta2: _eta2,
               phi2: _phi2,
               q2: _q2,
               m: _m,
               inserted_at: _inserted_at,
               updated_at: _updated_at
             ] = Helper.get_parsed_records(:dielectrons, dielectrons_record)
    end

    test "successfully returns parsed response for provided queue/memes" do
      # set_up
      memes_record =
        "12285257,http://webarchive.loc.gov/all/19960101000000-20160901235959*/http://cdn.meme.am/instances/12285257.jpg,Alright Then Business Kid,http://memegenerator.net/instance/12285257,e2eef6626b3fdb369df23a5fabd99df4,25513,Fret not I stayed at a Holiday Inn Express last night"

      assert [
               meme_id: "12285257",
               archived_url:
                 "http://webarchive.loc.gov/all/19960101000000-20160901235959*/http://cdn.meme.am/instances/12285257.jpg",
               base_meme_name: "Alright Then Business Kid",
               meme_page_url: "http://memegenerator.net/instance/12285257",
               md5_hash: "e2eef6626b3fdb369df23a5fabd99df4",
               file_size: 25_513,
               alt_text: "Fret not I stayed at a Holiday Inn Express last night",
               inserted_at: _inserted_at,
               updated_at: _updated_at
             ] = Helper.get_parsed_records(:memes, memes_record)
    end

    test "successfully returns parsed response for provided queue/twitchdata" do
      # set_up
      twitchdata_record =
        "xQcOW,6196161750,215250,222720,27716,3246298,1734810,93036735,True,False,English\n"

      assert [
               channel: "xQcOW",
               watch_time: 6_196_161_750,
               stream_time: 215_250,
               peak_viewers: 222_720,
               avg_viewers: 27_716,
               followers: 3_246_298,
               followers_gained: 1_734_810,
               views_gained: 93_036_735,
               partnered: true,
               mature: false,
               language: "English\n",
               inserted_at: _inserted_at,
               updated_at: _updated_at
             ] = Helper.get_parsed_records(:twitchdata, twitchdata_record)
    end
  end

  describe "Helper.get_filtered_n_formatted_to_insert/2" do
    test "successfully filter and provides data to insert into mysql and redis/dielectrons" do
      # setup
      messages = [
        %Broadway.Message{
          acknowledger:
            {BroadwayRabbitMQ.Producer,
             %AMQP.Channel{
               conn: %AMQP.Connection{pid: self()},
               custom_consumer: nil,
               pid: self()
             }, %{client: BroadwayRabbitMQ.AmqpClient, delivery_tag: 11, requeue: true}},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :default,
          data: [
            run: 147_115,
            event: 366_639_101,
            e1: 84.5058,
            px1: 8.82436,
            py1: 10.5789,
            pz1: 83.3753,
            pt1: 13.7761,
            eta1: 2.50032,
            phi1: 0.875576,
            q1: 1,
            e2: 12.6784,
            px2: -1.13446,
            py2: -3.20939,
            pz2: -12.2128,
            pt2: 3.404,
            eta2: -1.98956,
            phi2: -1.91057,
            q2: -1,
            m: 65.3239,
            inserted_at: ~N[2022-09-18 12:04:58],
            updated_at: ~N[2022-09-18 12:04:58]
          ]
        }
      ]

      assert {mysql_data, _redis_data} =
               Helper.get_filtered_n_formatted_to_insert(messages, :dielectrons)

      assert [
               [
                 run: 147_115,
                 event: 366_639_101,
                 e1: 84.5058,
                 px1: 8.82436,
                 py1: 10.5789,
                 pz1: 83.3753,
                 pt1: 13.7761,
                 eta1: 2.50032,
                 phi1: 0.875576,
                 q1: 1,
                 e2: 12.6784,
                 px2: -1.13446,
                 py2: -3.20939,
                 pz2: -12.2128,
                 pt2: 3.404,
                 eta2: -1.98956,
                 phi2: -1.91057,
                 q2: -1,
                 m: 65.3239,
                 inserted_at: _inserted_at,
                 updated_at: _updated_at
               ]
             ] = mysql_data
    end

    test "successfully filter and provides data to insert into mysql and redis/memes" do
      # set_up
      messages = [
        %Broadway.Message{
          acknowledger:
            {BroadwayRabbitMQ.Producer,
             %AMQP.Channel{
               conn: %AMQP.Connection{pid: self()},
               custom_consumer: nil,
               pid: self()
             }, %{client: BroadwayRabbitMQ.AmqpClient, delivery_tag: 11, requeue: true}},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :default,
          data: [
            meme_id: "10509464",
            archived_url:
              "http://webarchive.loc.gov/all/19960101000000-20160901235959*/http://cdn.meme.am/instances/10509464.jpg",
            base_meme_name: "Spiderman Approves",
            meme_page_url: "http://memegenerator.net/instance/10509464",
            md5_hash: "5be4b65cc32d3a57be5b6693bb519155",
            file_size: 24_093,
            alt_text: "seems legit\n",
            inserted_at: ~N[2022-09-18 12:17:36],
            updated_at: ~N[2022-09-18 12:17:36]
          ],
          metadata: %{},
          status: :ok
        }
      ]

      assert {mysql_data, _redis_data} =
               Helper.get_filtered_n_formatted_to_insert(messages, :twitchdata)

      assert [
               [
                 meme_id: "10509464",
                 archived_url:
                   "http://webarchive.loc.gov/all/19960101000000-20160901235959*/http://cdn.meme.am/instances/10509464.jpg",
                 base_meme_name: "Spiderman Approves",
                 meme_page_url: "http://memegenerator.net/instance/10509464",
                 md5_hash: "5be4b65cc32d3a57be5b6693bb519155",
                 file_size: 24_093,
                 alt_text: "seems legit\n",
                 inserted_at: _inserted_at,
                 updated_at: _updated_at
               ]
             ] = mysql_data
    end

    test "successfully filter and provides data to insert into mysql and redis/twitchdata" do
      # set_up
      messages = [
        %Broadway.Message{
          acknowledger:
            {BroadwayRabbitMQ.Producer,
             %AMQP.Channel{
               conn: %AMQP.Connection{pid: self()},
               custom_consumer: nil,
               pid: self()
             }, %{client: BroadwayRabbitMQ.AmqpClient, delivery_tag: 11, requeue: true}},
          batch_key: :default,
          batch_mode: :bulk,
          batcher: :default,
          data: [
            channel: "xQcOW",
            watch_time: 6_196_161_750,
            stream_time: 215_250,
            peak_viewers: 222_720,
            avg_viewers: 27_716,
            followers: 3_246_298,
            followers_gained: 1_734_810,
            views_gained: 93_036_735,
            partnered: true,
            mature: false,
            language: "English\n",
            inserted_at: ~N[2022-09-18 10:29:38],
            updated_at: ~N[2022-09-18 10:29:38]
          ],
          metadata: %{},
          status: :ok
        }
      ]

      assert {mysql_data, _redis_data} =
               Helper.get_filtered_n_formatted_to_insert(messages, :twitchdata)

      assert [
               [
                 channel: "xQcOW",
                 watch_time: 6_196_161_750,
                 stream_time: 215_250,
                 peak_viewers: 222_720,
                 avg_viewers: 27_716,
                 followers: 3_246_298,
                 followers_gained: 1_734_810,
                 views_gained: 93_036_735,
                 partnered: true,
                 mature: false,
                 language: "English\n",
                 inserted_at: _inserted_at,
                 updated_at: _updated_at
               ]
             ] = mysql_data
    end
  end
end
