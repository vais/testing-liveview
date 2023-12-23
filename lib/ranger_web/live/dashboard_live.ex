defmodule RangerWeb.DashboardLive do
  use RangerWeb, :live_view

  def render(assigns) do
    ~H"""
    <h1>Dashboard</h1>
    <.link data-role="page-link" navigate={~p"/team"}>Team</.link>
    """
  end
end
