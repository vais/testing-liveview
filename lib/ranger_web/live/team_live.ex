defmodule RangerWeb.TeamLive do
  use RangerWeb, :live_view

  def render(assigns) do
    ~H"""
    <h1>Team</h1>
    <.link data-role="page-link" navigate={~p"/dashboard"}>Dashboard</.link>
    """
  end
end
