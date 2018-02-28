defmodule TaskTrackWeb.TimeblockController do
  use TaskTrackWeb, :controller

  alias TaskTrack.Projects
  alias TaskTrack.Projects.Timeblock

  action_fallback TaskTrackWeb.FallbackController

  def index(conn, _params) do
    timeblocks = Projects.list_timeblocks()
    render(conn, "index.json", timeblocks: timeblocks)
  end

  def create(conn, %{"timeblock" => timeblock_params}) do
    timeblock_params = timeblock_params
    |> Map.put("start", DateTime.utc_now())
    |> Map.put("end", nil)
    with {:ok, %Timeblock{} = timeblock} <- Projects.create_timeblock(timeblock_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", timeblock_path(conn, :show, timeblock))
      |> render("show.json", timeblock: timeblock)
    end
  end

  def show(conn, %{"id" => id}) do
    timeblock = Projects.get_timeblock!(id)
    render(conn, "show.json", timeblock: timeblock)
  end

  def update(conn, %{"id" => id, "timeblock" => timeblock_params}) do
    timeblock_params = if is_nil(timeblock_params["end"]) do 
      timeblock_params |> Map.put("end", DateTime.utc_now())
    else
      timeblock_params
    end
    
    timeblock = Projects.get_timeblock!(id)

    with {:ok, %Timeblock{} = timeblock} <- Projects.update_timeblock(timeblock, timeblock_params) do
      render(conn, "show.json", timeblock: timeblock)
    end
  end

  def delete(conn, %{"id" => id}) do
    timeblock = Projects.get_timeblock!(id)
    with {:ok, %Timeblock{}} <- Projects.delete_timeblock(timeblock) do
      send_resp(conn, :no_content, "")
    end
  end
end
