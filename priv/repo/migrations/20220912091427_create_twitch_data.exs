defmodule DataHouse.Repo.Migrations.CreateTwitchdata do
  use Ecto.Migration

  def change do
    create table(:twitch_data) do
      add :channel, :string
      add :watch_time, :bigint
      add :stream_time, :bigint
      add :peak_viewers, :bigint
      add :avg_viewers, :bigint
      add :followers, :bigint
      add :followers_gained, :bigint
      add :views_gained, :bigint
      add :partnered, :boolean, default: false, null: false
      add :mature, :boolean, default: false, null: false
      add :language, :string

      timestamps()
    end

    create(index(:twitch_data, [:channel], unique: true))
  end
end
