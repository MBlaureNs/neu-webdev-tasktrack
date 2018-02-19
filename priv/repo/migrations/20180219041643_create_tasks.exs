defmodule TaskTrack.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string, null: false
      add :desc, :text
      add :est_time, :integer, default: 0
      add :act_time, :integer, default: 0
      add :completed, :boolean, default: false, null: false
      add :requester_id, references(:users, on_delete: :nothing)
      add :assignee_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:tasks, [:requester_id])
    create index(:tasks, [:assignee_id])
  end
end
