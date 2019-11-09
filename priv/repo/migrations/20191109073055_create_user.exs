defmodule VacationTracker.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :slack_id, :string
      add :name, :string
      add :slack_token, :string

      timestamps()
    end

    create index("users", [:email], unique: true)
  end
end
