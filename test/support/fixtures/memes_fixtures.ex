defmodule DataHouse.Memes.Fixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DataHouse.Memes` context.
  """

  alias DataHouse.Models.Memes

  @doc """
  Generate a meme.
  """
  def meme_fixture(attrs \\ %{}) do
    {:ok, meme} =
      attrs
      |> Enum.into(%{
        alt_text: "some alt_text",
        archived_url: "some archived_url",
        base_meme_name: "some base_meme_name",
        file_size: 42,
        md5_hash: "some md5_hash",
        meme_id: "some meme_id",
        meme_page_url: "some meme_page_url"
      })
      |> Memes.create_meme()

    meme
  end
end
