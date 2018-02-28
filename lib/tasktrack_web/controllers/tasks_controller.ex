defmodule TaskTrackWeb.TasksController do
  use TaskTrackWeb, :controller
  
  alias TaskTrack.Repo
  alias TaskTrack.Accounts
  alias TaskTrack.Accounts.Users
  alias TaskTrack.Projects
  alias TaskTrack.Projects.Tasks

  def index(conn, _params) do
    tasks = Projects.list_tasks()
    render(conn, "index.html", tasks: tasks)
  end

  def new(conn, _params) do
    changeset = Projects.change_tasks(%Tasks{})
    # https://stackoverflow.com/questions/33805309/how-to-show-all-records-of-a-model-in-phoenix-select-field
    userlist = Repo.all(Users) |> Enum.map(&{&1.name<>" ("<>&1.username<>")", &1.id})
    assignees = conn.assigns.current_user.id
    |> Accounts.managees_map_for
    |> Enum.map(fn({m, _}) -> {Accounts.get_users(m).name<>" ("<>Accounts.get_users(m).name<>")", m} end)
    
    render(conn, "new.html", changeset: changeset, userlist: userlist, tasks: nil, assignees: assignees)
  end

  def create(conn, %{"tasks" => tasks_params}) do
    case Projects.create_tasks(tasks_params) do
      {:ok, tasks} ->
        conn
        |> put_flash(:info, "Tasks created successfully.")
        |> redirect(to: tasks_path(conn, :show, tasks))
      {:error, %Ecto.Changeset{} = changeset} ->
	userlist = Repo.all(Users) |> Enum.map(&{&1.name<>" ("<>&1.username<>")", &1.id})
	assignees = conn.assigns.current_user.id
	|> Accounts.managees_map_for
	|> Enum.map(fn({m, _}) -> {Accounts.get_users(m).name<>" ("<>Accounts.get_users(m).name<>")", m} end)
    
        render(conn, "new.html", changeset: changeset, userlist: userlist, tasks: nil, assignees: assignees)
    end
  end

  def show(conn, %{"id" => id}) do
    tasks = Projects.get_tasks!(id)
    render(conn, "show.html", tasks: tasks)
  end

  def edit(conn, %{"id" => id}) do
    tasks = Projects.get_tasks!(id)
    changeset = Projects.change_tasks(tasks)
    userlist = Repo.all(Users) |> Enum.map(&{&1.name<>" ("<>&1.username<>")", &1.id})
    assignees = conn.assigns.current_user.id
    |> Accounts.managees_map_for
    |> Enum.map(fn({m, r}) -> {Accounts.get_users(m).name<>" ("<>Accounts.get_users(m).name<>")", m} end)
    
    render(conn, "edit.html", tasks: tasks, changeset: changeset, userlist: userlist, assignees: assignees)
  end

  def update(conn, %{"id" => id, "tasks" => tasks_params}) do
    tasks = Projects.get_tasks!(id)

    case Projects.update_tasks(tasks, tasks_params) do
      {:ok, tasks} ->
        conn
        |> put_flash(:info, "Tasks updated successfully.")
        |> redirect(to: tasks_path(conn, :show, tasks))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", tasks: tasks, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tasks = Projects.get_tasks!(id)
    {:ok, _tasks} = Projects.delete_tasks(tasks)

    conn
    |> put_flash(:info, "Tasks deleted successfully.")
    |> redirect(to: tasks_path(conn, :index))
  end
end
