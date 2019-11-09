defmodule VacationTracker.Slack.MockServer do
  use Plug.Router

  plug Plug.Parsers, parsers: [:json, :urlencoded], pass: ["text/*"], json_decoder: Jason

  plug :match
  plug :dispatch

  get "/api/users.info" do
    with "valid_bot_token" <- conn.params["token"],
         "valid_user_id" <- conn.params["user"]
    do
      data = %{
        "user" => %{
          "real_name" => "Vu Tran",
          "id" => "valid_user_id",
          "profile" => %{
            "email" => "vu@kvytechnology.com"
          }
        }
      }

      {:ok, body} = Jason.encode(data)

      send_resp(conn, 200, body)
    end
  end
end
