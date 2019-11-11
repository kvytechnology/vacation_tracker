defmodule VacationTrackerWeb.DashboardController do
  use VacationTrackerWeb, :controller

  def index(conn, _params) do
    text(conn, "Welcome!")
  end
end
