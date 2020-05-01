defmodule Exercise.RouterTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @opts Exercise.Router.init([])

  test "It returns vote result" do
    # Create a test connection
    conn = conn(:get, "/vote")

    # Invoke the plug
    conn = Exercise.Router.call(conn, @opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 200
  end

  test "It returns 200 with a valid payload" do
    # Create a test connection
    conn = conn(:post, "/vote", %{agree: [%{}]})

    # Invoke the plug
    conn = Exercise.Router.call(conn, @opts)

    # Assert the response
    assert conn.status == 200
  end

  test "It returns 422 with an invalid payload" do
    # Create a test connection
    conn = conn(:post, "/vote", %{})

    # Invoke the plug
    conn = Exercise.Router.call(conn, @opts)

    # Assert the response
    assert conn.status == 422
  end

  test "It returns 404 when no route matches" do
    # Create a test connection
    conn = conn(:get, "/fail")

    # Invoke the plug
    conn = Exercise.Router.call(conn, @opts)

    # Assert the response
    assert conn.status == 404
  end
end
