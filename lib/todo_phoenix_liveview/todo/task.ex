defmodule TodoPhoenixLiveview.Todo.Task do
  use Ecto.Schema
  import Ecto.Changeset

  alias TodoPhoenixLiveview.Accounts.User

  schema "tasks" do
    field :title, :string
    field :completed, :boolean, default: false
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :completed, :user_id])
    |> validate_required([:title, :user_id])
    |> assoc_constraint(:user)
  end
end
