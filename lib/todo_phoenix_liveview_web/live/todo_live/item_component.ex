defmodule TodoPhoenixLiveviewWeb.TodoLive.ItemComponent do
  use TodoPhoenixLiveviewWeb, :live_component

  alias TodoPhoenixLiveview.Todo
  alias TodoPhoenixLiveviewWeb.TodoLive.UpdateTaskFormComponent

  @impl true
  def mount(socket) do
    {:ok, assign(socket, editting: false)}
  end

  @impl true
  def update(assigns, socket) do
    {:ok, assign(socket, Map.put(assigns, :editting, false))}
  end

  @impl true
  def handle_event("toggle_editting", %{"editting" => "true"}, socket) do
    {:noreply, assign(socket, editting: true)}
  end

  @impl true
  def handle_event("toggle_editting", %{"editting" => "false"}, socket) do
    {:noreply, assign(socket, editting: false)}
  end
end
