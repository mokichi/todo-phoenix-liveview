defmodule TodoPhoenixLiveview.Todo.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :title, :string
    field :completed, :boolean, default: false
    field :editting, :boolean, default: false, virtual: true

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :completed])
    |> validate_required([:title])
  end
end
