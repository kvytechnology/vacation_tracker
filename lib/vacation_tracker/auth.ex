defmodule VacationTracker.Auth do
  import Plug.Conn
  import Phoenix.Controller

  alias VacationTracker.Accounts

  def init(default), do: default

  def call(conn, _params) do
    case user_signed_in?(conn) do
      true -> conn

      false ->
        conn
        |> put_status(:unauthorized)
        |> text("You must be signed in to continue")
        |> halt()
    end
  end

  def current_user(conn) do
    case Plug.Conn.get_session(conn, :current_user_id) do
      nil -> false

      user_id -> Accounts.find_user_by(:id, user_id)
    end
  end

  defp user_signed_in?(conn) do
    !!current_user(conn)
  end
end
