defmodule VacationTracker.CommandHandler do
  use GenServer

  alias VacationTracker.Accounts
  alias VacationTracker.{Parser, Slack}

  def run(command_params) when is_tuple(command_params) do
    GenServer.call(__MODULE__, command_params)
  end

  def start_link(default) do
    GenServer.start_link(__MODULE__, default, name: __MODULE__)
  end

  def init(default) do
    {:ok, default}
  end

  def handle_call({:time_off, params}, from, _state) do
    Task.Supervisor.start_child(
      VacationTracker.TaskSupervisor,
      fn ->
        result = handle_command(:time_off, params)
        reply_caller(from, result)
      end,
      restart: :transient
    )

    {:noreply, nil}
  end

  defp reply_caller(from, result) do
    GenServer.reply(from, result)
  end

  def handle_command(:time_off, %{"text" => "help"} = params) do
    Parser.run(params["text"])
  end

  def handle_command(:time_off, params) do
    with {:ok, message} <- Parser.run(params["text"]),
      :ok <- process_user_info(params)
    do
      %{ok: message}
    else
      {:error, reason} -> %{error: reason}
    end
  end

  defp process_user_info(params) do
    case Accounts.find_user_by(:slack_id, params["user_id"]) do
      nil ->
        with {:ok, data} <- Slack.get_user_info(params["user_id"]),
             {:ok, _user} <- Accounts.create_user(
               user_attrs(data, params["token"])
             ) do
          :ok
        else
          {:error, reason} -> {:error, reason}
        end

      _user -> :ok
    end
  end

  defp user_attrs(data, token) do
    %{
      email: data["user"]["profile"]["email"],
      name: data["user"]["real_name"],
      slack_id: data["user"]["id"],
      slack_token: token
    }
  end
end
