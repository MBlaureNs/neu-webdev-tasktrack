defmodule TaskTrack.Accounts.Manager do
  use Ecto.Schema
  import Ecto.Changeset
  alias TaskTrack.Accounts.Manager
  alias TaskTrack.Accounts.Users


  schema "manages" do
    belongs_to :manager, Users
    belongs_to :managee, Users

    timestamps()
  end

  @doc false
  def changeset(%Manager{} = manager, attrs) do
    manager
    |> cast(attrs, [:manager_id, :managee_id])
    |> validate_required([:manager_id, :managee_id])
  end
end
