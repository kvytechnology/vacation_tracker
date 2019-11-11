defmodule VactionTracker.CommandHandlerTest do
  use VacationTracker.DataCase

  alias VacationTracker.{Accounts, CommandHandler}

  @slack_valid_params %{
    "text" => "from 2019-02-02 to 2019-02-03, reason: I want to rest",
    "token" => "123456789",
    "user_id" => "valid_user_id",
    "user_name" => "Vu Tran"
  }

  @slack_invalid_params %{
    "text" => "from 2019-02-02 to 2019-14-03, reason: I want to rest",
    "token" => "123456789",
    "user_id" => "valid_user_id",
    "user_name" => "Vu Tran"
  }

  test "run/1 with valid slack params" do
    assert %{ok: :request_successfully} = CommandHandler.run({:time_off, @slack_valid_params})
    assert "vu@kvytechnology.com" = Accounts.find_user_by(:slack_id, "valid_user_id").email
  end

  test "run/1 with invalid slack params" do
    assert %{error: :invalid_request} = CommandHandler.run({:time_off, @slack_invalid_params})
    refute Accounts.find_user_by(:slack_id, "valid_user_id")
  end
end
