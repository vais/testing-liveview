defmodule RangerWeb.GreetLive do
  use RangerWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    socket = assign(socket, :adjective, describes(socket))
    {:ok, socket}
  end

  defp describes(socket), do: socket |> connected? |> adjective
  defp adjective(_connected = false), do: "dead"
  defp adjective(_connected = true), do: "live"

  @impl true
  def render(assigns) do
    ~H"""
    <span><%= @adjective %> view</span>
    """
  end
end
