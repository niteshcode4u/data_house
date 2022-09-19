defmodule DataHouse.Schemas.TwitchData do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "twitch_data" do
    field :avg_viewers, :integer
    field :channel, :string
    field :followers, :integer
    field :followers_gained, :integer
    field :language, :string
    field :mature, :boolean, default: false
    field :partnered, :boolean, default: false
    field :peak_viewers, :integer
    field :stream_time, :integer
    field :views_gained, :integer
    field :watch_time, :integer

    timestamps()
  end

  @doc false
  def changeset(twitch_data, attrs) do
    twitch_data
    |> cast(attrs, [
      :channel,
      :watch_time,
      :stream_time,
      :peak_viewers,
      :avg_viewers,
      :followers,
      :followers_gained,
      :views_gained,
      :partnered,
      :mature,
      :language
    ])
    |> validate_required([
      :channel,
      :watch_time,
      :stream_time,
      :peak_viewers,
      :avg_viewers,
      :followers,
      :followers_gained,
      :views_gained,
      :partnered,
      :mature,
      :language
    ])
  end
end
