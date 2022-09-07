defmodule DataHouse.Repo.Migrations.CreateMemes do
  use Ecto.Migration

  def change do
    create table(:memes) do
      add :meme_id, :string
      add :archived_url, :string
      add :base_meme_name, :string
      add :meme_page_url, :string
      add :md5_hash, :string
      add :file_size, :integer
      add :alt_text, :string

      timestamps()
    end
  end
end
