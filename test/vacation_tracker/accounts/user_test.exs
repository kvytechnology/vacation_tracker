defmodule VacationTracker.Accounts.UserTest do
  use VacationTracker.DataCase

  alias VacationTracker.Accounts
  alias VacationTracker.Accounts.User

  @valid_attrs %{
    email: "vu@kvytechnology.com",
    name: "Vu Tran",
    slack_id: "UHGQYD466",
    slack_token: "48hP8h941S2"
  }

  @invalid_attrs %{
  }

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(@valid_attrs)
      |> Accounts.create_user()

    user
  end

  test "find_by/2 returns user" do
    user = user_fixture()

    assert User.find_by(:slack_id, @valid_attrs[:slack_id]) == user
  end

  test "create/1 with valid data creates a user" do
    assert {:ok, %User{} = user} = User.create(@valid_attrs)
  end

  test "create/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{} = errors} = User.create(@invalid_attrs)

    assert %{email: ["can't be blank"]} = errors_on(errors)
    assert %{name: ["can't be blank"]} = errors_on(errors)
    assert %{slack_id: ["can't be blank"]} = errors_on(errors)
    assert %{slack_token: ["can't be blank"]} = errors_on(errors)
  end
end
