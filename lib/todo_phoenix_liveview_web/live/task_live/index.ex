defmodule TodoPhoenixLiveviewWeb.TaskLive.Index do
  use TodoPhoenixLiveviewWeb, :live_view

  alias TodoPhoenixLiveview.Todo
  alias TodoPhoenixLiveview.Todo.Task

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :tasks, list_tasks())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Task")
    |> assign(:task, Todo.get_task!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Task")
    |> assign(:task, %Task{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Tasks")
    |> assign(:task, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    task = Todo.get_task!(id)
    {:ok, _} = Todo.delete_task(task)

    {:noreply, assign(socket, :tasks, list_tasks())}
  end

  defp list_tasks do
    Todo.list_tasks()
  end
end
