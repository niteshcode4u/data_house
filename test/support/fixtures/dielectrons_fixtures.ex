defmodule DataHouse.DielectronsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DataHouse.Dielectrons` context.
  """

  @doc """
  Generate a dielectron.
  """
  def dielectron_fixture(attrs \\ %{}) do
    {:ok, dielectron} =
      attrs
      |> Enum.into(%{
        e1: "121",
        e2: "121",
        eta1: "121",
        eta2: "121",
        event: 42,
        m: "121",
        phi1: "121",
        phi2: "121",
        pt1: "121",
        pt2: "121",
        px1: "121",
        px2: "121",
        py1: "121",
        py2: "121",
        pz1: "121",
        pz2: "121",
        q1: 42,
        q2: "121",
        run: 42
      })
      |> DataHouse.Models.Dielectrons.create_dielectron()

    dielectron
  end
end
