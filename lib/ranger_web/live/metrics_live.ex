defmodule RangerWeb.MetricsLive do
  use RangerWeb, :live_view

  def mount(params, _session, socket) do
    socket
    |> assign_async(:metrics, fn -> compute_metrics(params) end)
    |> ok()
  end

  defp compute_metrics(_params = %{"__test_metrics_fail__" => _}) do
    {:error, "oops"}
  end

  defp compute_metrics(_params = %{}) do
    Process.sleep(500)
    {:ok, %{metrics: %{name: "Strength", value: 9000}}}
  end

  def render(assigns) do
    ~H"""
    <div :if={@metrics.loading} data-role="loading">Loading...</div>
    <div :if={@metrics.result} data-role="result"><%= inspect(@metrics) %></div>
    <div :if={@metrics.failed} data-role="failed">Something went terribly wrong</div>
    """
  end
end
