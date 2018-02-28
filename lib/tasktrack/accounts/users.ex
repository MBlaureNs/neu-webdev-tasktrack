defmodule TaskTrack.Accounts.Users do
  use Ecto.Schema
  import Ecto.Changeset
  alias TaskTrack.Accounts.Users
  alias TaskTrack.Accounts.Manager


  schema "users" do
    field :name, :string
    field :username, :string
    has_many :manager_manages, Manager, foreign_key: :manager_id
    has_many :managee_manages, Manager, foreign_key: :managee_id
    has_many :managers, through: [:manager_manages, :manager]
    has_many :managees, through: [:managee_manages, :managee]

    timestamps()
  end

  @doc false
  def changeset(%Users{} = users, attrs) do
    users
    |> cast(attrs, [:username, :name])
    |> validate_required([:username, :name])
  end
end
