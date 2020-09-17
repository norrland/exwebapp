defmodule Exwebapp.Endpoint do
  @moduledoc """
  A Plug responsible for logging request info, parsing request body's as JSON,
  matching routes, and dispatching responses.
  """

  require Logger

  use Plug.Router

  # Use Plug.Logger to log requests info.
  plug(Plug.Logger)
  # match routes
  plug(:match)

  # Use poison for decoding json
  plug(Plug.Parsers, parsers: [:json], json_decoder: Poison)
  # responsible for dispatching responses
  plug(:dispatch)

  # Test endpoint
  get "/honk" do
    {status, content_type, body} =
      # check the content-type header sent by the client
      case hd(get_req_header(conn, "content-type")) do
        "application/json" -> {200, "application/json", Poison.encode!(%{response: "HOOONK!"})}
        "text/plain" -> {200, "text/plain", "HOOONK!"}
        _ -> {200, "text/plain", "HÖÖÖNK!"}
      end

    conn
    |> put_resp_content_type(content_type)
    |> send_resp(status, body)
  end

  # Events endpoint
  post "/events" do
    # verify that 'application/json' is used
    if hd(get_req_header(conn, "content-type")) == "application/json" do
      {status, body} =
        case conn.body_params do
          %{"events" => events} -> {200, process_events(events)}
          _ -> {422, missing_events()}
        end

      send_resp(conn, status, body)
    else
      send_resp(conn, 400, "Invalid content-type")
    end
  end

  defp process_events(events) when is_list(events) do
    numevents = length(events)
    Poison.encode!(%{response: "Processed #{numevents} events."})
  end

  defp process_events(_) do
    Poison.encode!(%{response: "No events to process."})
  end

  defp missing_events do
    Poison.encode!(%{error: "Expected payload: { 'events': [...] }"})
  end

  # catch all endpoint
  match _ do
    send_resp(conn, 404, "oops. No page found")
  end
end
