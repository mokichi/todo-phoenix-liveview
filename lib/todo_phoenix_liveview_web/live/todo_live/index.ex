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
  def handle_event("editting", %{"id" => id, "editting" => editting}, socket) do
    tasks =
      Todo.list_tasks_by_completed(false)
      |> Enum.map(fn task ->
        if to_string(task.id) == id do
          %{task | editting: editting == "true"}
        else
          task
        end
      end)
    
    completed_tasks =
      Todo.list_tasks_by_completed(true)
      |> Enum.map(fn task ->
        if to_string(task.id) == id do
          %{task | editting: editting == "true"}
        else
          task
        end
      end)
    
    socket =
      socket
      |> assign(:changeset, Todo.change_task(%Task{}))
      |> assign(:tasks, tasks)
      |> assign(:completed_tasks, completed_tasks)
    {:noreply, socket}
  end

  @impl true
  def handle_event("update_task", %{"id" => id, "task" => %{"title" => _} = task_params}, socket) do
    task = Todo.get_task!(id)
    {:ok, _} = Todo.update_task(task, task_params)

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
