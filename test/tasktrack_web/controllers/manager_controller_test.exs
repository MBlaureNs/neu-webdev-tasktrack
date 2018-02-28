defmodule TaskTrackWeb.ManagerControllerTest do
  use TaskTrackWeb.ConnCase

  alias TaskTrack.Accounts
  alias TaskTrack.Accounts.Manager

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:manager) do
    {:ok, manager} = Accounts.create_manager(@create_attrs)
    manager
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all manages", %{conn: conn} do
      conn = get conn, manager_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create manager" do
    test "renders manager when data is valid", %{conn: conn} do
      conn = post conn, manager_path(conn, :create), manager: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, manager_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, manager_path(conn, :create), manager: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update manager" do
    setup [:create_manager]

    test "renders manager when data is valid", %{conn: conn, manager: %Manager{id: id} = manager} do
      conn = put conn, manager_path(conn, :update, manager), manager: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, manager_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn, manager: manager} do
      conn = put conn, manager_path(conn, :update, manager), manager: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete manager" do
    setup [:create_manager]

    test "deletes chosen manager", %{conn: conn, manager: manager} do
      conn = delete conn, manager_path(conn, :delete, manager)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, manager_path(conn, :show, manager)
      end
    end
  end

  defp create_manager(_) do
    manager = fixture(:manager)
    {:ok, manager: manager}
  end
end
