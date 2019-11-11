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

  def create_or_update(attrs) do
    case find_by(:email, attrs[:email]) do
      nil -> create(attrs)

      user -> update(user, attrs)
    end
  end

  def create(attrs, options \\ [])

  def create(%{email: email}, source: :google) do
    Repo.insert(%__MODULE__{email: email})
  end

  def create(attrs, _options) do
    %__MODULE__{}
    |> changeset(attrs)
    |> Repo.insert()
  end

  def update(user, attrs) do
    user
    |> changeset(attrs)
    |> Repo.update()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :slack_id, :name, :slack_token])
    |> validate_required([:email, :slack_id, :name, :slack_token])
  end
end
