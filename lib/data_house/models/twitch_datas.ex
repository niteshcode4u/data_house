defmodule DataHouse.TwitchDatas do
  @moduledoc """
  The TwitchDatas context.
  """

  import Ecto.Query, warn: false
  alias DataHouse.Repo

  alias DataHouse.TwitchDatas.TwitchData

  @doc """
  Returns the list of twitchdata.

  ## Examples

      iex> list_twitchdata()
      [%TwitchData{}, ...]

  """
  def list_twitchdata do
    Repo.all(TwitchData)
  end

  @doc """
  Gets a single twitch_data.

  Raises `Ecto.NoResultsError` if the Twitch data does not exist.

  ## Examples

      iex> get_twitch_data!(123)
      %TwitchData{}

      iex> get_twitch_data!(456)
      ** (Ecto.NoResultsError)

  """
  def get_twitch_data!(id), do: Repo.get!(TwitchData, id)

  @doc """
  Creates a twitch_data.

  ## Examples

      iex> create_twitch_data(%{field: value})
      {:ok, %TwitchData{}}

      iex> create_twitch_data(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_twitch_data(attrs \\ %{}) do
    %TwitchData{}
    |> TwitchData.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a twitch_data.

  ## Examples

      iex> update_twitch_data(twitch_data, %{field: new_value})
      {:ok, %TwitchData{}}

      iex> update_twitch_data(twitch_data, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_twitch_data(%TwitchData{} = twitch_data, attrs) do
    twitch_data
    |> TwitchData.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a twitch_data.

  ## Examples

      iex> delete_twitch_data(twitch_data)
      {:ok, %TwitchData{}}

      iex> delete_twitch_data(twitch_data)
      {:error, %Ecto.Changeset{}}

  """
  def delete_twitch_data(%TwitchData{} = twitch_data) do
    Repo.delete(twitch_data)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking twitch_data changes.

  ## Examples

      iex> change_twitch_data(twitch_data)
      %Ecto.Changeset{data: %TwitchData{}}

  """
  def change_twitch_data(%TwitchData{} = twitch_data, attrs \\ %{}) do
    TwitchData.changeset(twitch_data, attrs)
  end
end
