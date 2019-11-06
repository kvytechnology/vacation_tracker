defmodule VacationTrackerWeb.PageController do
  use VacationTrackerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
