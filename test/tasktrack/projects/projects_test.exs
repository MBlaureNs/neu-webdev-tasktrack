defmodule TaskTrack.ProjectsTest do
  use TaskTrack.DataCase

  alias TaskTrack.Projects

  describe "tasks" do
    alias TaskTrack.Projects.Tasks

    @valid_attrs %{act_time: 42, completed: true, desc: "some desc", est_time: 42, title: "some title"}
    @update_attrs %{act_time: 43, completed: false, desc: "some updated desc", est_time: 43, title: "some updated title"}
    @invalid_attrs %{act_time: nil, completed: nil, desc: nil, est_time: nil, title: nil}

    def tasks_fixture(attrs \\ %{}) do
      {:ok, tasks} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Projects.create_tasks()

      tasks
    end

    test "list_tasks/0 returns all tasks" do
      tasks = tasks_fixture()
      assert Projects.list_tasks() == [tasks]
    end

    test "get_tasks!/1 returns the tasks with given id" do
      tasks = tasks_fixture()
      assert Projects.get_tasks!(tasks.id) == tasks
    end

    test "create_tasks/1 with valid data creates a tasks" do
      assert {:ok, %Tasks{} = tasks} = Projects.create_tasks(@valid_attrs)
      assert tasks.act_time == 42
      assert tasks.completed == true
      assert tasks.desc == "some desc"
      assert tasks.est_time == 42
      assert tasks.title == "some title"
    end

    test "create_tasks/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projects.create_tasks(@invalid_attrs)
    end

    test "update_tasks/2 with valid data updates the tasks" do
      tasks = tasks_fixture()
      assert {:ok, tasks} = Projects.update_tasks(tasks, @update_attrs)
      assert %Tasks{} = tasks
      assert tasks.act_time == 43
      assert tasks.completed == false
      assert tasks.desc == "some updated desc"
      assert tasks.est_time == 43
      assert tasks.title == "some updated title"
    end

    test "update_tasks/2 with invalid data returns error changeset" do
      tasks = tasks_fixture()
      assert {:error, %Ecto.Changeset{}} = Projects.update_tasks(tasks, @invalid_attrs)
      assert tasks == Projects.get_tasks!(tasks.id)
    end

    test "delete_tasks/1 deletes the tasks" do
      tasks = tasks_fixture()
      assert {:ok, %Tasks{}} = Projects.delete_tasks(tasks)
      assert_raise Ecto.NoResultsError, fn -> Projects.get_tasks!(tasks.id) end
    end

    test "change_tasks/1 returns a tasks changeset" do
      tasks = tasks_fixture()
      assert %Ecto.Changeset{} = Projects.change_tasks(tasks)
    end
  end

  describe "timeblocks" do
    alias TaskTrack.Projects.Timeblock

    @valid_attrs %{end: "2010-04-17 14:00:00.000000Z", start: "2010-04-17 14:00:00.000000Z"}
    @update_attrs %{end: "2011-05-18 15:01:01.000000Z", start: "2011-05-18 15:01:01.000000Z"}
    @invalid_attrs %{end: nil, start: nil}

    def timeblock_fixture(attrs \\ %{}) do
      {:ok, timeblock} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Projects.create_timeblock()

      timeblock
    end

    test "list_timeblocks/0 returns all timeblocks" do
      timeblock = timeblock_fixture()
      assert Projects.list_timeblocks() == [timeblock]
    end

    test "get_timeblock!/1 returns the timeblock with given id" do
      timeblock = timeblock_fixture()
      assert Projects.get_timeblock!(timeblock.id) == timeblock
    end

    test "create_timeblock/1 with valid data creates a timeblock" do
      assert {:ok, %Timeblock{} = timeblock} = Projects.create_timeblock(@valid_attrs)
      assert timeblock.end == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert timeblock.start == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
    end

    test "create_timeblock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projects.create_timeblock(@invalid_attrs)
    end

    test "update_timeblock/2 with valid data updates the timeblock" do
      timeblock = timeblock_fixture()
      assert {:ok, timeblock} = Projects.update_timeblock(timeblock, @update_attrs)
      assert %Timeblock{} = timeblock
      assert timeblock.end == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert timeblock.start == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
    end

    test "update_timeblock/2 with invalid data returns error changeset" do
      timeblock = timeblock_fixture()
      assert {:error, %Ecto.Changeset{}} = Projects.update_timeblock(timeblock, @invalid_attrs)
      assert timeblock == Projects.get_timeblock!(timeblock.id)
    end

    test "delete_timeblock/1 deletes the timeblock" do
      timeblock = timeblock_fixture()
      assert {:ok, %Timeblock{}} = Projects.delete_timeblock(timeblock)
      assert_raise Ecto.NoResultsError, fn -> Projects.get_timeblock!(timeblock.id) end
    end

    test "change_timeblock/1 returns a timeblock changeset" do
      timeblock = timeblock_fixture()
      assert %Ecto.Changeset{} = Projects.change_timeblock(timeblock)
    end
  end
end
