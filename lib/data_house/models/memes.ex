defmodule DataHouse.Models.Memes do
  @moduledoc """
  The Memes context.
  """

  import Ecto.Query, warn: false

  alias DataHouse.Repo
  alias DataHouse.Schemas.Meme

  @doc """
  Returns the list of memes.

  ## Examples

      iex> list_memes()
      [%Meme{}, ...]

  """
  def list_memes do
    Repo.all(Meme)
  end

  @doc """
  Returns the list of memes.

  ## Examples

      iex> list_memes_by_meme_id(memes)
      [%Meme{}, ...]

      iex> list_memes_by_meme_id(memes)
      []

  """
  def list_memes_by_meme_id(meme_ids) do
    query = from m in Meme, where: m.meme_id in ^meme_ids, select: m.meme_id

    Repo.all(query)
  end

  @doc """
  Gets a single meme.

  Raises `Ecto.NoResultsError` if the Meme does not exist.

  ## Examples

      iex> get_meme!(123)
      %Meme{}

      iex> get_meme!(456)
      ** (Ecto.NoResultsError)

  """
  def get_meme!(id), do: Repo.get!(Meme, id)

  @doc """
  Creates a meme.

  ## Examples

      iex> create_meme(%{field: value})
      {:ok, %Meme{}}

      iex> create_meme(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_meme(attrs \\ %{}) do
    %Meme{}
    |> Meme.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a multiple memes.

  ## Examples

      iex> insert_all([%{field: value}])
      {1, nil}

      iex> insert_all([%{field: bad_value}])
      {:error, %Ecto.Changeset{}}

  """
  def insert_all(attrs) do
    Repo.insert_all(Meme, attrs)
  end

  @doc """
  Updates a meme.

  ## Examples

      iex> update_meme(meme, %{field: new_value})
      {:ok, %Meme{}}

      iex> update_meme(meme, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_meme(%Meme{} = meme, attrs) do
    meme
    |> Meme.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a meme.

  ## Examples

      iex> delete_meme(meme)
      {:ok, %Meme{}}

      iex> delete_meme(meme)
      {:error, %Ecto.Changeset{}}

  """
  def delete_meme(%Meme{} = meme) do
    Repo.delete(meme)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking meme changes.

  ## Examples

      iex> change_meme(meme)
      %Ecto.Changeset{data: %Meme{}}

  """
  def change_meme(%Meme{} = meme, attrs \\ %{}) do
    Meme.changeset(meme, attrs)
  end
end
