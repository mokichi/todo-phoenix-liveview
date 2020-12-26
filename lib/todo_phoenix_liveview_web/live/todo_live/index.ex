defmodule TodoPhoenixLiveviewWeb.TodoLive.Index do
  use TodoPhoenixLiveviewWeb, :live_view

  alias TodoPhoenixLiveview.Todo
  alias TodoPhoenixLiveview.Todo.Task

  @impl true
  def mount(_parmas, _session, socket) do
    socket =
      socket
      |> assign(:tasks, Todo.list_tasks_by_completed(false))
      |> assign(:completed_tasks, Todo.list_tasks_by_completed(true))
    {:ok, socket}
  end
end
