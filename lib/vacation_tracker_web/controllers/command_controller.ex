defmodule VacationTrackerWeb.CommandController do
  use VacationTrackerWeb, :controller

  alias VacationTracker.CommandHandler

  def time_off(conn, params) do
    result = CommandHandler.run({:time_off, params})

    json(conn, result)
  end
end
