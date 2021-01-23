defmodule TodoPhoenixLiveviewWeb.TodoLive.Index do
  use TodoPhoenixLiveviewWeb, :live_view

  alias TodoPhoenixLiveview.Todo
  alias TodoPhoenixLiveviewWeb.TodoLive.{CreateTaskFormComponent, ListComponent}

  @impl true
  def mount(_parmas, session, socket) do
    socket = assign(socket, :current_user, current_user(session))
    {:ok, assign_params(socket)}
  end

  @impl true
  def handle_info(:reload_tasks, socket) do
    {:noreply, assign_params(socket)}
  end

  defp assign_params(%{assigns: %{current_user: current_user}} = socket) do
    socket
    |> assign(:tasks, Todo.list_tasks_by_completed(current_user, false))
    |> assign(:completed_tasks, Todo.list_tasks_by_completed(current_user, true))
  end
end
