defmodule VacationTracker.Repo do
  use Ecto.Repo,
    otp_app: :vacation_tracker,
    adapter: Ecto.Adapters.Postgres
end
