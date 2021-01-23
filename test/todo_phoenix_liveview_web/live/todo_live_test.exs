defmodule TodoPhoenixLiveview.TodoLiveTest do
  use TodoPhoenixLiveviewWeb.ConnCase

  import Phoenix.LiveViewTest

  alias TodoPhoenixLiveview.Todo

  defp create_task(%{user: user}) do
    {:ok, task} = Todo.create_task(%{title: "Task 1", completed: false, user_id: user.id})
    %{task: task}
  end

  defp create_completed_task(%{user: user}) do
    {:ok, task} = Todo.create_task(%{title: "Task 2", completed: true, user_id: user.id})
    %{completed_task: task}
  end

  describe "Index" do
    setup [:register_and_log_in_user, :create_task, :create_completed_task]

    test "lists all tasks", %{conn: conn, task: task, completed_task: completed_task} do
      {:ok, view, _html} = live(conn, Routes.todo_index_path(conn, :index))

      assert view |> has_element?("ul:nth-of-type(1) li", task.title)
      assert view |> has_element?("ul:nth-of-type(2) li", completed_task.title)
    end

    test "creates new task", %{conn: conn} do
      {:ok, view, _html} = live(conn, Routes.todo_index_path(conn, :index))

      new_task_title = "New task"
      view
      |> form("form", %{task: %{title: new_task_title}})
      |> render_submit()

      assert view |> has_element?("ul:nth-of-type(1) li", new_task_title)
    end

    test "completes incompleted task", %{conn: conn, task: task} do
      {:ok, view, _html} = live(conn, Routes.todo_index_path(conn, :index))

      view
      |> element("ul:nth-of-type(1) li input[type=checkbox]")
      |> render_click()

      refute view |> has_element?("ul:nth-of-type(1) li", task.title)
      assert view |> has_element?("ul:nth-of-type(2) li", task.title)
    end

    test "incompletes completed task", %{conn: conn, completed_task: task} do
      {:ok, view, _html} = live(conn, Routes.todo_index_path(conn, :index))

      view
      |> element("ul:nth-of-type(2) li input[type=checkbox]")
      |> render_click()

      assert view |> has_element?("ul:nth-of-type(1) li", task.title)
      refute view |> has_element?("ul:nth-of-type(2) li", task.title)
    end

    test "updates task", %{conn: conn} do
      {:ok, view, _html} = live(conn, Routes.todo_index_path(conn, :index))

      view
      |> element("ul:nth-of-type(1) li button", "Edit")
      |> render_click()

      new_task_title = "Updated task"
      view
      |> form("ul:nth-of-type(1) li form", %{task: %{title: new_task_title}})
      |> render_submit()

      assert view |> has_element?("ul:nth-of-type(1) li button", "Edit")
    end

    test "deletes task", %{conn: conn, task: task} do
      {:ok, view, _html} = live(conn, Routes.todo_index_path(conn, :index))

      view
      |> element("ul:nth-of-type(1) li button", "Delete")
      |> render_click()

      refute view |> has_element?("ul li", task.title)
    end
  end
end
