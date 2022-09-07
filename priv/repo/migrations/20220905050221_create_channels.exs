defmodule DataHouse.Repo.Migrations.CreateChannels do
  use Ecto.Migration

  def change do
    create table(:channels) do
      add :channel, :string
      add :watch_time, :integer
      add :stream_time, :integer
      add :peak_viewers, :integer
      add :avg_viewers, :integer
      add :followers, :integer
      add :followers_gained, :integer
      add :views_gained, :integer
      add :partnered, :boolean, default: false, null: false
      add :mature, :boolean, default: false, null: false
      add :language, :string

      timestamps()
    end
  end
end
