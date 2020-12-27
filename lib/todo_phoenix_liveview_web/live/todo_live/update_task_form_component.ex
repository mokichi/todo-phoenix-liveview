defmodule TodoPhoenixLiveviewWeb.TodoLive.UpdateTaskFormComponent do
  use TodoPhoenixLiveviewWeb, :live_component

  alias TodoPhoenixLiveview.Todo

  @impl true
  def update(assigns, socket) do
    changeset = Todo.change_task(assigns.task)
    {:ok, assign(socket, Map.put(assigns, :changeset, changeset))}
  end
end
