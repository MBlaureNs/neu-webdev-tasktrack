defmodule TaskTrackWeb.ManagerController do
  use TaskTrackWeb, :controller

  alias TaskTrack.Accounts
  alias TaskTrack.Accounts.Manager

  action_fallback TaskTrackWeb.FallbackController

  def index(conn, _params) do
    manages = Accounts.list_manages()
    render(conn, "index.json", manages: manages)
  end

  def create(conn, %{"manager" => manager_params}) do
    with {:ok, %Manager{} = manager} <- Accounts.create_manager(manager_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", manager_path(conn, :show, manager))
      |> render("show.json", manager: manager)
    end
  end

  def show(conn, %{"id" => id}) do
    manager = Accounts.get_manager!(id)
    render(conn, "show.json", manager: manager)
  end

  def update(conn, %{"id" => id, "manager" => manager_params}) do
    manager = Accounts.get_manager!(id)

    with {:ok, %Manager{} = manager} <- Accounts.update_manager(manager, manager_params) do
      render(conn, "show.json", manager: manager)
    end
  end

  def delete(conn, %{"id" => id}) do
    manager = Accounts.get_manager!(id)
    with {:ok, %Manager{}} <- Accounts.delete_manager(manager) do
      send_resp(conn, :no_content, "")
    end
  end
end
