defmodule TaskTrack.Projects.Tasks do
  use Ecto.Schema
  import Ecto.Changeset
  alias TaskTrack.Projects.Tasks
  alias TaskTrack.Projects.Timeblock

  schema "tasks" do
    field :completed, :boolean, default: false
    field :desc, :string
    field :est_time, :integer, default: 0
    field :title, :string
    belongs_to :requester, TaskTrack.Accounts.Users
    belongs_to :assignee, TaskTrack.Accounts.Users
    has_many :timeblock_ids, Timeblock, foreign_key: :task_id
    has_many :timeblocks, through: [:timeblock_ids, :task_id]


    timestamps()
  end

  @doc false
  def changeset(%Tasks{} = tasks, attrs) do
    tasks
    |> cast(attrs, [:title, :desc, :est_time, :completed, :requester_id, :assignee_id])
    |> validate_required([:title, :desc, :est_time, :completed, :requester_id, :assignee_id])
  end
end
