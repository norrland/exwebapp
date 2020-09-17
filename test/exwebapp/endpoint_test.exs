defmodule Exwebapp.EndpointTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @opts Exwebapp.Endpoint.init([])

  test "it honks" do
    # Create test connection
    conn = conn(:get, "/honk") |> put_req_header("content-type", "text/plain")
    # Invoke the Plug
    conn = Exwebapp.Endpoint.call(conn, @opts)

    # Assert response and status.
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "HOOONK!"
    assert hd(get_req_header(conn,"content-type")) == "text/plain"
  end

  test "process events 200 on valid payload" do
    # Create test connection
    conn = conn(:post, "/events", %{events: [%{}]})
           |> put_req_header("content-type", "application/json")

    # Invoke the plug
    conn = Exwebapp.Endpoint.call(conn, @opts)

    # Assert the response
    assert conn.status == 200
  end

  test "process events 422 on invalid payload" do
    # Create test connection
    conn = conn(:post, "/events", %{})
           |> put_req_header("content-type", "application/json")

    # Invoke the plug
    conn = Exwebapp.Endpoint.call(conn, @opts)

    # Assert the response
    assert conn.status == 422
  end

  test "404 on invalid endpoint" do
    # Create test connection
    conn = conn(:get, "/aoetoansuh")

    # Invoke the Plug
    conn = Exwebapp.Endpoint.call(conn, @opts)

    # Assert response and status.
    assert conn.status == 404
  end
end
