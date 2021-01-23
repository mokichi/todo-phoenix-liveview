defmodule TodoPhoenixLiveviewWeb.TodoLive.Index do
  use TodoPhoenixLiveviewWeb, :live_view

  alias TodoPhoenixLiveview.Todo
  alias TodoPhoenixLiveviewWeb.TodoLive.{CreateTaskFormComponent, ListComponent}

  @impl true
  def mount(_parmas, _session, socket) do
    IO.inspect _session
    {:ok, assign_params(socket)}
  end

  @impl true
  def handle_info(:reload_tasks, socket) do
    {:noreply, assign_params(socket)}
  end

  defp assign_params(socket) do
    socket
    |> assign(:tasks, Todo.list_tasks_by_completed(false))
    |> assign(:completed_tasks, Todo.list_tasks_by_completed(true))
  end
end
