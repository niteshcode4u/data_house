defmodule DataHouse.DielectronsTest do
  use DataHouse.DataCase

  alias DataHouse.Models.Dielectrons

  describe "dielectron" do
    alias DataHouse.Schemas.Dielectron

    import DataHouse.DielectronsFixtures

    @invalid_attrs %{
      e1: nil,
      e2: nil,
      eta1: nil,
      eta2: nil,
      event: nil,
      m: nil,
      phi1: nil,
      phi2: nil,
      pt1: nil,
      pt2: nil,
      px1: nil,
      px2: nil,
      py1: nil,
      py2: nil,
      pz1: nil,
      pz2: nil,
      q1: nil,
      q2: nil,
      run: nil
    }

    test "list_dielectron/0 returns all dielectron" do
      dielectron = dielectron_fixture()
      assert Dielectrons.list_dielectron() == [dielectron]
    end

    test "get_dielectron!/1 returns the dielectron with given id" do
      dielectron = dielectron_fixture()
      assert Dielectrons.get_dielectron!(dielectron.id) == dielectron
    end

    test "create_dielectron/1 with valid data creates a dielectron" do
      valid_attrs = %{
        e1: "120.5",
        e2: "120.5",
        eta1: "120.5",
        eta2: "120.5",
        event: 42,
        m: "120.5",
        phi1: "120.5",
        phi2: "120.5",
        pt1: "120.5",
        pt2: "120.5",
        px1: "120.5",
        px2: "120.5",
        py1: "120.5",
        py2: "120.5",
        pz1: "120.5",
        pz2: "120.5",
        q1: 42,
        q2: "120.5",
        run: 42
      }

      assert {:ok, %Dielectron{} = dielectron} = Dielectrons.create_dielectron(valid_attrs)
      assert dielectron.e1 == Decimal.new("120.5")
      assert dielectron.e2 == Decimal.new("120.5")
      assert dielectron.eta1 == Decimal.new("120.5")
      assert dielectron.eta2 == Decimal.new("120.5")
      assert dielectron.event == 42
      assert dielectron.m == Decimal.new("120.5")
      assert dielectron.phi1 == Decimal.new("120.5")
      assert dielectron.phi2 == Decimal.new("120.5")
      assert dielectron.pt1 == Decimal.new("120.5")
      assert dielectron.pt2 == Decimal.new("120.5")
      assert dielectron.px1 == Decimal.new("120.5")
      assert dielectron.px2 == Decimal.new("120.5")
      assert dielectron.py1 == Decimal.new("120.5")
      assert dielectron.py2 == Decimal.new("120.5")
      assert dielectron.pz1 == Decimal.new("120.5")
      assert dielectron.pz2 == Decimal.new("120.5")
      assert dielectron.q1 == 42
      assert dielectron.q2 == Decimal.new("120.5")
      assert dielectron.run == 42
    end

    test "create_dielectron/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dielectrons.create_dielectron(@invalid_attrs)
    end

    test "update_dielectron/2 with valid data updates the dielectron" do
      dielectron = dielectron_fixture()

      update_attrs = %{
        e1: "456.7",
        e2: "456.7",
        eta1: "456.7",
        eta2: "456.7",
        event: 43,
        m: "456.7",
        phi1: "456.7",
        phi2: "456.7",
        pt1: "456.7",
        pt2: "456.7",
        px1: "456.7",
        px2: "456.7",
        py1: "456.7",
        py2: "456.7",
        pz1: "456.7",
        pz2: "456.7",
        q1: 43,
        q2: "456.7",
        run: 43
      }

      assert {:ok, %Dielectron{} = dielectron} =
               Dielectrons.update_dielectron(dielectron, update_attrs)

      assert dielectron.e1 == Decimal.new("456.7")
      assert dielectron.e2 == Decimal.new("456.7")
      assert dielectron.eta1 == Decimal.new("456.7")
      assert dielectron.eta2 == Decimal.new("456.7")
      assert dielectron.event == 43
      assert dielectron.m == Decimal.new("456.7")
      assert dielectron.phi1 == Decimal.new("456.7")
      assert dielectron.phi2 == Decimal.new("456.7")
      assert dielectron.pt1 == Decimal.new("456.7")
      assert dielectron.pt2 == Decimal.new("456.7")
      assert dielectron.px1 == Decimal.new("456.7")
      assert dielectron.px2 == Decimal.new("456.7")
      assert dielectron.py1 == Decimal.new("456.7")
      assert dielectron.py2 == Decimal.new("456.7")
      assert dielectron.pz1 == Decimal.new("456.7")
      assert dielectron.pz2 == Decimal.new("456.7")
      assert dielectron.q1 == 43
      assert dielectron.q2 == Decimal.new("456.7")
      assert dielectron.run == 43
    end

    test "update_dielectron/2 with invalid data returns error changeset" do
      dielectron = dielectron_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Dielectrons.update_dielectron(dielectron, @invalid_attrs)

      assert dielectron == Dielectrons.get_dielectron!(dielectron.id)
    end

    test "delete_dielectron/1 deletes the dielectron" do
      dielectron = dielectron_fixture()
      assert {:ok, %Dielectron{}} = Dielectrons.delete_dielectron(dielectron)
      assert_raise Ecto.NoResultsError, fn -> Dielectrons.get_dielectron!(dielectron.id) end
    end

    test "change_dielectron/1 returns a dielectron changeset" do
      dielectron = dielectron_fixture()
      assert %Ecto.Changeset{} = Dielectrons.change_dielectron(dielectron)
    end
  end
end
