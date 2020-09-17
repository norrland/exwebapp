defmodule Exwebapp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false
  @app :exwebapp

  use Application

  require Logger

  def start(_type, _args) do
    # fetch which scheme to use ( see config/config.exs )
    scheme = Application.get_env(@app, :scheme)
    # fetch options for plug_cowboy
    options = Application.get_env(@app, :plug_cowboy)

    children = [
      Plug.Cowboy.child_spec(
        scheme: scheme,
        plug: Exwebapp.Endpoint, # point to where Plug.Router is used
        options: options[scheme]
      )
    ]

    Logger.info("App started, using #{scheme}.")

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Exwebapp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
