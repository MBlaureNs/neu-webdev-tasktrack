defmodule TaskTrackWeb.UsersController do
  use TaskTrackWeb, :controller

  alias TaskTrack.Repo
  alias TaskTrack.Accounts
  alias TaskTrack.Accounts.Users
  alias TaskTrack.Projects
  alias TaskTrack.Projects.Tasks

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Accounts.change_users(%Users{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"users" => users_params}) do
    case Accounts.create_users(users_params) do
      {:ok, users} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: page_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_users!(id)
    managers = Accounts.managers_map_for(user.id)
    managernames = managers
    |> Enum.map(fn({m, _}) -> {Accounts.get_users(m).name<>" ("<>Accounts.get_users(m).username<>")", m} end)
    managees = Accounts.managees_map_for(user.id)
    manageenames = managees
    |> Enum.map(fn({m, _}) -> {Accounts.get_users(m).name<>" ("<>Accounts.get_users(m).username<>")", m} end)
    manageeids = managees
    |> Enum.map(fn({m, _}) -> m end)
    tasks = Projects.list_tasks() 
    |> Enum.filter(fn(t) -> Enum.member?(manageeids, t.assignee_id) end)
    render(conn, "show.html", user: user, managers: managers, managees: managees, managernames: managernames, manageenames: manageenames, tasks: tasks)
  end

  def edit(conn, %{"id" => id}) do
    users = Accounts.get_users!(id)
    changeset = Accounts.change_users(users)
    render(conn, "edit.html", users: users, changeset: changeset)
  end

  def update(conn, %{"id" => id, "users" => users_params}) do
    users = Accounts.get_users!(id)

    case Accounts.update_users(users, users_params) do
      {:ok, users} ->
        conn
        |> put_flash(:info, "Users updated successfully.")
        |> redirect(to: users_path(conn, :show, users))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", users: users, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    users = Accounts.get_users!(id)
    {:ok, _users} = Accounts.delete_users(users)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: users_path(conn, :index))
  end
end
