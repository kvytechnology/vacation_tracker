defmodule VacationTrackerWeb.AuthControllerTest do
  use VacationTrackerWeb.ConnCase

  alias VacationTracker.{Accounts, Accounts.User}
  alias VacationTracker.Repo

  @valid_email "vu@kvytechnology.com"

  describe "callback/2" do
    test "google redirects after successfully first time sign in creates user", %{conn: conn} do
      response =
        conn
        |> assign(:ueberauth_auth, ueberauth_struct(@valid_email, "Vu Tran"))
        |> get(Routes.auth_path(conn, :callback, "google"))

      assert user = Accounts.find_user_by(:email, @valid_email)
      assert Plug.Conn.get_session(response, :current_user_id) == user.id
      assert get_flash(response, :info) == "Signed in with vu@kvytechnology.com"
    end

    test "google redirects after successfully doesn't create user if one already exists", %{conn: conn} do
      Accounts.create_user(%{email: @valid_email})

      response =
        conn
        |> assign(:ueberauth_auth, ueberauth_struct(@valid_email, "Vu Tran"))
        |> get(Routes.auth_path(conn, :callback, "google"))

      assert get_flash(response, :info) == "Signed in with vu@kvytechnology.com"
      assert 1 = length(Repo.all(User))
    end
  end

  defp ueberauth_struct(email, name) do
    %Ueberauth.Auth{
      info: %Ueberauth.Auth.Info{
        email: email,
        name: name
      }
    }
  end
end
