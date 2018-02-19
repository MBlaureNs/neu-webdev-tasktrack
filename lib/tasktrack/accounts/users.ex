defmodule TaskTrack.Accounts.Users do
  use Ecto.Schema
  import Ecto.Changeset
  alias TaskTrack.Accounts.Users


  schema "users" do
    field :name, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(%Users{} = users, attrs) do
    users
    |> cast(attrs, [:username, :name])
    |> validate_required([:username, :name])
  end
end
