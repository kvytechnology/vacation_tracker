defmodule VacationTracker.Slack do
  def get_user_info(user_id) do
    url = user_info_url(user_id)

    with {:ok, %HTTPoison.Response{body: body}} <- HTTPoison.get(url),
      {:ok, data} <- Jason.decode(body)
    do
      {:ok, data}
    else
      _ -> {:error, :invalid_request}
    end
  end

  defp bot_token do
    Application.get_env(:vacation_tracker, :slack)[:bot_token]
  end

  defp base_url do
    Application.get_env(:vacation_tracker, :slack)[:base_url]
  end

  defp user_info_url(user_id) do
    "#{base_url()}/api/users.info?token=#{bot_token()}&user=#{user_id}"
  end
end
