defmodule VacationTrackerWeb.AuthController do
  use VacationTrackerWeb, :controller

  plug Ueberauth

  alias VacationTracker.{Accounts, Auth}

  def index(conn, _params) do
    redirect(conn, to: Routes.auth_path(conn, :request, "google"))
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    email = auth.info.email
    current_user =
      case Accounts.find_user_by(:email, email) do
        nil ->
          {:ok, user} = Accounts.create_user(%{email: email}, source: :google)
          user

        user -> user
      end

    conn
    |> assign(:current_user, current_user)
    |> put_session(:current_user_id, current_user.id)
    |> configure_session(renew: true)
    |> put_flash(:info, "Signed in with #{email}")
    |> redirect(to: Routes.dashboard_path(conn, :index))
  end
end
