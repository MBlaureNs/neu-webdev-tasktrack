defmodule TaskTrackWeb.ManagerView do
  use TaskTrackWeb, :view
  alias TaskTrackWeb.ManagerView

  def render("index.json", %{manages: manages}) do
    %{data: render_many(manages, ManagerView, "manager.json")}
  end

  def render("show.json", %{manager: manager}) do
    %{data: render_one(manager, ManagerView, "manager.json")}
  end

  def render("manager.json", %{manager: manager}) do
    %{id: manager.id}
  end
end
