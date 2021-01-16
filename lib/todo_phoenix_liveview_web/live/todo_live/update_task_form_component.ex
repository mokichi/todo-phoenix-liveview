defmodule TodoPhoenixLiveviewWeb.TodoLive.UpdateTaskFormComponent do
  use TodoPhoenixLiveviewWeb, :live_component

  alias TodoPhoenixLiveview.Todo

  @impl true
  def update(assigns, socket) do
    changeset = Todo.change_task(assigns.task)
    {:ok, assign(socket, Map.put(assigns, :changeset, changeset))}
  end

  @impl true
  def handle_event("validate_task", %{"task" => %{"title" => _} = task_params}, socket) do
    changeset = Todo.change_task(socket.assigns.task, task_params)
                |> Map.put(:action, :update)
    {:noreply, assign(socket, :changeset, changeset)}
  end

  @impl true
  def handle_event("update_task", %{"task" => task_params}, %{assigns: %{task: task}} = socket) do
    case Todo.update_task(task, task_params) do
      {:ok, _} ->
        send self(), :reload_tasks
        {:noreply, socket}
      {:error, changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end
end
