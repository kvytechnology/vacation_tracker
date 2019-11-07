defmodule VacationTrackerWeb.CommandControllerTest do
  use VacationTrackerWeb.ConnCase

  test "returns error if the text is invalid", %{conn: conn} do
    response = post(
      conn,
      Routes.command_path(conn, :time_off),
      %{"text" => "from invalid to 2020-02-03, reason: I want to"}
    )

    assert %{"error" => "invalid_request"} = json_response(response, 200)
  end

  test "returns ok if the text is valid", %{conn: conn} do
    response = post(
      conn,
      Routes.command_path(conn, :time_off),
      %{"text" => "from 2020-02-01 to 2020-02-03, reason: I want to"}
    )

    assert %{"ok" => "request_successfully"} = json_response(response, 200)
  end
end
