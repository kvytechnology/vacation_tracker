defmodule VacationTracker.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias VacationTracker.{CommandHandler, Repo, Slack}
  alias VacationTrackerWeb.Endpoint

  def start(_type, args) do
    default = [
      Repo,
      Endpoint,
      CommandHandler,
      {Task.Supervisor, name: VacationTracker.TaskSupervisor}
    ]

    children =
      case args do
        [env: :test] ->
          [
            {
              Plug.Cowboy,
              scheme: :http,
              plug: Slack.MockServer, options: [port: 8081]
            }
          ] ++ default

        _ -> default
      end

    opts = [strategy: :one_for_one, name: VacationTracker.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Endpoint.config_change(changed, removed)
    :ok
  end
end
