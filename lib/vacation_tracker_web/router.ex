defmodule VacationTrackerWeb.Router do
  use VacationTrackerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", VacationTrackerWeb do
    pipe_through :api

    post "/commands/time_off", CommandController, :time_off
  end

  # Other scopes may use custom stacks.
  # scope "/api", VacationTrackerWeb do
  #   pipe_through :api
  # end
end
