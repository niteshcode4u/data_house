defmodule DataHouse.Models.MemesTest do
  use DataHouse.DataCase

  alias DataHouse.Models.Memes

  describe "memes" do
    alias DataHouse.Schemas.Meme

    import DataHouse.Memes.Fixtures

    @invalid_attrs %{
      alt_text: nil,
      archived_url: nil,
      base_meme_name: nil,
      file_size: nil,
      md5_hash: nil,
      meme_id: nil,
      meme_page_url: nil
    }

    test "list_memes/0 returns all memes" do
      meme = meme_fixture()
      assert Memes.list_memes() == [meme]
    end

    test "get_meme!/1 returns the meme with given id" do
      meme = meme_fixture()
      assert Memes.get_meme!(meme.id) == meme
    end

    test "create_meme/1 with valid data creates a meme" do
      valid_attrs = %{
        alt_text: "some alt_text",
        archived_url: "some archived_url",
        base_meme_name: "some base_meme_name",
        file_size: 42,
        md5_hash: "some md5_hash",
        meme_id: "some meme_id",
        meme_page_url: "some meme_page_url"
      }

      assert {:ok, %Meme{} = meme} = Memes.create_meme(valid_attrs)
      assert meme.alt_text == "some alt_text"
      assert meme.archived_url == "some archived_url"
      assert meme.base_meme_name == "some base_meme_name"
      assert meme.file_size == 42
      assert meme.md5_hash == "some md5_hash"
      assert meme.meme_id == "some meme_id"
      assert meme.meme_page_url == "some meme_page_url"
    end

    test "create_meme/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Memes.create_meme(@invalid_attrs)
    end

    test "update_meme/2 with valid data updates the meme" do
      meme = meme_fixture()

      update_attrs = %{
        alt_text: "some updated alt_text",
        archived_url: "some updated archived_url",
        base_meme_name: "some updated base_meme_name",
        file_size: 43,
        md5_hash: "some updated md5_hash",
        meme_id: "some updated meme_id",
        meme_page_url: "some updated meme_page_url"
      }

      assert {:ok, %Meme{} = meme} = Memes.update_meme(meme, update_attrs)
      assert meme.alt_text == "some updated alt_text"
      assert meme.archived_url == "some updated archived_url"
      assert meme.base_meme_name == "some updated base_meme_name"
      assert meme.file_size == 43
      assert meme.md5_hash == "some updated md5_hash"
      assert meme.meme_id == "some updated meme_id"
      assert meme.meme_page_url == "some updated meme_page_url"
    end

    test "update_meme/2 with invalid data returns error changeset" do
      meme = meme_fixture()
      assert {:error, %Ecto.Changeset{}} = Memes.update_meme(meme, @invalid_attrs)
      assert meme == Memes.get_meme!(meme.id)
    end

    test "delete_meme/1 deletes the meme" do
      meme = meme_fixture()
      assert {:ok, %Meme{}} = Memes.delete_meme(meme)
      assert_raise Ecto.NoResultsError, fn -> Memes.get_meme!(meme.id) end
    end

    test "change_meme/1 returns a meme changeset" do
      meme = meme_fixture()
      assert %Ecto.Changeset{} = Memes.change_meme(meme)
    end
  end
end
