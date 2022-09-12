defmodule DataHouse.Schemas.Dielectron do
  use Ecto.Schema
  import Ecto.Changeset

  schema "dielectrons" do
    field :e1, :decimal
    field :e2, :decimal
    field :eta1, :decimal
    field :eta2, :decimal
    field :event, :integer
    field :m, :decimal
    field :phi1, :decimal
    field :phi2, :decimal
    field :pt1, :decimal
    field :pt2, :decimal
    field :px1, :decimal
    field :px2, :decimal
    field :py1, :decimal
    field :py2, :decimal
    field :pz1, :decimal
    field :pz2, :decimal
    field :q1, :integer
    field :q2, :decimal
    field :run, :integer

    timestamps()
  end

  @doc false
  def changeset(dielectron, attrs) do
    dielectron
    |> cast(attrs, [
      :run,
      :event,
      :e1,
      :px1,
      :py1,
      :pz1,
      :pt1,
      :eta1,
      :phi1,
      :q1,
      :e2,
      :px2,
      :py2,
      :pz2,
      :pt2,
      :eta2,
      :phi2,
      :q2,
      :m
    ])
    |> validate_required([
      :run,
      :event,
      :e1,
      :px1,
      :py1,
      :pz1,
      :pt1,
      :eta1,
      :phi1,
      :q1,
      :e2,
      :px2,
      :py2,
      :pz2,
      :pt2,
      :eta2,
      :phi2,
      :q2,
      :m
    ])
  end
end
