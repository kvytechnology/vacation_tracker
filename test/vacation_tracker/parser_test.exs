defmodule VacationTracker.ParserTest do
  use VacationTracker.DataCase

  alias VacationTracker.Parser

  describe "run/1" do
    test "help option" do
      response = Parser.run("help")

      assert "The message must exactly match: `from YYYY-MM-DD to YYYY-MM-DD, reason: text`" = response
    end

    test "returns ok if message is valid" do
      response = Parser.run("from 2020-02-03 to 2020-02-04, reason: I want to rest")
      assert {:ok, :request_successfully} = response
    end

    test "returns invalid request is the message is in invalid format" do
      assert_invalid_request("from 2020-02-03 to 2020-02-04,   reason I want to rest")
      assert_invalid_request("from 2020-02-03 to 2020-02-01, reason: I want to rest")
      assert_invalid_request("from 2020/02/03 to 2020-02-01, reason: I want to rest")
      assert_invalid_request("from invalid to 2020-02-01, reason: I want to rest")
      assert_invalid_request("from 2020/02/03 to     2020-02-04, reason: I want to rest")
      assert_invalid_request("from 2020-02-03 to 2020-02-03, reason: I want to rest")
    end
  end

  defp assert_invalid_request(text) do
    assert {:error, :invalid_request} = Parser.run(text)
  end
end
