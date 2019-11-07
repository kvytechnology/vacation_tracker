defmodule VacationTrackerWeb.CommandController do
  use VacationTrackerWeb, :controller

  def time_off(conn, params) do
    {status, message} = VacationTracker.Parser.run(params["text"])

    json(conn, %{status => message})
  end
end
