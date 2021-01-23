defmodule TodoPhoenixLiveviewWeb.TodoLive.CreateTaskFormComponent do
  use TodoPhoenixLiveviewWeb, :live_component

  alias TodoPhoenixLiveview.Todo
  alias TodoPhoenixLiveview.Todo.Task

  @impl true
  def mount(socket) do
    changeset = Todo.change_task(%Task{})
    {:ok, assign(socket, :changeset, changeset)}
  end

  @impl true
  def handle_event("validate_task", %{"task" => %{"title" => _} = task_params}, socket) do
    changeset = Todo.change_task(%Task{}, put_user_id(task_params, socket))
                |> Map.put(:action, :insert)
    {:noreply, assign(socket, :changeset, changeset)}
  end

  @impl true
  def handle_event("create_task", %{"task" => task_params}, socket) do
    case Todo.create_task(put_user_id(task_params, socket)) do
      {:ok, _} ->
        send self(), :reload_tasks
        changeset = Todo.change_task(%Task{})
        {:noreply, assign(socket, :changeset, changeset)}
      {:error, changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp put_user_id(%{} = params, socket) do
    Map.put(params, "user_id", socket.assigns.current_user.id)
  end
end
