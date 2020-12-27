defmodule TodoPhoenixLiveviewWeb.TodoLive.CreateTaskFormComponent do
  use TodoPhoenixLiveviewWeb, :live_component

  alias TodoPhoenixLiveview.Todo
  alias TodoPhoenixLiveview.Todo.Task

  @impl true
  def mount(socket) do
    changeset = Todo.change_task(%Task{})
    {:ok, assign(socket, changeset: changeset)}
  end
end
