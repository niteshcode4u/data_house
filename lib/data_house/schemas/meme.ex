defmodule DataHouse.Schemas.Meme do
  use Ecto.Schema
  import Ecto.Changeset

  schema "memes" do
    field :alt_text, :string
    field :archived_url, :string
    field :base_meme_name, :string
    field :file_size, :integer
    field :md5_hash, :string
    field :meme_id, :string
    field :meme_page_url, :string

    timestamps()
  end

  @doc false
  def changeset(meme, attrs) do
    meme
    |> cast(attrs, [
      :meme_id,
      :archived_url,
      :base_meme_name,
      :meme_page_url,
      :md5_hash,
      :file_size,
      :alt_text
    ])
    |> validate_required([
      :meme_id,
      :archived_url,
      :base_meme_name,
      :meme_page_url,
      :md5_hash,
      :file_size,
      :alt_text
    ])
  end
end
