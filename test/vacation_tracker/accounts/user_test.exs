defmodule VacationTracker.Accounts.UserTest do
  use VacationTracker.DataCase

  alias VacationTracker.Accounts
  alias VacationTracker.Accounts.User
  alias VacationTracker.Repo

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

  test "create/2 with valid data creates a user" do
    assert {:ok, %User{} = user} = User.create(@valid_attrs)
  end

  test "create/2 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{} = errors} = User.create(@invalid_attrs)

    assert %{email: ["can't be blank"]} = errors_on(errors)
    assert %{name: ["can't be blank"]} = errors_on(errors)
    assert %{slack_id: ["can't be blank"]} = errors_on(errors)
    assert %{slack_token: ["can't be blank"]} = errors_on(errors)
  end

  test "update/2 with valid data update a user" do
    user = user_fixture()

    assert {:ok, %User{} = user} = User.update(user, %{name: "Vu Tran 2"})
    assert "Vu Tran 2" = User.find_by(:email, user.email).name
  end

  test "update/2 with invalid data returns error changeset" do
    user = user_fixture()

    assert {:error, errors} = User.update(user, %{name: ""})
    assert %{name: ["can't be blank"]} = errors_on(errors)
  end

  test "create_or_update/1 when user doesn't exist" do
    assert {:ok, %User{}} =  User.create_or_update(@valid_attrs)
    assert 1 = length(Repo.all(User))
  end

  test "create_or_update/1 when user already exists" do
    user_fixture()

    assert {:ok, %User{}} =  User.create_or_update(@valid_attrs)
    assert 1 = length(Repo.all(User))
  end
end
