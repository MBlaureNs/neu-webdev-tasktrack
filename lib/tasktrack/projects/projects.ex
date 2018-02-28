defmodule TaskTrack.Projects do
  @moduledoc """
  The Projects context.
  """

  import Ecto.Query, warn: false
  alias TaskTrack.Repo
  alias TaskTrack.Accounts

  alias TaskTrack.Projects.Tasks

  @doc """
  Returns the list of tasks.

  ## Examples

      iex> list_tasks()
      [%Tasks{}, ...]

  """
  def list_tasks do
    Repo.all(Tasks)
    |> Repo.preload(:requester)
    |> Repo.preload(:assignee)
  end

  @doc """
  Gets a single tasks.

  Raises `Ecto.NoResultsError` if the Tasks does not exist.

  ## Examples

      iex> get_tasks!(123)
      %Tasks{}

      iex> get_tasks!(456)
      ** (Ecto.NoResultsError)

  """
  def get_tasks!(id) do
    Repo.get!(Tasks, id)
    |> Repo.preload(:requester)
    |> Repo.preload(:assignee)
  end

  @doc """
  Creates a tasks.

  ## Examples

      iex> create_tasks(%{field: value})
      {:ok, %Tasks{}}

      iex> create_tasks(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tasks(attrs \\ %{}) do
    %Tasks{}
    |> Tasks.changeset(attrs)
    |> Ecto.Changeset.validate_change(:est_time, fn :est_time, est_time ->
      if rem(est_time, 15) != 0 do
	[est_time: "must be div by 15"]
      else
	[]
      end
    end)
    |> Repo.insert()
  end

  @doc """
  Updates a tasks.

  ## Examples

      iex> update_tasks(tasks, %{field: new_value})
      {:ok, %Tasks{}}

      iex> update_tasks(tasks, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tasks(%Tasks{} = tasks, attrs) do
    tasks
    |> Tasks.changeset(attrs)
    |> Ecto.Changeset.validate_change(:est_time, fn :est_time, est_time ->
      if rem(est_time, 15) != 0 do
	[est_time: "must be div by 15"]
      else
	[]
      end
    end)
    |> Repo.update()
  end

  @doc """
  Deletes a Tasks.

  ## Examples

      iex> delete_tasks(tasks)
      {:ok, %Tasks{}}

      iex> delete_tasks(tasks)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tasks(%Tasks{} = tasks) do
    Repo.delete(tasks)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tasks changes.

  ## Examples

      iex> change_tasks(tasks)
      %Ecto.Changeset{source: %Tasks{}}

  """
  def change_tasks(%Tasks{} = tasks) do
    Tasks.changeset(tasks, %{})
  end

  alias TaskTrack.Projects.Timeblock

  @doc """
  Returns the list of timeblocks.

  ## Examples

      iex> list_timeblocks()
      [%Timeblock{}, ...]

  """
  def list_timeblocks do
    Repo.all(Timeblock)
  end

  @doc """
  Gets a single timeblock.

  Raises `Ecto.NoResultsError` if the Timeblock does not exist.

  ## Examples

      iex> get_timeblock!(123)
      %Timeblock{}

      iex> get_timeblock!(456)
      ** (Ecto.NoResultsError)

  """
  def get_timeblock!(id), do: Repo.get!(Timeblock, id)

  @doc """
  Creates a timeblock.

  ## Examples

      iex> create_timeblock(%{field: value})
      {:ok, %Timeblock{}}

      iex> create_timeblock(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_timeblock(attrs \\ %{}) do
    %Timeblock{}
    |> Timeblock.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a timeblock.

  ## Examples

      iex> update_timeblock(timeblock, %{field: new_value})
      {:ok, %Timeblock{}}

      iex> update_timeblock(timeblock, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_timeblock(%Timeblock{} = timeblock, attrs) do
    timeblock
    |> Timeblock.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Timeblock.

  ## Examples

      iex> delete_timeblock(timeblock)
      {:ok, %Timeblock{}}

      iex> delete_timeblock(timeblock)
      {:error, %Ecto.Changeset{}}

  """
  def delete_timeblock(%Timeblock{} = timeblock) do
    Repo.delete(timeblock)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking timeblock changes.

  ## Examples

      iex> change_timeblock(timeblock)
      %Ecto.Changeset{source: %Timeblock{}}

  """
  def change_timeblock(%Timeblock{} = timeblock) do
    Timeblock.changeset(timeblock, %{})
  end

  def get_curtimeblock(id) do
    Repo.one(from t in Timeblock,
      where: t.task_id == ^id and is_nil(t.end))
  end
end
