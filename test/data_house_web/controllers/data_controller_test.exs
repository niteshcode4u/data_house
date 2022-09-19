defmodule DataHouseWeb.DataControllerTest do
  use DataHouseWeb.ConnCase, async: false
  alias DataHouse.Factory

  describe "index" do
    test "Success: return list of results when correct params provided/dielectrons", %{conn: conn} do
      dielectron = Factory.insert(:dielectron)

      redis_data =
        dielectron |> Map.from_struct() |> Map.drop([:__meta__]) |> :erlang.term_to_binary()

      Redix.command(:redix, ["RPUSH", "dielectrons", redis_data])

      resp =
        conn
        |> get(Routes.data_path(conn, :index), query: "dielectrons")
        |> json_response(200)

      assert %{"dielectrons" => dielectrons} = resp
      assert is_list(dielectrons)
      assert length(dielectrons) == 1
    end

    test "Success: return list of results when correct params provided with page_offset/dielectrons",
         %{conn: conn} do
      dielectron = Factory.insert(:dielectron)

      redis_data =
        dielectron |> Map.from_struct() |> Map.drop([:__meta__]) |> :erlang.term_to_binary()

      Redix.command(:redix, ["RPUSH", "dielectrons", redis_data])

      resp =
        conn
        |> get(Routes.data_path(conn, :index), query: "dielectrons", pagination_offset: 0)
        |> json_response(200)

      assert %{"dielectrons" => dielectrons} = resp
      assert is_list(dielectrons)
      assert length(dielectrons) == 1
    end

    test "Success: return list of results when correct params provided/memes", %{conn: conn} do
      meme = Factory.insert(:meme)
      redis_data = meme |> Map.from_struct() |> Map.drop([:__meta__]) |> :erlang.term_to_binary()
      Redix.command(:redix, ["RPUSH", "memes", redis_data])

      resp =
        conn
        |> get(Routes.data_path(conn, :index), query: "memes")
        |> json_response(200)

      assert %{"memes" => memes} = resp
      assert is_list(memes)
      assert length(memes) == 1
    end

    test "Success: return list of results when correct params provided/twitchdata", %{conn: conn} do
      twitchdata = Factory.insert(:twitchdata)

      redis_data =
        twitchdata |> Map.from_struct() |> Map.drop([:__meta__]) |> :erlang.term_to_binary()

      Redix.command(:redix, ["RPUSH", "twitchdata", redis_data])

      resp =
        conn
        |> get(Routes.data_path(conn, :index), query: "twitchdata")
        |> json_response(200)

      assert %{"twitchdata" => twitchdata} = resp
      assert is_list(twitchdata)
      assert length(twitchdata) == 1
    end

    test "Error: in case malformed params provided", %{conn: conn} do
      Factory.insert(:twitchdata)

      resp =
        conn
        |> get(Routes.data_path(conn, :index), query: "dummy_data_sets")
        |> json_response(404)

      assert resp == %{"error" => "Invalid data set query. Please verify and send again!!"}
    end
  end
end
