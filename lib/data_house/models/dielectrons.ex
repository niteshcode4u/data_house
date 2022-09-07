defmodule DataHouse.Models.Dielectrons do
  @moduledoc """
  The Dielectrons context.
  """

  import Ecto.Query, warn: false

  alias DataHouse.Repo
  alias DataHouse.Schemas.Dielectron

  @doc """
  Returns the list of dielectron.

  ## Examples

      iex> list_dielectron()
      [%Dielectron{}, ...]

  """
  def list_dielectron do
    Repo.all(Dielectron)
  end

  @doc """
  Gets a single dielectron.

  Raises `Ecto.NoResultsError` if the Dielectron does not exist.

  ## Examples

      iex> get_dielectron!(123)
      %Dielectron{}

      iex> get_dielectron!(456)
      ** (Ecto.NoResultsError)

  """
  def get_dielectron!(id), do: Repo.get!(Dielectron, id)

  @doc """
  Creates a dielectron.

  ## Examples

      iex> create_dielectron(%{field: value})
      {:ok, %Dielectron{}}

      iex> create_dielectron(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_dielectron(attrs \\ %{}) do
    %Dielectron{}
    |> Dielectron.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a dielectron.

  ## Examples

      iex> update_dielectron(dielectron, %{field: new_value})
      {:ok, %Dielectron{}}

      iex> update_dielectron(dielectron, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_dielectron(%Dielectron{} = dielectron, attrs) do
    dielectron
    |> Dielectron.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a dielectron.

  ## Examples

      iex> delete_dielectron(dielectron)
      {:ok, %Dielectron{}}

      iex> delete_dielectron(dielectron)
      {:error, %Ecto.Changeset{}}

  """
  def delete_dielectron(%Dielectron{} = dielectron) do
    Repo.delete(dielectron)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking dielectron changes.

  ## Examples

      iex> change_dielectron(dielectron)
      %Ecto.Changeset{data: %Dielectron{}}

  """
  def change_dielectron(%Dielectron{} = dielectron, attrs \\ %{}) do
    Dielectron.changeset(dielectron, attrs)
  end
end
