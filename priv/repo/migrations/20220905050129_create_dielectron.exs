defmodule DataHouse.Repo.Migrations.CreateDielectron do
  use Ecto.Migration

  def change do
    create table(:dielectron) do
      add :run, :integer
      add :event, :integer
      add :e1, :decimal
      add :px1, :decimal
      add :py1, :decimal
      add :pz1, :decimal
      add :pt1, :decimal
      add :eta1, :decimal
      add :phi1, :decimal
      add :q1, :integer
      add :e2, :decimal
      add :px2, :decimal
      add :py2, :decimal
      add :pz2, :decimal
      add :pt2, :decimal
      add :eta2, :decimal
      add :phi2, :decimal
      add :q2, :decimal
      add :m, :decimal

      timestamps()
    end
  end
end
