defmodule TodoPhoenixLiveviewWeb.TodoLive.Index do
  use TodoPhoenixLiveviewWeb, :live_view

  alias TodoPhoenixLiveview.Todo
  alias TodoPhoenixLiveview.Todo.Task

  @impl true
  def mount(_parmas, _session, socket) do
    {:ok, assign_params(socket)}
  end

  @impl true
  def handle_event("create_task", %{"task" => %{"title" => _} = task_params}, socket) do
    {:ok, _} = Todo.create_task(task_params)
    {:noreply, assign_params(socket)}
  end

  @impl true
  def handle_event("toggle_completed", %{"id" => id, "completed" => completed}, socket) do
    task = Todo.get_task!(id)
    {:ok, _} = Todo.update_task(task, %{completed: completed})

    {:noreply, assign_params(socket)}
  end

  @impl true
  def handle_event("delete_task", %{"id" => id}, socket) do
    task = Todo.get_task!(id)
    {:ok, _} = Todo.delete_task(task)

    {:noreply, assign_params(socket)}
  end

  defp assign_params(socket) do
    socket
    |> assign(:changeset, Todo.change_task(%Task{}))
    |> assign(:tasks, Todo.list_tasks_by_completed(false))
    |> assign(:completed_tasks, Todo.list_tasks_by_completed(true))
  end
end
