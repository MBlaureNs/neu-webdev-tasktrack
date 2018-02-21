defmodule TaskTrack.Projects.Tasks do
  use Ecto.Schema
  import Ecto.Changeset
  alias TaskTrack.Projects.Tasks


  schema "tasks" do
    field :act_time, :integer
    field :completed, :boolean, default: false
    field :desc, :string
    field :est_time, :integer
    field :title, :string
    belongs_to :requester, TaskTrack.Accounts.Users
    belongs_to :assignee, TaskTrack.Accounts.Users

    timestamps()
  end

  @doc false
  def changeset(%Tasks{} = tasks, attrs) do
    tasks
    |> cast(attrs, [:title, :desc, :est_time, :act_time, :completed])
    |> validate_required([:title, :desc, :est_time, :act_time, :completed])
  end
end
