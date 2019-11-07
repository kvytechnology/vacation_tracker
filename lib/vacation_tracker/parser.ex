defmodule VacationTracker.Parser do
  def run("help") do
    {:ok, "The message must exactly match: `from YYYY-MM-DD to YYYY-MM-DD, reason: text`"}
  end

  def run(message) do
    case String.split(message, ~r{(from )|( to )|(, reason: )}, parts: 4) do
      [_, from, to, reason] ->
        handle_message({from, to, reason})

      _ -> {:error, :invalid_request}
    end
  end

  def handle_message({from, to, _reason}) do
    with {:ok, from_date} <- Date.from_iso8601(from),
         {:ok, to_date} <- Date.from_iso8601(to),
         :lt <- Date.compare(from_date, to_date) do
      {:ok, :request_successfully}
    else
      _ -> {:error, :invalid_request}
    end
  end
end
