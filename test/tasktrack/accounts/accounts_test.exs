defmodule TaskTrack.AccountsTest do
  use TaskTrack.DataCase

  alias TaskTrack.Accounts

  describe "users" do
    alias TaskTrack.Accounts.Users

    @valid_attrs %{name: "some name", username: "some username"}
    @update_attrs %{name: "some updated name", username: "some updated username"}
    @invalid_attrs %{name: nil, username: nil}

    def users_fixture(attrs \\ %{}) do
      {:ok, users} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_users()

      users
    end

    test "list_users/0 returns all users" do
      users = users_fixture()
      assert Accounts.list_users() == [users]
    end

    test "get_users!/1 returns the users with given id" do
      users = users_fixture()
      assert Accounts.get_users!(users.id) == users
    end

    test "create_users/1 with valid data creates a users" do
      assert {:ok, %Users{} = users} = Accounts.create_users(@valid_attrs)
      assert users.name == "some name"
      assert users.username == "some username"
    end

    test "create_users/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_users(@invalid_attrs)
    end

    test "update_users/2 with valid data updates the users" do
      users = users_fixture()
      assert {:ok, users} = Accounts.update_users(users, @update_attrs)
      assert %Users{} = users
      assert users.name == "some updated name"
      assert users.username == "some updated username"
    end

    test "update_users/2 with invalid data returns error changeset" do
      users = users_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_users(users, @invalid_attrs)
      assert users == Accounts.get_users!(users.id)
    end

    test "delete_users/1 deletes the users" do
      users = users_fixture()
      assert {:ok, %Users{}} = Accounts.delete_users(users)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_users!(users.id) end
    end

    test "change_users/1 returns a users changeset" do
      users = users_fixture()
      assert %Ecto.Changeset{} = Accounts.change_users(users)
    end
  end

  describe "manages" do
    alias TaskTrack.Accounts.Manager

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def manager_fixture(attrs \\ %{}) do
      {:ok, manager} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_manager()

      manager
    end

    test "list_manages/0 returns all manages" do
      manager = manager_fixture()
      assert Accounts.list_manages() == [manager]
    end

    test "get_manager!/1 returns the manager with given id" do
      manager = manager_fixture()
      assert Accounts.get_manager!(manager.id) == manager
    end

    test "create_manager/1 with valid data creates a manager" do
      assert {:ok, %Manager{} = manager} = Accounts.create_manager(@valid_attrs)
    end

    test "create_manager/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_manager(@invalid_attrs)
    end

    test "update_manager/2 with valid data updates the manager" do
      manager = manager_fixture()
      assert {:ok, manager} = Accounts.update_manager(manager, @update_attrs)
      assert %Manager{} = manager
    end

    test "update_manager/2 with invalid data returns error changeset" do
      manager = manager_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_manager(manager, @invalid_attrs)
      assert manager == Accounts.get_manager!(manager.id)
    end

    test "delete_manager/1 deletes the manager" do
      manager = manager_fixture()
      assert {:ok, %Manager{}} = Accounts.delete_manager(manager)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_manager!(manager.id) end
    end

    test "change_manager/1 returns a manager changeset" do
      manager = manager_fixture()
      assert %Ecto.Changeset{} = Accounts.change_manager(manager)
    end
  end
end
