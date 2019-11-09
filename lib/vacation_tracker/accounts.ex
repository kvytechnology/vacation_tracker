defmodule VacationTracker.Accounts do
  @moduledoc """
  The Accounts context.
  """

  alias VacationTracker.Accounts.User

  defdelegate find_user_by(column, value), to: User, as: :find_by
  defdelegate create_user(attrs), to: User, as: :create
end
