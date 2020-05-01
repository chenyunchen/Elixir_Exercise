defmodule Exercise.Router do
  use Plug.Router

  plug(Plug.Logger)
  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Poison)
  plug(:dispatch)

  def init(opts) do
    Counter.start_run
    {:ok, opts}
  end

  post "/vote" do
    {status, body} =
      case conn.body_params do
        %{"agree" => opinion} -> {200, handle_opinion(opinion)}
        _ -> {422, miss_opinion()}
      end

    send_resp(conn, status, body)
  end

  defp handle_opinion(opinion) when is_boolean(opinion) do
    if opinion do
      Counter.record_agree
    else
      Counter.record_disagree
    end
    Poison.encode!(%{message: "Vote Success!"})
  end

  defp handle_opinion(_) do
    Poison.encode!(%{error: "Please Send your opinion!"})
  end

  defp miss_opinion do
    Poison.encode!(%{error: "Expected Payload: { 'agree': [...] }"})
  end

  get "/vote" do
    opinions = Counter.report_results
    body = Poison.encode!(opinions)
    send_resp(conn, 200, body)
  end

  match _ do
    send_resp(conn, 404, "404 Not Found")
  end
end
