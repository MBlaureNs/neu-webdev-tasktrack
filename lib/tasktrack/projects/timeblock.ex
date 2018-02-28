defmodule TaskTrack.Projects.Timeblock do
  use Ecto.Schema
  import Ecto.Changeset
  alias TaskTrack.Projects.Timeblock


  schema "timeblocks" do
    field :end, :utc_datetime
    field :start, :utc_datetime
    belongs_to :task, TaskTrack.Projects.Tasks

    timestamps()
  end

  @doc false
  def changeset(%Timeblock{} = timeblock, attrs) do
    timeblock
    |> cast(attrs, [:start, :end, :task_id])
    |> validate_required([:start, :task_id])
  end
end
