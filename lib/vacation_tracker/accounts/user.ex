defmodule VacationTracker.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias VacationTracker.Repo

  schema "users" do
    field :email, :string
    field :slack_id, :string
    field :name, :string
    field :slack_token, :string

    timestamps()
  end

  def find_by(column, value) when is_atom(column) do
    Repo.get_by(__MODULE__, [{column, value}])
  end

  def create(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
    |> Repo.insert()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :slack_id, :name, :slack_token])
    |> validate_required([:email, :slack_id, :name, :slack_token])
  end
end
